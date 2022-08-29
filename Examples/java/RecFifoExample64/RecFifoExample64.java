import com.sun.jna.ptr.LongByReference;
import com.sun.jna.ptr.IntByReference;
import com.sun.jna.Pointer;
import com.sun.jna.Memory;
import java.io.*;

public class RecFifoExample64 {

	public static void main (String[] args) throws IOException {
		
		SpcmDrv64 Spcm = new SpcmDrv64 ();
		
		long llToTransfer = 256 * 1024 * 1024; // Fifo transfer of 256 MB
		
		long llBufferSize = 32 * 1024 * 1024; // 32 MB 
	    int  lNotifySize  = 1024 * 1024;      //  1 MB
	    
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
		long llCardType, llSN, llMaxSRate, llMaxMemory, llMaxChannels;
		int lBytesPerSample, lNumOfModules, lNumActiveChannels;
		
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
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_CARDMODE, SpcmRegs.SPC_REC_FIFO_SINGLE);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_CHENABLE, 1);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_PRETRIGGER, 1024);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_TIMEOUT, 5000);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_TRIG_ORMASK, SpcmRegs.SPC_TMASK_SOFTWARE);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_TRIG_ANDMASK, 0);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_CLOCKMODE, SpcmRegs.SPC_CM_INTPLL);
		lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_CLOCKOUT, 0);
		
		// we try to set the samplerate to 100 kHz (M2i) or 20 MHz (M3i and M4i)
	    if (((llCardType & SpcmRegs.TYP_SERIESMASK) == SpcmRegs.TYP_M2ISERIES) || ((llCardType & SpcmRegs.TYP_SERIESMASK) == SpcmRegs.TYP_M2IEXPSERIES))
	    	lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_SAMPLERATE, 100000);
	    else if ((llCardType & SpcmRegs.TYP_SERIESMASK) == SpcmRegs.TYP_M2PEXPSERIES)
	    	lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_SAMPLERATE, 10000000);
	    else
	    	lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_SAMPLERATE, 20000000);
	        
	    // init data buffer
        Pointer pBuffer = new Memory (llBufferSize);
	    
        lError = Spcm.lDefTransfer (hDevice, SpcmDrv64.SPCM_BUF_DATA, SpcmDrv64.SPCM_DIR_CARDTOPC, lNotifySize, pBuffer, 0, llBufferSize);
	    
        LongByReference oStatus = new LongByReference ();
        LongByReference oAvailUser = new LongByReference ();
        LongByReference olPCPos = new LongByReference ();
        
        long llTotalMem = 0;
        
        System.out.println ("Start Fifo acquisition of " + llToTransfer / 1024 / 1024 + " MBytes\n");
        
        // create file
        DataOutputStream output = new DataOutputStream(new FileOutputStream ("stream.bin"));
        
        // start everything
        lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_M2CMD, SpcmRegs.M2CMD_CARD_START | SpcmRegs.M2CMD_CARD_ENABLETRIGGER | SpcmRegs.M2CMD_DATA_STARTDMA);
        
        // check error code and print error message
        if (lError != 0) {
        	Spcm.lGetErrorInfo (hDevice, oErrorReg, oErrorValue, pErrorTextBuffer);
        	System.out.println ("ErrorText: " + pErrorTextBuffer.getString (0));
            }
        else {
        	while (llTotalMem < llToTransfer) {
        		
        		if ((lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_M2CMD, SpcmRegs.M2CMD_DATA_WAITDMA)) != SpcmErrors.ERR_OK) {
        			if (lError == SpcmErrors.ERR_TIMEOUT)
        				System.out.println ("... Timeout\n");
                    else
                    	System.out.println ("... Error: " + lError + "\n");
                    break;
        		}
        		else {
        			
        			Spcm.lGetParam (hDevice, SpcmRegs.SPC_M2STATUS,            oStatus);
        			Spcm.lGetParam (hDevice, SpcmRegs.SPC_DATA_AVAIL_USER_LEN, oAvailUser);
        			Spcm.lGetParam (hDevice, SpcmRegs.SPC_DATA_AVAIL_USER_POS, olPCPos);
        			
        			if (oAvailUser.getValue () >= lNotifySize) {
        				llTotalMem += lNotifySize;
        				
        				System.out.println (llTotalMem / 1024 /1024 + " MBytes transferred");
        				
        				// write data block to file
        				output.write (pBuffer.getByteArray (olPCPos.getValue (), lNotifySize), 0, lNotifySize);
        				
        				Spcm.lSetParam (hDevice, SpcmRegs.SPC_DATA_AVAIL_CARD_LEN, lNotifySize);
        			}
        		}
        	}
        }
	
        // send the stop command
        lError = Spcm.lSetParam (hDevice, SpcmRegs.SPC_M2CMD, SpcmRegs.M2CMD_CARD_STOP | SpcmRegs.M2CMD_DATA_STOPDMA);
        
        output.close ();
        
        Spcm.vClose (hDevice);
        
        System.out.println ("\nReady !");
	}
}
