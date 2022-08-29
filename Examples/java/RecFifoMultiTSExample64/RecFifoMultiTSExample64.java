import com.sun.jna.ptr.LongByReference;
import com.sun.jna.ptr.IntByReference;
import com.sun.jna.Pointer;
import com.sun.jna.Memory;
import java.io.*;

public class RecFifoMultiTSExample64 {

	public static void main (String[] args) throws IOException {
		
		SpcmDrv64 Spcm = new SpcmDrv64 ();
		
		long llToTransfer = 256 * 1024 * 1024; // Fifo transfer of 256 MB
		
		long llBufferSize = 32 * 1024 * 1024; // 32 MB 
	    int  lNotifySize  = 1024 * 1024;      //  1 MB
	    
	    long llTSBufferSize = 128 * 1024; // 128 kB
		int  lTSNotifySize  =   4 * 1024; //   4 kB
	    
		long llSegmentSize = 512 * 1024;
		
		int lError = 0;
		LongByReference oLongRefValue = new LongByReference ();
		IntByReference oErrorReg      = new IntByReference ();
		IntByReference oErrorValue    = new IntByReference ();
		Pointer pErrorTextBuffer = new Memory (SpcmDrv64.ERRORTEXTLEN);
		
		// open device
		String sDeviceString;
		
		// device string for a single card
		sDeviceString = "/dev/spcm0";
		
		// DigitizerNETBOX: Use VISA String as device string
		//sDeviceString = "TCPIP::XXX.XXX.XXX.XXX::INSTR0";
		
		long hDevice = Spcm.hOpen (sDeviceString);
		
		// read some general device infos
		long llCardType, llSN, llMaxSRate, llMaxMemory, llMaxChannels, llUsedSamplerate;
		int lBytesPerSample, lNumOfModules;
		
		// read device type
	    lError =  Spcm.lGetParam (hDevice, SpcmRegs.SPC_PCITYP, oLongRefValue);
	    llCardType = oLongRefValue.getValue ();
	    
	    // read serial number
		lError =  Spcm.lGetParam (hDevice, SpcmRegs.SPC_PCISERIALNO, oLongRefValue);
		llSN = oLongRefValue.getValue ();
		
		// read maximum sampling rate
		lError =  Spcm.lGetParam (hDevice, SpcmRegs.SPC_PCISAMPLERATE, oLongRefValue);
		llMaxSRate = oLongRefValue.getValue ();
		
		// read onboard memory
		lError =  Spcm.lGetParam (hDevice, SpcmRegs.SPC_PCIMEMSIZE, oLongRefValue);
		llMaxMemory = oLongRefValue.getValue ();
		
		// read number of modules
		lError = Spcm.lGetParam (hDevice, SpcmRegs.SPC_MIINST_MODULES, oLongRefValue);
		lNumOfModules = (int)oLongRefValue.getValue ();
		
		// read maximum channels per module
		lError = Spcm.lGetParam (hDevice, SpcmRegs.SPC_MIINST_CHPERMODULE, oLongRefValue);
        llMaxChannels = oLongRefValue.getValue ();
        
        llMaxChannels *= lNumOfModules;
        
        // read bytes per sample
        lError = Spcm.lGetParam (hDevice, SpcmRegs.SPC_MIINST_BYTESPERSAMPLE, oLongRefValue);
        lBytesPerSample = (int)oLongRefValue.getValue ();
        
		// plot general device infos
		System.out.println ("Type: 0x" + Integer.toHexString ((int)llCardType));
		System.out.println ("SN: " + llSN);
		System.out.println ("SRate: " + llMaxSRate / 1000 / 1000 + " MHz");
		System.out.println ("Memory: " + llMaxMemory / 1024 / 1024 + " MBytes");
		System.out.println ("Channels: " + llMaxChannels + "\n");
		
		// ----- setup card -----
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_CARDMODE, SpcmRegs.SPC_REC_FIFO_MULTI);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_CHENABLE, 1);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_SEGMENTSIZE, llSegmentSize);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_POSTTRIGGER, llSegmentSize - 32);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_CLOCKMODE, SpcmRegs.SPC_CM_INTPLL);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_CLOCKOUT, 0);
		
		// setup external trigger
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_TRIG_ORMASK, SpcmRegs.SPC_TMASK_EXT0);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_TRIG_ANDMASK, 0);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_TRIG_CH_ORMASK0, 0);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_TRIG_CH_ANDMASK0, 0);
		
		// setup external trigger mode
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_TRIG_EXT0_MODE, SpcmRegs.SPC_TM_POS);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_TRIGGER50OHM, 0);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_TRIG_EXT0_ACDC, SpcmRegs.COUPLING_DC);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_TRIG_EXT0_LEVEL0, 1500);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_TRIG_EXT0_LEVEL1, 0);
		
		// setup timestamp mode 
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_TIMESTAMP_CMD, SpcmRegs.SPC_TSMODE_STARTRESET | SpcmRegs.SPC_TSCNT_INTERNAL);

		// we try to set the samplerate to 100 kHz (M2i) or 20 MHz (M3i and M4i)
	    if (((llCardType & SpcmRegs.TYP_SERIESMASK) == SpcmRegs.TYP_M2ISERIES) || ((llCardType & SpcmRegs.TYP_SERIESMASK) == SpcmRegs.TYP_M2IEXPSERIES))
	    	lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_SAMPLERATE, 100000);
	    else if ((llCardType & SpcmRegs.TYP_SERIESMASK) == SpcmRegs.TYP_M2PEXPSERIES)
	    	lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_SAMPLERATE, 10000000);
	    else
	    	lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_SAMPLERATE, 20000000);
	    
	    lError = Spcm.lGetParam (hDevice, SpcmRegs.SPC_SAMPLERATE, oLongRefValue);
        llUsedSamplerate = oLongRefValue.getValue ();
	    
	    lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_TIMEOUT, 50000);
	    
	    // init data buffer
        Pointer pBuffer = new Memory (llBufferSize);
	    lError = Spcm.lDefTransfer (hDevice, SpcmDrv64.SPCM_BUF_DATA, SpcmDrv64.SPCM_DIR_CARDTOPC, lNotifySize, pBuffer, 0, llBufferSize);
	    
	    // init timestamp buffer
		Pointer pTSBuffer = new Memory (llTSBufferSize);
		lError = Spcm.lDefTransfer (hDevice, SpcmDrv64.SPCM_BUF_TIMESTAMP, SpcmDrv64.SPCM_DIR_CARDTOPC, lTSNotifySize, pTSBuffer, 0, llTSBufferSize);
		
		LongByReference oStatus = new LongByReference ();
        LongByReference oAvailUser = new LongByReference ();
        LongByReference olPCPos = new LongByReference ();
        LongByReference oTSAvailUser = new LongByReference ();
        LongByReference oTSPCPos = new LongByReference ();
        
        long llTSAvailBytes = 0;
        long llTotalData = 0;
        int lCountTS = 0;
        
        System.out.println ("Start Fifo acquisition of " + llToTransfer / 1024 / 1024 + " MBytes\n");
        
        // create files
        DataOutputStream oFileWriteData = new DataOutputStream (new FileOutputStream ("stream.bin"));
        FileWriter oFileWriteTS = new FileWriter ("timestamps.txt");
        
        // start timestamp polling mode
        lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_M2CMD, SpcmRegs.M2CMD_EXTRA_POLL);
        
        // start everything
        lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_M2CMD, SpcmRegs.M2CMD_CARD_START | SpcmRegs.M2CMD_CARD_ENABLETRIGGER | SpcmRegs.M2CMD_DATA_STARTDMA);
        
        System.out.println ("Wait for trigger ... ");
        
        // check error code and print error message
        if (lError != 0) {
        	Spcm.lGetErrorInfo (hDevice, oErrorReg, oErrorValue, pErrorTextBuffer);
        	System.out.println ("ErrorText: " + pErrorTextBuffer.getString (0));
            }
        else {
        	while (llTotalData < llToTransfer) {
        		
        		if ((lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_M2CMD, SpcmRegs.M2CMD_DATA_WAITDMA)) != SpcmErrors.ERR_OK) {
        			if (lError == SpcmErrors.ERR_TIMEOUT)
        				System.out.println ("Timeout !\n");
                    else
                    	System.out.println ("Error: " + lError + "\n");
                    break;
        		}
        		else {
        			
        			// ***** Read Data *****
        			Spcm.lGetParam (hDevice, SpcmRegs.SPC_M2STATUS,            oStatus);
        			Spcm.lGetParam (hDevice, SpcmRegs.SPC_DATA_AVAIL_USER_LEN, oAvailUser);
        			Spcm.lGetParam (hDevice, SpcmRegs.SPC_DATA_AVAIL_USER_POS, olPCPos);
        			
        			if (oAvailUser.getValue () >= lNotifySize) {
        				llTotalData += lNotifySize;
        				
        				//System.out.println (llTotalMem / 1024 /1024 + " MBytes transferred");
        				
        				// write data block to file
        				oFileWriteData.write (pBuffer.getByteArray (olPCPos.getValue (), lNotifySize), 0, lNotifySize);
        				
        				Spcm.lSetParam (hDevice, SpcmRegs.SPC_DATA_AVAIL_CARD_LEN, lNotifySize);
        			}
        			
        			
        			// ***** Read Timestamps *****
        			Spcm.lGetParam (hDevice, SpcmRegs.SPC_TS_AVAIL_USER_LEN, oTSAvailUser);
        			Spcm.lGetParam (hDevice, SpcmRegs.SPC_TS_AVAIL_USER_POS, oTSPCPos);
        			
        			llTSAvailBytes = oTSAvailUser.getValue ();
        			
        			if (llTSAvailBytes > 0) {
        				if (oTSPCPos.getValue () + llTSAvailBytes >= llTSBufferSize) 
        					llTSAvailBytes = llTSBufferSize - oTSPCPos.getValue ();
        			
        				// 1 timestamp = 128 Bit (16 Bytes)
        				lCountTS += llTSAvailBytes / 16;
        				
        				// convert timestamp data to 64 bit array
        				long llArrayTS[] = pTSBuffer.getLongArray (oTSPCPos.getValue (), (int)(llTSAvailBytes / 8));
 
        				// TS[n]   : TS Low
        				// TS[n+1] : TS High
        				// get timestamp counter values (Low parts) and calculate timestamp values in ms
        				// and store them to file
        				for (int lIdx = 0; lIdx < llTSAvailBytes / 8; lIdx += 2) {
        					int TS_Value_ms = (int)(((double)llArrayTS[lIdx] / (double)llUsedSamplerate) * 1000);
        					oFileWriteTS.write (TS_Value_ms + " ms\n");
        				}
        					
        				Spcm.lSetParam (hDevice, SpcmRegs.SPC_TS_AVAIL_CARD_LEN, llTSAvailBytes);
        			}
        			
        			System.out.println ("Transferred=> Data: " + llTotalData / 1024 /1024 + " MBytes" + ", TS Count: " + lCountTS);
        		}
        	}
        }
        
        // send the stop command
        lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_M2CMD, SpcmRegs.M2CMD_CARD_STOP | SpcmRegs.M2CMD_DATA_STOPDMA);
        
        oFileWriteData.close ();
        oFileWriteTS.close ();
        
        Spcm.vClose (hDevice);
        
        System.out.println ("\nReady !");
	}
}
