import com.sun.jna.ptr.LongByReference;
import com.sun.jna.ptr.IntByReference;
import com.sun.jna.Pointer;
import com.sun.jna.Memory;

public class RecStdExample64 {

	public static void main (String[] args) {
		
		SpcmDrv64 Spcm = new SpcmDrv64 ();
		
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
		long llPciType, llSN, llMaxSRate, llMaxMemory, llMaxChannels;
		int lBytesPerSample, lNumOfModules, lNumActiveChannels;
		
		// read device type
	    lError =  Spcm.lGetParam (hDevice, SpcmRegs.SPC_PCITYP, oLongRefValue);
	    llPciType = oLongRefValue.getValue ();
	    
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
		System.out.println ("Type: 0x" + Integer.toHexString ((int)llPciType));
		System.out.println ("SN: " + llSN);
		System.out.println ("SRate: " + llMaxSRate / 1000 / 1000 + " MHz");
		System.out.println ("Memory: " + llMaxMemory / 1024 / 1024 + " MBytes");
		System.out.println ("Channels: " + llMaxChannels);
		
		// ----- setup card -----
		long llMemsize = 16*1024; // 16kS
		long llSamplerate = 1000000; // 1 MS/s
		
		// set channel enable mask, example supports up to 4 active channels
		if (llMaxChannels > 4)
			llMaxChannels = 4;
		long llChMask = (1 << llMaxChannels) - 1;
		
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_CARDMODE,    SpcmRegs.SPC_REC_STD_SINGLE);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_CHENABLE,    llChMask);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_MEMSIZE,     llMemsize);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_POSTTRIGGER, llMemsize / 2);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_SAMPLERATE,  llSamplerate);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_CLOCKMODE,   SpcmRegs.SPC_CM_INTPLL);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_TRIG_ORMASK, SpcmRegs.SPC_TMASK_SOFTWARE);
		
		// read back sampling rate
		lError = Spcm.lGetParam (hDevice, SpcmRegs.SPC_SAMPLERATE, oLongRefValue);
		llSamplerate = oLongRefValue.getValue ();
		
		// read number of active channels
		lError = Spcm.lGetParam (hDevice, SpcmRegs.SPC_CHCOUNT, oLongRefValue);
		lNumActiveChannels = (int)oLongRefValue.getValue ();
		
		// set channels
		for (int lChIdx = 0; lChIdx < llMaxChannels; lChIdx++) {
			lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_AMP0  + lChIdx * 100, 1000);
			lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_OFFS0 + lChIdx * 100, 0);
		}
		
		// check error code and print error message
        if (lError != 0) {
        	Spcm.lGetErrorInfo (hDevice, oErrorReg, oErrorValue, pErrorTextBuffer);
        	System.out.println ("ErrorText: " + pErrorTextBuffer.getString (0));
            }
		
        // plot used sampling rate
        System.out.println ("\nSampling rate is set to " + llSamplerate / 1000000 + " MS/s");
        
        // start card and wait until acquisition has finished
        System.out.print ("\nStart acquisition ..... ");
        lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_M2CMD, SpcmRegs.M2CMD_CARD_START | SpcmRegs.M2CMD_CARD_ENABLETRIGGER | SpcmRegs.M2CMD_CARD_WAITREADY);
        System.out.println ("done");
        
        // calculate buffer size (bytes)
        long llBufSize = llMemsize * lNumActiveChannels * lBytesPerSample;
        
        // init data buffer
        Pointer pBuffer = new Memory (llBufSize);
        
        // start data transfer from device onboard memory to PC  
        lError = Spcm.lDefTransfer (hDevice, SpcmDrv64.SPCM_BUF_DATA, SpcmDrv64.SPCM_DIR_CARDTOPC, 0, pBuffer, 0, llBufSize);
        
        // start DMA and wait until transfer has finished
        System.out.print ("Start data transfer ... ");
        lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_M2CMD, SpcmRegs.M2CMD_DATA_STARTDMA | SpcmRegs.M2CMD_DATA_WAITDMA);
        System.out.println ("done\n");
        
        // calculate minimum and maximum values of the acquired data for each channel
        int lMin[] = new int[lNumActiveChannels];
        int lMax[] = new int[lNumActiveChannels];
        
        for (int lIdx = 0; lIdx < lNumActiveChannels; lIdx++) {
        	lMin[lIdx] = 32767;
        	lMax[lIdx] = -32768;
        }
        
        if (lBytesPerSample == 2) {
        	short[] nData = pBuffer.getShortArray (0, (int)llBufSize / 2);
        	
        	short nValue;
        	for (int lChIdx = 0; lChIdx < lNumActiveChannels; lChIdx++)
        		for (int lDataIdx = 0; lDataIdx < llMemsize; lDataIdx++) {
        			nValue = nData[lDataIdx * lNumActiveChannels + lChIdx];
        			if (nValue < lMin[lChIdx]) lMin[lChIdx] = nValue;
        			if (nValue > lMax[lChIdx]) lMax[lChIdx] = nValue;
        		}
        }
        else {
        	byte[] byData = pBuffer.getByteArray (0, (int)llBufSize);
        	
        	byte byValue;
        	for (int lChIdx = 0; lChIdx < lNumActiveChannels; lChIdx++)
        		for (int lDataIdx = 0; lDataIdx < llMemsize; lDataIdx++) {
        			byValue = byData[lDataIdx * lNumActiveChannels + lChIdx];
        			if (byValue < lMin[lChIdx]) lMin[lChIdx] = byValue;
        			if (byValue > lMax[lChIdx]) lMax[lChIdx] = byValue;
        		}
        			
        }
        	
        // plot min and max values
        for (int lChIdx = 0; lChIdx < lNumActiveChannels; lChIdx++) {
        	System.out.println ("Ch" + lChIdx + ":");
        	System.out.println ("  Min = " + lMin[lChIdx]);
        	System.out.println ("  Max = " + lMax[lChIdx] + "\n");
        }
        	
        Spcm.vClose (hDevice);
	}
}
