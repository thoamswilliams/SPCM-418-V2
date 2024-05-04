from pyspcm import *
from spcm_tools import *
import sys
import time
import numpy as np
import ctypes
import matplotlib.pyplot as plt

def sequence(ch0 = None, ch1 = None, amp0=1, amp1 = 1, t = 1e-2,
		sr=1.024e9, mode='continuous', loops=1, 
		trigger='sw', timeout=50):
		"""
		Generates and primes an arbitrary sequence in channel0.

		Parameters:
			ch0: function for channel 0. This should accept a numpy array of length num_samples,
			  containing times (0, t) and output an array of amplitudes in (-1,1). Ideally, this
			  function should be periodic with period t.
			ch1: function for channel 1. See above description.
			amp0: amplitude of channel 0 in Volts
			amp1: amplitude of channel 1 in Volts  
			t: period of the sequence, in seconds
			sr: sample rate in Hz (max 1.25 GHz)
			mode: options are "continuous", "gate", or any other value to play the set 
			number of loops
			loops: if mode is not continuous or gate, the pulse seqeuence is played back this many times
			
			trigger: trigger type is sw (software, immediate), or ttl (external)
			timeout: closes card if not triggered within this many seconds

		Returns: None
		"""
		if not (ch0 or ch1):
			return
		# translate values
		amp0 *= 1000
		amp1 *= 1000
		timeout *= 1000

		# open card
		hCard = spcm_hOpen(create_string_buffer (b'/dev/spcm0'))
		
		#number of samples must be divisible by 32.
		llMemSamples = int64 (int(t*sr))
		assert llMemSamples & 32 == 0, "number of samples must be divisible by 32"

		spcm_dwSetParam_i64(hCard, SPC_SAMPLERATE,  int(sr)) 		# set samplerate
		spcm_dwSetParam_i32(hCard, SPC_CLOCKOUT, 0)				# no clock output
		spcm_dwSetParam_i32(hCard, SPC_AMP0, int32 (amp0))	# sets amplitude in mV
		spcm_dwSetParam_i32(hCard, SPC_AMP1, int32 (amp1))	# sets amplitude in mV


		if mode == 'continuous':
			loops = int64(0)
			spcm_dwSetParam_i32 (hCard, SPC_CARDMODE, SPC_REP_STD_CONTINUOUS)
		elif mode == 'gate':
			loops = int64(0)
			spcm_dwSetParam_i32 (hCard, SPC_CARDMODE, SPC_REP_STD_GATE)
		else:
			loops = int64(loops) #EP

		qwChEnable = 0
		lSetChannels = 0
		if ch0:
			qwChEnable += 1
			lSetChannels += 1
		if ch1:
			qwChEnable += 2
			lSetChannels += 1


		spcm_dwSetParam_i64 (hCard, SPC_CHENABLE, qwChEnable) # enable channel appropriate channels
		spcm_dwSetParam_i64 (hCard, SPC_MEMSIZE, llMemSamples) # memsize in samples per channel
		spcm_dwSetParam_i64 (hCard, SPC_LOOPS, loops)

		mem_size = int64(0)
		spcm_dwGetParam_i64 (hCard, SPC_MEMSIZE, byref(mem_size))

		# enable channel output
		if qwChEnable==1:
			spcm_dwSetParam_i64 (hCard, SPC_ENABLEOUT0,  1) 	
			spcm_dwSetParam_i64 (hCard, SPC_ENABLEOUT1,  0) 	
		elif qwChEnable==2:	
			spcm_dwSetParam_i64 (hCard, SPC_ENABLEOUT0,  0) 	
			spcm_dwSetParam_i64 (hCard, SPC_ENABLEOUT1,  1) 	
		elif qwChEnable==3:
			spcm_dwSetParam_i64 (hCard, SPC_ENABLEOUT0,  1) 			
			spcm_dwSetParam_i64 (hCard, SPC_ENABLEOUT1,  1)

		lBytesPerSample = int32 (0) #bytes per sample is usually 2
		spcm_dwGetParam_i32 (hCard, SPC_MIINST_BYTESPERSAMPLE,  byref (lBytesPerSample))

		# setup the trigger mode
		if trigger == 'sw':
			# software trigger: play immediately
			spcm_dwSetParam_i32 (hCard, SPC_TRIG_ORMASK,      SPC_TMASK_SOFTWARE) 
			spcm_dwSetParam_i32 (hCard, SPC_TRIG_ANDMASK,     0)
			spcm_dwSetParam_i32 (hCard, SPC_TRIG_CH_ORMASK0,  0)
			spcm_dwSetParam_i32 (hCard, SPC_TRIG_CH_ORMASK1,  0)
			spcm_dwSetParam_i32 (hCard, SPC_TRIG_CH_ANDMASK0, 0)
			spcm_dwSetParam_i32 (hCard, SPC_TRIG_CH_ANDMASK1, 0)
			spcm_dwSetParam_i32 (hCard, SPC_TRIGGEROUT,       0)
		elif trigger == 'ttl':
			spcm_dwSetParam_i32(hCard, SPC_TRIG_ORMASK, SPC_TMASK_NONE)  #disable default software trigger
			spcm_dwSetParam_i32(hCard, SPC_TRIG_ANDMASK, SPC_TMASK_EXT0)  # Enable external trigger within the AND mask
			spcm_dwSetParam_i32(hCard, SPC_TRIG_EXT0_LEVEL0, 2000)	# Trigger level is 2.0 V (2000 mV)
			spcm_dwSetParam_i32(hCard, SPC_TRIG_EXT0_MODE, SPC_TM_HIGH)  # Setting up external trigger for HIGH level
		
		#generate the data
		start = time.time()

		# setup software buffer
		# buffer size = samples per channel * bytes per sample * number of channels
		#buffer size must be a multiple of 32
		qwBufferSize = uint64(llMemSamples.value * lBytesPerSample.value * lSetChannels)

		pvBuffer = pvAllocMemPageAligned (qwBufferSize.value)
		pnBuffer = cast(pvBuffer, ptr16) # cast to int16 pointer

		np_buffer = np.ctypeslib.as_array(pnBuffer, shape=(llMemSamples.value * lSetChannels,))

		#generate a sequence (use 64-bit immediates)
		time_seq = np.linspace(0, t, num=llMemSamples.value, dtype = np.float64)

		#single channel actions
		if(ch0 and not ch1):
			amp_seq = ch0(time_seq)
		if(ch1 and not ch0):
			amp_seq = ch1(time_seq)
		#if dual channel, then concatenate
		if(ch1 and ch0):
			amp_seq_0 = ch0(time_seq)
			amp_seq_1 = ch1(time_seq)
			amp_seq = np.concatenate((amp_seq_0, amp_seq_1))

		#convert to int32 to send to the card
		amp_seq = np.multiply(2**15-1,amp_seq).astype(np.int16)

		#amp_seq = 0.5*np.sin((time_seq *(80e6*2) % 2) * np.pi)
		#amp_seq = amp_seq + 0.5*np.sin((time_seq *(85e6*2) % 2) * np.pi)
		
		#send to the provided buffer
		np.add(np_buffer, amp_seq, out = np_buffer)
		
		#print(np_buffer)
		end = time.time()
		print('CALC TIME: {:.3f}'.format(end-start))

		# Data Transfer **********************************************************************
		start = time.time()

		# define the buffer for transfer and start the DMA transfer
		spcm_dwDefTransfer_i64 (hCard, SPCM_BUF_DATA, SPCM_DIR_PCTOCARD, int32 (0), pnBuffer, uint64 (0), qwBufferSize)

		spcm_dwSetParam_i32 (hCard, SPC_M2CMD, M2CMD_DATA_STARTDMA | M2CMD_DATA_WAITDMA)

		end = time.time()
		print('TRANS TIME: {:.3f}'.format(end-start))

		# Card Start *************************************************************************
		spcm_dwSetParam_i32 (hCard, SPC_TIMEOUT, timeout)
		dwError = spcm_dwSetParam_i32 (hCard, SPC_M2CMD, M2CMD_CARD_START | M2CMD_CARD_ENABLETRIGGER) #| M2CMD_CARD_WAITREADY)

		# check for error
		if dwError != ERR_OK:
			szErrorTextBuffer = create_string_buffer (ERRORTEXTLEN)
			spcm_dwGetErrorInfo_i32 (hCard, None, None, szErrorTextBuffer)
			print("Error occurred!\n{0}\n".format(szErrorTextBuffer.value))

			spcm_dwSetParam_i32(hCard, SPC_M2CMD, M2CMD_CARD_STOP)
			spcm_dwSetParam_i32(hCard, SPC_M2CMD, M2CMD_CARD_FORCETRIGGER)

		print('Card Started')
		spcm_vClose (hCard)

sequence()
