from pyspcm import *
from spcm_tools import *
import sys
import time
import numpy as np
import ctypes
import matplotlib.pyplot as plt

def sequence(ch0=[], amp0=1, t = 1e-2,
		sr=1.25e9, mode='continuous', loops=1, 
		trigger='sw', timeout=50):
		"""
		Generates and primes an arbitrary sequence in channel0.

		Parameters:
			ch0: sequence for channel 0. The structure of a pulse sequence is: 
			amp0: amplitude of channel 0 in Volts  
			t: period of the sequence, in seconds
			sr: sample rate in Hz (max 1.25 GHz)
			continuous: continuous playback after trigger
			loops: if continuous is false, the pulse seqeuence is played back this many times
			
			trigger: trigger type is sw (software, immediate)
			timeout: closes card if not triggered within this many seconds

		Returns: None
		"""

		# translate values
		amp0 *= 1000
		timeout *= 1000

		# open card
		hCard = spcm_hOpen(create_string_buffer (b'/dev/spcm0'))
		
		#total number of samples must be divisible by 32. This is an easy way of enforcing that.
		sr = sr - (sr % 128)
		llMemSamples = int64 (int(t*sr))
		spcm_dwSetParam_i64(hCard, SPC_SAMPLERATE,  int(sr)) 		# set samplerate
		spcm_dwSetParam_i32(hCard, SPC_CLOCKOUT,    0)				# no clock output
		spcm_dwSetParam_i32(hCard, SPC_AMP0,    	int32 (amp0))	# sets amplitude in mV

		if mode == 'continuous':
			loops = int64(0)
			spcm_dwSetParam_i32 (hCard, SPC_CARDMODE, SPC_REP_STD_CONTINUOUS)
		elif mode == 'gate':
			loops = int64(0)
			spcm_dwSetParam_i32 (hCard, SPC_CARDMODE, SPC_REP_STD_GATE)
		else:
			loops = int64(loops) #EP

		qwChEnable = 1
		spcm_dwSetParam_i64 (hCard, SPC_CHENABLE, qwChEnable) # enable channel appropriate channels
		spcm_dwSetParam_i64 (hCard, SPC_MEMSIZE, llMemSamples) # memsize in samples per channel
		spcm_dwSetParam_i64 (hCard, SPC_LOOPS, loops)

		mem_size = int64(0)
		spcm_dwGetParam_i64 (hCard, SPC_MEMSIZE, byref(mem_size))

		# enable channel output
		spcm_dwSetParam_i64 (hCard, SPC_ENABLEOUT0,  1) 	
		spcm_dwSetParam_i64 (hCard, SPC_ENABLEOUT1,  0)

		lBytesPerSample = int32 (0)
		spcm_dwGetParam_i32 (hCard, SPC_MIINST_BYTESPERSAMPLE,  byref (lBytesPerSample))

		# setup the trigger mode
		if trigger == 'sw':
			# software trigger: play immediately
			spcm_dwSetParam_i32 (hCard, SPC_TRIG_ORMASK, SPC_TMASK_SOFTWARE) 
		
		#generate the data
		start = time.time()

		# setup software buffer
		# buffer size = samples per channel * bytes per sample * number of channels
		#buffer size must be a multiple of 32
		qwBufferSize = uint64(llMemSamples.value * lBytesPerSample.value)

		pvBuffer = pvAllocMemPageAligned (qwBufferSize.value)
		pnBuffer = cast(pvBuffer, ptr16) # cast to int16 pointer

		np_buffer = np.ctypeslib.as_array(pnBuffer, shape=(llMemSamples.value,))
		time_seq = np.linspace(0, t, num=llMemSamples.value, dtype = np.float64)
		amp_seq = 0.5*np.sin((time_seq *(80e6*2) % 2) * np.pi)
		amp_seq = amp_seq + 0.5*np.sin((time_seq *(85e6*2) % 2) * np.pi)
		#time_seq_32 = np.linspace(0, t, num=llMemSamples.value, dtype = np.float32)
		#amp_seq_32 = np.sin((time_seq_32 *(80e6*2)) * np.pi)
		
		#print(np.mean((amp_seq - amp_seq_32)**2)**0.5)
		#print(len(amp_seq))
		#plt.plot(time_seq[-50:], amp_seq[-50:], label = "64 bit")
		#plt.plot(time_seq_32[-50:], amp_seq_32[-50:], label = "32 bit")
		#plt.legend()
		#plt.show()
		amp_seq = np.multiply(2**15-1,amp_seq).astype(np.int16)
		

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
