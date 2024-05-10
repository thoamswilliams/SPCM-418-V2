"""
Spectrum Instrumentation GmbH (c)

1_gen_single.py

Shows a simple standard mode example using only the few necessary commands.
- There will be a saw-tooth signal generated on channel 0.
- This signal will have an amplitude of 2 V and a period of 1.3 ms.

Example for analog replay cards (AWG) for the the M2p, M4i and M4x card-families.

See the README file in the parent folder of this examples directory for information about how to use this example.

See the LICENSE file for the conditions under which this software may be used and distributed.
"""

import spcm
from spcm import units

import numpy as np

def awg(ch0 = None, ch1 = None, amp0=1, amp1 = 1, t = 1e-2,
		sr=1.024e9, mode='continuous', loops=1, 
		trigger='sw', timeout=10):
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
    card : spcm.Card

    with spcm.Card('/dev/spcm0') as card:                         # if you want to open a specific card
    # with spcm.Card('TCPIP::192.168.1.10::inst0::INSTR') as card:  # if you want to open a remote card
    # with spcm.Card(serial_number=12345) as card:                  # if you want to open a card by its serial number
    #with spcm.Card(card_type=spcm.SPCM_TYPE_AO) as card:             # if you want to open the first card of a specific type
        
        # setup card
        if mode == 'continuous':
            card.card_mode(spcm.SPC_REP_STD_CONTINUOUS)
        elif mode == 'gate':
            card.card_mode(spcm.SPC_REP_STD_GATE)

        # Enable the channels and setup amplitude
        enable_mask=0 #2-bit mask where first bit is ch0 and second bit is ch1
        if(ch0):
            enable_mask+=1
        if(ch1):
            enable_mask+=2
        channels = spcm.Channels(card, card_enable = enable_mask)
        channel0 = spcm.Channel(0, card)
        channel1 = spcm.Channel(1, card)

        if(ch0):
            channel0.enable(True)
            channel0.output_load(50 * units.ohm) #50 ohm load
            channel0.amp(amp0 * units.V)
        if(ch1):
            channel1.enable(True)
            channel1.output_load(50 * units.ohm) #50 ohm load
            channel1.amp(amp1 * units.V)
        # Setup the clock
        clock = spcm.Clock(card)
        # set samplerate to 50 MHz (M4i) or 1 MHz (otherwise), no clock output
        clock.sample_rate(sr)
        clock.clock_output(0)

        num_samples = int(t * sr)
        assert num_samples % 32 == 0, f"number of samples must be divisible by 32, actual was {num_samples}"

        # setup the trigger mode
        trigger = spcm.Trigger(card)
        if(trigger == "sw"):
            trigger.or_mask(spcm.SPC_TMASK_SOFTWARE)
        elif(trigger == "ttl"):
            trigger.or_mask(spcm.SPC_TMASK_NONE) #disable default software trigger
            trigger.and_mask(spcm.SPC_TMASK_EXT0) # Enable external trigger within the AND mask
            trigger.ext0_level0(0*units.mV)
            trigger.ext0_level1(2000*units.mV)
            trigger.ext0_mode(spcm.SPC_TM_HIGH)

        data_transfer = spcm.DataTransfer(card)
        if data_transfer.bytes_per_sample != 2: raise spcm.SpcmException(text="Non 16-bit DA not supported")

        data_transfer.memory_size(num_samples)
        data_transfer.allocate_buffer(num_samples)

        if(mode == "continuous" or mode == "gate"):
            data_transfer.loops(0) # loop continuously
        else:
            data_transfer.loops(loops)
        
        time_seq = np.linspace(0, t, num=num_samples, dtype = np.float64)

		#single channel actions
        if(ch0 and not ch1):
            amp_seq = ch0(time_seq)
            amp_seq = np.multiply(2**15-1,amp_seq).astype(np.int16)

            data_transfer.buffer[:] = amp_seq
        if(ch1 and not ch0):
            amp_seq = ch1(time_seq)
            amp_seq = np.multiply(2**15-1,amp_seq).astype(np.int16)

            data_transfer.buffer[:] = amp_seq
		#if dual channel, then concatenate
        if(ch1 and ch0):
            amp_seq_0 = ch0(time_seq)
            amp_seq_0 = np.multiply(2**15-1,amp_seq_0).astype(np.int16)

            amp_seq_1 = ch1(time_seq)
            amp_seq_1 = np.multiply(2**15-1,amp_seq_1).astype(np.int16)

            data_transfer.buffer[0] = amp_seq_0
            data_transfer.buffer[1] = amp_seq_1

        data_transfer.start_buffer_transfer(spcm.M2CMD_DATA_STARTDMA, spcm.M2CMD_DATA_WAITDMA) # Wait for the writing to buffer being done

        # We'll start and wait until the card has finished or until a timeout occurs
        card.timeout(10 * units.s)
        print("Starting the card and waiting for ready interrupt\n(continuous and single restart will have timeout)")
        try:
            card.start(spcm.M2CMD_CARD_ENABLETRIGGER, spcm.M2CMD_CARD_WAITREADY)
            input("Press Enter to Exit")

        except spcm.SpcmTimeout as timeout:
            print("-> The 10 seconds timeout have passed and the card is stopped")

def sine_wave(t):
        t = np.sin(t * 2*np.pi * 1e6)
        return t

awg(ch0=sine_wave, ch1=sine_wave, timeout = 5)
