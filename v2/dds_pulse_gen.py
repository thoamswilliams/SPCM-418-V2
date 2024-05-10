"""  
Spectrum Instrumentation GmbH (c) 2024

1_dds_single_static_carrier.py

Single static carrier - This example shows the DDS functionality with 1 carrier with a fixed frequency and fixed amplitude

Example for analog replay cards (AWG) for the the M4i and M4x card-families with installed DDS option.

See the README file in the parent folder of this examples directory for information about how to use this example.

See the LICENSE file for the conditions under which this software may be used and distributed.
"""

import spcm
from spcm import units

def tone(ch0=[], ch1=[], amp0=1, amp1=1, loops=2, 
    trigger='sw', timeout = 30):
    """
    Generates and primes a pulse sequence.

    Parameters:
        ch0: pulse sequence for channel 0. The structure of a pulse sequence is: [f1, start1, end1, factor1,  
                                                                                    f2, start2, end2, factor2, ...]
        ch1: pulse sequence for channel 1. 

        **** Specify frequencies in Hz and times in seconds. The combined number of waveforms in the ch0 and ch1 
        pulse sequences should be no greater than the number of DDS cores. All factors should add up to 1 for each channel. ****

        amp0: amplitude of channel 0 in Volts
        amp1: amplitude of channel 1 in Volts
        
        loops: if continuous is false, the pulse seqeuence is played back this many times
        
        #TODO NOT IMPLEMENTED YET
        trigger: trigger type, ttl or sw (software, immediate)
        The only trigger currently implemented is software, with immediate activation. To implement TTL triggering, use the
        SPCM_DDS_TRG_SRC_CARD option from the manual.

    Returns: None
    """
    card : spcm.Card
    # with spcm.Card('/dev/spcm0') as card:                         # if you want to open a specific card
    # with spcm.Card('TCPIP::192.168.1.10::inst0::INSTR') as card:  # if you want to open a remote card
    # with spcm.Card(serial_number=12345) as card:                  # if you want to open a card by its serial number
    with spcm.Card(card_type=spcm.SPCM_TYPE_AO) as card:             # if you want to open the first card of a specific type

        #preprocess into events
        assert len(ch0) % 4 == 0, "pulse sequence must be in specified format"
        assert len(ch1) % 4 == 0, "pulse sequence must be in specified format"

        # setup card for DDS
        card.card_mode(spcm.SPC_REP_STD_DDS)

        # Setup the channels
        channels = spcm.Channels(card, card_enable=spcm.CHANNEL0 + spcm.CHANNEL1)
        channels[0].enable(True)
        channels[0].output_load(50 * units.ohm)
        channels[0].amp(amp0 * units.V)

        channels[1].enable(True)
        channels[1].output_load(50 * units.ohm)
        channels[1].amp(amp1 * units.V)
        card.write_setup()
        
        # Setup DDS functionality
        dds = spcm.DDS(card)
        dds.reset()

        '''
        The current implementation assigns a single DDS core to each frequency specified in
        either channel 0 or channel 1. On/off events are created for the times at which the
        core should be enabled or disabled, creating a queue that is processed sequentially
        using the DDS trigger as a timer.
        '''
        #preprocess pulses into DDS events
        num_freqs_0 = len(ch0)/4
        num_freqs_1 = len(ch1)/4
        # Assign cores. The input to each channel is a bitmap with num_cores() bits, where a 1 in position
        # i indicates that core i is assigned to that particular channel, and a 0 if otherwise.

        #all cores are set to ch0 by default. Only cores 8-19 can be set to ch1, in groups of 4 channels.
        #refer to pg. 139 of the manual for a full explanation

        num_cores_0 = max(8, 4 + (num_freqs_0 //4)*4) #round up to the next multiple of 4 cores. Also, first 8 cores must be ch0
        num_cores_1 = 4+(num_freqs_1 //4)*4
        assert num_cores_0 + num_cores_1 <= 20, "not enough DDS cores for the given waveform"
        assert num_cores_1 <= 12, "not enough DDS cores on ch1 for the given waveform"

        ch0_cores_mask = int(2**(num_cores_0)-1)

        ch1_cores_mask = int(2**(num_cores_0+num_cores_1)-1 - ch0_cores_mask)

        dds.cores_on_channel(1, ch1_cores_mask) #set bitmask for cores assigned to ch1: set bits between num_freqs_0 and num_freqs_1 to 1

        dds.load_cores()

        # pad after ch0 with negative numbers to account for the extra unused cores. This is somewhat questionable w.r.t. coding practices but probably the easiest way to handle them.
        num_core0_pad = int(num_cores_0 - num_freqs_0)

        freqs = ch0[0::4] + [-1]* num_core0_pad + ch1[0::4]
        start_times = ch0[1::4] + [-1]* num_core0_pad + ch1[1::4]
        end_times = ch0[2::4] +[-1]* num_core0_pad + ch1[2::4]
        factors = ch0[3::4] +[-1]* num_core0_pad + ch1[3::4]

        events = []
        for i in range(len(start_times)):
            #don't make events for padding cores
            if(start_times[i] < 0):
                continue
            event = ["on", i, start_times[i]] #format: on/off, core ID, time
            events.append(event)
        for i in range(len(end_times)):
            #don't make events for padding cores
            if(start_times[i] < 0):
                continue
            event = ["off", i, end_times[i]] #format: on/off, core ID, time
            events.append(event)
        
        events.sort(key = lambda i: i[2]) #sort in increasing order of time

        #convert from absolute time stamps to intervals
        new_times = [0]*len(events)
        for i in range(0,len(events)-1):
            new_times[i] = events[i+1][2] - events[i][2]
        for i in range(len(events)):
            events[i][2] = new_times[i]

        #setup the trigger
        dds.trg_src(spcm.SPCM_DDS_TRG_SRC_TIMER)
        # Run events
        for _ in range(loops):
            for event in events:
                core = event[1]
                if(event[0] == "off"):
                    dds[core].amp(0)
                elif(event[0] == "on"):
                    dds[core].amp(factors[core])
                    dds[core].freq(freqs[core])
                    dds[0].phase(0 * units.degrees)
                if(event[2] > 8.5e-8): #the minimum permissible trigger time is 83.2ns according to the manual (16-bit float). If the time is too short, run the next event immediately as well.
                    dds.trg_timer(event[2])
                    dds.exec_at_trg()
        #trigger one more time to make sure all events process
        dds.trg_timer(1e-7)
        dds.exec_at_trg()
        dds.write_to_card()
        print("DDS commands loaded and card started")
        # Start command including enable of trigger engine
        card.timeout(timeout*units.s)
        card.start(spcm.M2CMD_CARD_ENABLETRIGGER, spcm.M2CMD_CARD_FORCETRIGGER)

        input("Press Enter to Exit")

tone(ch0=[1e6, 0, 4, 0.25, 2e6, 0, 4, 0.25, 5e6, 2, 6, 0.5], 
        ch1=[1e6, 0, 4, 0.25, 2e6, 0, 4, 0.25, 5e6, 2, 6, 0.5], loops=2)
