import com.sun.jna.Library;
import com.sun.jna.Memory;
import com.sun.jna.Native;
import com.sun.jna.Platform;
import com.sun.jna.Pointer;
import com.sun.jna.ptr.IntByReference;
import com.sun.jna.ptr.LongByReference;
import com.sun.jna.win32.StdCallLibrary;

public class SpcmDrv64 {
	
	public static final int ERRORTEXTLEN = 200;
	
	// defintions of the transfer direction
	public static final int SPCM_DIR_PCTOCARD = 0; // transfer from PC memory to card memory
	public static final int SPCM_DIR_CARDTOPC = 1; // transfer from card memory to PC memory
			
	// defintions of the different data buffers
	public static final int SPCM_BUF_DATA      = 1000; // main data buffer for acquired or generated samples
	public static final int SPCM_BUF_ABA       = 2000; // buffer for ABA data, holds the A-DATA (slow samples)
	public static final int SPCM_BUF_TIMESTAMP = 3000; // buffer for timestamps
	public static final int SPCM_BUF_LOG       = 4000; // write content of buffer to log file
	
	public interface SpcmWin64 extends StdCallLibrary {
		
		SpcmWin64 INSTANCE = (SpcmWin64)Native.loadLibrary (("spcm_win64"), SpcmWin64.class); 
		
		long spcm_hOpen (String sDeviceName);
		void spcm_vClose (long hDevice);
		int spcm_dwSetParam_i64  (long hDevice, int lRegister, long llValue);
		int spcm_dwGetParam_i64 (long hDevice, int lRegister, LongByReference pllValue);
		int spcm_dwDefTransfer_i64 (long hDevice, int lBufType, int lDirection, int lNotifySize, Pointer pDataBuffer, long llBrdOffs, long llTransferLen);
		int spcm_dwInvalidateBuf   (long hDevice, int lBufType);
		int spcm_dwGetErrorInfo_i32 (long hDevice, IntByReference plErrorReg, IntByReference plErrorValue, Pointer sErrorTextBuffer);
	}
	
	// Open Device
	public long hOpen (String sDeviceName) {
		return SpcmWin64.INSTANCE.spcm_hOpen (sDeviceName);	
	}
	
	// Close Device
	public void vClose (long hDevice) {
		SpcmWin64.INSTANCE.spcm_vClose (hDevice);
	}
	
	// Set Param
	public int lSetParam (long hDevice, int lRegister, long llValue) {
		return SpcmWin64.INSTANCE.spcm_dwSetParam_i64 (hDevice, lRegister, llValue);
	}
	
	// Get Param
	public int lGetParam (long hDevice, int lRegister, LongByReference pllValue) {
		return SpcmWin64.INSTANCE.spcm_dwGetParam_i64 (hDevice, lRegister, pllValue);
	}
	
	// Def Transfer
	public int lDefTransfer (long hDevice, int lBufType, int lDirection, int lNotifySize, Pointer pDataBuffer, long llBrdOffs, long llTransferLen) {
		return SpcmWin64.INSTANCE.spcm_dwDefTransfer_i64 (hDevice, lBufType, lDirection, lNotifySize, pDataBuffer, llBrdOffs, llTransferLen);
	}
	
	// Invalidate Buffer
	public int lInvalidateBuf (long hDevice, int lBufType) {
		return SpcmWin64.INSTANCE.spcm_dwInvalidateBuf (hDevice, lBufType);
	}
	
	// Get Error Info
	public int lGetErrorInfo (long hDevice, IntByReference plErrorReg, IntByReference plErrorValue, Pointer sErrorTextBuffer) {
		return SpcmWin64.INSTANCE.spcm_dwGetErrorInfo_i32 (hDevice, plErrorReg, plErrorValue, sErrorTextBuffer);
	}
}
