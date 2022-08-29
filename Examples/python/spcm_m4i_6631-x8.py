from pyspcm import *
from spcm_tools import *
import sys
import time
import matplotlib.pyplot as plt
import numpy as np

'''
To compile calc library: gcc -shared -o calc.so -fPIC calc.c
'''

class spcm_m4i_6631_x8:

	
	def __init__(self, cdll_loc):
		"""
		Construct new spcm_m4i_6631_x8 control object

		Parameters:
			cdll_loc: file path of cdll libraries for calculating waveform

		Returns: None
		"""
		# load C calc functions
		self.libc = CDLL(cdll_loc)

	def gen_ps(self, t, sr, ps0, ps1, buf, samples=10000):
		"""
		Generate pulse sequence 

		t: duration of pulse sequence
		sr: sample rate
		ps0: pulse sequence to channel 0
		ps2: pulse sequence to channel 1
		First, the buffer is filled with 0s. Next, each pulse is added to the existing buffer.
		Factor scales the wave with respect to max (factor<1). 
		Structure of a pulse sequence: [f1, start1, end1, factor1,  
										f2, start2, ...]
		"""
		n0 = len(ps0)
		n1 = len(ps1)
		if n0>0:	
			cps0 = (c_double*n0)(*ps0)
		else:
			cps0 = None
		if n1>0:	
			cps1 = (c_double*n1)(*ps1)
		else:
			cps1 = None
		self.libc.gen_ps(c_double(t), c_double(sr), 
							c_int(n0/4), c_int(n1/4), 
							c_double(sr), cps0, cps1, 
							c_int(samples), buf)

	def tone(self, ch0=[], ch1=[], amp0=1, amp1=1, 
		sr=1.25e9, continuous=False, loops=1, 
		trigger='ttl', trigger_level=2, timeout=1):
		"""
		Generates and primes a pulse sequence.

		Parameters:
			ch0: pulse sequence for channel 0. The structure of a pulse sequence is: [f1, start1, end1, factor1,  
																					 f2, start2, end2, factor2, ...]
			ch1: pulse sequence for channel 1.
			amp0: amplitude of channel 0 in Volts
			amp1: amplitude of channel 1 in Volts
			
			sr: sample rate in Hz (max 1.25 GHz)
			continuous: continuous playback after trigger
			loops: if continuous is false, the pulse seqeuence is played back this many times
			
			trigger: trigger type, ttl or sw (software, immediate)
			trigger_level: set trigger level in Volts
			timeout: closes card if not triggered within this many seconds

		Returns: None
		"""
		# translate values
		amp0 *= 1000
		amp1 *= 1000
		trigger_level *= 1000
		timeout *= 1000

		# open card
		hCard = spcm_hOpen(create_string_buffer (b'/dev/spcm0'))
		
		### find time of pulse sequence
		if ch0==[] and ch1==[]:
			return

		times = []
		qwChEnable = 0
		lSetChannels = 0 # number of active channels
		if ch0:
			times += ch0[2::4]
			qwChEnable += 1
			lSetChannels += 1
		if ch1:
			times += ch1[2::4]
			qwChEnable += 2
			lSetChannels += 1
		t = np.max(times)
		###

		llMemSamples = int64 (int(t*sr))
		spcm_dwSetParam_i64(hCard, SPC_SAMPLERATE,  int(sr)) 		# set samplerate
		spcm_dwSetParam_i32(hCard, SPC_CLOCKOUT,    0)				# no clock output
		spcm_dwSetParam_i32(hCard, SPC_AMP0,    	int32 (amp0))	# sets amplitude in mV
		spcm_dwSetParam_i32(hCard, SPC_AMP1,    	int32 (amp1))	# sets amplitude in mV

		if continuous:
			loops = 0
			spcm_dwSetParam_i32 (hCard, SPC_CARDMODE,    SPC_REP_STD_CONTINUOUS)
		else:
			llLoops = int64 (1) # loop once
		
		spcm_dwSetParam_i64 (hCard, SPC_CHENABLE,    qwChEnable)		# enable channel appropriate channels
		spcm_dwSetParam_i64 (hCard, SPC_MEMSIZE,     llMemSamples)		# memsize in samples per channel
		spcm_dwSetParam_i64 (hCard, SPC_LOOPS,       loops)				# number of times memeory is replayed, continuous if 0
		
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
	
		# bytes per sample in memory (e.g. 2 = 16 bit resolution)
		lBytesPerSample = int32 (0)
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
			spcm_dwSetParam_i32(hCard, SPC_TRIG_ORMASK, 		SPC_TMASK_NONE) 	#disable default software trigger
			spcm_dwSetParam_i32(hCard, SPC_TRIG_ANDMASK, 		SPC_TMASK_EXT0)		# Enable external trigger within the AND mask
			spcm_dwSetParam_i32(hCard, SPC_TRIG_EXT0_LEVEL0, 	2000)				# Trigger level is 2.0 V (2000 mV)
			spcm_dwSetParam_i32(hCard, SPC_TRIG_EXT0_MODE,		SPC_TM_HIGH)		# Setting up external trigger for HIGH level

		start = time.time()

		# setup software buffer
		# buffer size = samples per channel * bytes per sample * number of channels
		qwBufferSize = uint64 (llMemSamples.value * lBytesPerSample.value * lSetChannels)
		pvBuffer = pvAllocMemPageAligned (qwBufferSize.value)
		pnBuffer = cast(pvBuffer, ptr16) # cast to int16 pointer

		self.gen_ps(t, sr, ch0, ch1, pnBuffer)

		end = time.time()
		print('CALC TIME: {:.3f}'.format(end-start))

		# if False:
		# 	n = 1000
		# 	# n = int(3e4)
		# 	fix, ax = plt.subplots()
		# 	ax.plot(np.arange(n), pnBuffer[:n], '.k--')

		# 	x = np.linspace(0, n, 1e4)
		# 	# ax.plot(x, 32767*0.5*(np.sin(2*np.pi*200e6*x/sr) + np.sin(2*np.pi*201e6*x/sr)), 'r')
		# 	ax.plot(x, 32767*(np.sin(2*np.pi*200e6*x/sr) ), 'r')
		# 	plt.show()

		# if False:
		# 	n = 10000
		# 	fix, ax = plt.subplots()
		# 	x = np.fft.fftfreq(n) * sr
		# 	y = np.fft.fft(pnBuffer[0:n])
		# 	y = np.abs(y)
		# 	ax.plot(x, y)
		# 	ax.set_xlim(left=0)
		# 	ax.set_yscale('log')
		# 	ax.set_xlabel('Freqeuncy (Hz)')
		# 	ax.set_ylabel('FFT')
		# 	plt.show()


		start = time.time()

		# define the buffer for transfer and start the DMA transfer
		spcm_dwDefTransfer_i64 (hCard, SPCM_BUF_DATA, SPCM_DIR_PCTOCARD, int32 (0), pnBuffer, uint64 (0), qwBufferSize)
		spcm_dwSetParam_i32 (hCard, SPC_M2CMD, M2CMD_DATA_STARTDMA | M2CMD_DATA_WAITDMA)

		end = time.time()
		print('TRANS TIME: {:.3f}'.format(end-start))

		spcm_dwSetParam_i32 (hCard, SPC_TIMEOUT, timeout)
		dwError = spcm_dwSetParam_i32 (hCard, SPC_M2CMD, M2CMD_CARD_START | M2CMD_CARD_ENABLETRIGGER | M2CMD_CARD_WAITREADY)
		if dwError == ERR_TIMEOUT:
			print('TIMEOUT')
			spcm_dwSetParam_i32(hCard, SPC_M2CMD, M2CMD_CARD_FORCETRIGGER)
			spcm_dwSetParam_i32(hCard, SPC_M2CMD, M2CMD_CARD_STOP)
		else:
			print('TRIGGERED')

		spcm_vClose (hCard)

		# #if (spcm_dwGetErrorInfo_i32 (hDrv, NULL, NULL, szErrorText) != ERR_OK)
		# 	{
		# 	printf (szErrorText);
		# 	spcm_vClose (hDrv);
		# 	exi




sp = spcm_m4i_6631_x8('/home/lattice/Desktop/SPCM 418/Examples/python/calc.so')

pulse = [200e6, 0, 1e-3, 1 , 
		200e6, 2e-3, 4e-3, 0.5, 
		201e6, 2e-3, 4e-3, 0.5, 
		200e6, 5e-3, 7.5e-3, 1, 
		200e6, 9e-3, 10e-3, 1]
sp.tone(ch0 = pulse, ch1 = pulse, trigger='ttl')
# sp.tone()
