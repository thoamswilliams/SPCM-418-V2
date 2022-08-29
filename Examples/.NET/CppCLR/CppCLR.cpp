using namespace System;
using namespace System::Text;
using namespace System::Runtime::InteropServices;
using namespace Spcm;

int main(array<System::String ^> ^args)
    {
    IntPtr hDevice, pBuffer;
    GCHandle hBufferHandle;
    int lErrorVal, lCardType, lSerialNumber, lMaxChannels, lBytesPerSample, lValue;
    unsigned int dwErrorReg, dwErrorCode;
    __int64 llMemSet, llAverage, llInstMem, llMaxSamplerate;
    short nMin, nMax;
    array <short> ^pnData;
    array <signed char>  ^pbyData;

    StringBuilder ^sErrorText = gcnew StringBuilder(1024);

    llMemSet = 16384;

    // ----- open card -----
    hDevice = Drv::spcm_hOpen("/dev/spcm0");
    
    if ((int)hDevice == 0)
        {
        Console::WriteLine("Error: Could not open card\n");
        return 1;
        }

    // ----- get card type -----
    dwErrorCode = Drv::spcm_dwGetParam_i32(hDevice, Regs::SPC_PCITYP, lCardType);
    dwErrorCode = Drv::spcm_dwGetParam_i32(hDevice, Regs::SPC_PCISERIALNR, lSerialNumber);
    
    switch (lCardType & CardType::TYP_SERIESMASK)
        {
        case CardType::TYP_M2ISERIES:
            Console::WriteLine("M2i.{0:x} sn {1}\n", lCardType & CardType::TYP_VERSIONMASK, lSerialNumber);
            break;

        case CardType::TYP_M2IEXPSERIES:
            Console::WriteLine("M2i.{0:x}-Exp sn {1}\n", lCardType & CardType::TYP_VERSIONMASK, lSerialNumber);
            break;

        case CardType::TYP_M3ISERIES:
            Console::WriteLine("M3i.{0:x} sn {1}\n", lCardType & CardType::TYP_VERSIONMASK, lSerialNumber);
            break;

        case CardType::TYP_M3IEXPSERIES:
            Console::WriteLine("M3i.{0:x}-Exp sn {1}\n", lCardType & CardType::TYP_VERSIONMASK, lSerialNumber);
            break;

        case CardType::TYP_M4IEXPSERIES:
            Console::WriteLine("M4i.{0:x}-x8 sn {1}\n", lCardType & CardType::TYP_VERSIONMASK, lSerialNumber);
            break;

        case CardType::TYP_M4XEXPSERIES:
            Console::WriteLine("M4x.{0:x}-x4 sn {1}\n", lCardType & CardType::TYP_VERSIONMASK, lSerialNumber);
            break;

        case CardType::TYP_M2PEXPSERIES:
            Console::WriteLine("M2p.{0:x}-x4 sn {1}\n", lCardType & CardType::TYP_VERSIONMASK, lSerialNumber);
            break;

        default: Console::WriteLine("Typ: {0:x} not supported so far\n", lCardType);
            break;
        }
    
    // ----- get max memsize -----
    dwErrorCode = Drv::spcm_dwGetParam_i64(hDevice, Regs::SPC_PCIMEMSIZE, llInstMem);
    Console::WriteLine("  Installed memory  :  {0} MByte", llInstMem / 1024 / 1024);

    // ----- get max samplerate -----
    dwErrorCode = Drv::spcm_dwGetParam_i64(hDevice, Regs::SPC_MIINST_MAXADCLOCK, llMaxSamplerate);
    Console::WriteLine("  Max sampling rate :  {0} MS/s", llMaxSamplerate / 1000000);

    // ----- get max number of channels -----
    dwErrorCode = Drv::spcm_dwGetParam_i32(hDevice, Regs::SPC_MIINST_MODULES, lValue);
    dwErrorCode = Drv::spcm_dwGetParam_i32(hDevice, Regs::SPC_MIINST_CHPERMODULE, lMaxChannels);
    lMaxChannels *= lValue;
    Console::WriteLine("  Channels          :   {0}", lMaxChannels);

    // ----- get kernel version -----
    dwErrorCode = Drv::spcm_dwGetParam_i32(hDevice, Regs::SPC_GETKERNELVERSION, lValue);
    Console::WriteLine("  Kernel Version    : {0}.{1} build {2}", lValue >> 24, (lValue >> 16) & 0xff, lValue & 0xffff);

    // ----- get library version -----
    dwErrorCode = Drv::spcm_dwGetParam_i32(hDevice, Regs::SPC_GETDRVVERSION, lValue);
    Console::WriteLine("  Library Version   : {0}.{1} build {2}", lValue >> 24, (lValue >> 16) & 0xff, lValue & 0xffff);

    // ----- get bytes per sample -----
    dwErrorCode = Drv::spcm_dwGetParam_i32(hDevice, Regs::SPC_MIINST_BYTESPERSAMPLE, lBytesPerSample);

    // ----- setup card -----
    dwErrorCode = Drv::spcm_dwSetParam_i32(hDevice, Regs::SPC_AMP0, 1000);
    dwErrorCode = Drv::spcm_dwSetParam_i32(hDevice, Regs::SPC_CARDMODE, Regs::SPC_REC_STD_SINGLE);
    dwErrorCode = Drv::spcm_dwSetParam_i32(hDevice, Regs::SPC_CHENABLE, Regs::CHANNEL0);
    dwErrorCode = Drv::spcm_dwSetParam_i64(hDevice, Regs::SPC_MEMSIZE, llMemSet);
    dwErrorCode = Drv::spcm_dwSetParam_i64(hDevice, Regs::SPC_POSTTRIGGER, llMemSet/2);
    dwErrorCode = Drv::spcm_dwSetParam_i32(hDevice, Regs::SPC_CLOCKMODE, Regs::SPC_CM_INTPLL);
    dwErrorCode = Drv::spcm_dwSetParam_i32(hDevice, Regs::SPC_SAMPLERATE, 100000);
    dwErrorCode = Drv::spcm_dwSetParam_i32(hDevice, Regs::SPC_TRIG_ORMASK, Regs::SPC_TMASK_SOFTWARE);
    
    // ----- check error code and print error message -----
    if (dwErrorCode)
        {
        Drv::spcm_dwGetErrorInfo_i32 (hDevice, dwErrorReg, lErrorVal, sErrorText);
        Console::WriteLine("\nError occurred : {0}", sErrorText);
        }
    
    // ----- start card and wait until acquisition has finished -----
    Console::Write("\n  Start acquisition ..... ");
    dwErrorCode = Drv::spcm_dwSetParam_i32 (hDevice, Regs::SPC_M2CMD, Regs::M2CMD_CARD_START | Regs::M2CMD_CARD_ENABLETRIGGER | Regs::M2CMD_CARD_WAITREADY);
    Console::WriteLine("done");
    
    // ----- set data transfer function -----
    if (lBytesPerSample == 2) 
        {
        // ----- 12, 14, 16 bit per sample -----
        pnData = gcnew array <short> ((int)llMemSet);

        // ----- lock memory -----
        hBufferHandle = GCHandle::Alloc(pnData, GCHandleType::Pinned);
        }
    else
        {
        // ----- 8 bit per sample -----
        pbyData = gcnew array <signed char> ((int)llMemSet);

        // ----- lock memory -----
        hBufferHandle = GCHandle::Alloc(pbyData, GCHandleType::Pinned);
        }

    // ----- get pointer to locked memory -----
    pBuffer = hBufferHandle.AddrOfPinnedObject();

    dwErrorCode = Drv::spcm_dwDefTransfer_i64(hDevice, Drv::SPCM_BUF_DATA, Drv::SPCM_DIR_CARDTOPC, 0, pBuffer, 0, lBytesPerSample * llMemSet);

    // ----- start DMA data transfer and wait until transfer has finished -----
    Console::Write("  Start data transfer ... ");
    dwErrorCode = Drv::spcm_dwSetParam_i32(hDevice, Regs::SPC_M2CMD, Regs::M2CMD_DATA_STARTDMA | Regs::M2CMD_DATA_WAITDMA);
    Console::WriteLine("done");

    // ----- get some data infos -----
    nMin = 32767;
    nMax = -32768;
    llAverage = 0;

    for (int i = 0; i < llMemSet; i++)
        {
        if (lBytesPerSample == 2)
            {
            if (pnData[i] < nMin) nMin = pnData[i];
            if (pnData[i] > nMax) nMax = pnData[i];
            llAverage += pnData[i];
            }
        else
            {
            if (pbyData[i] < nMin) nMin = pbyData[i];
            if (pbyData[i] > nMax) nMax = pbyData[i];
            llAverage += pbyData[i];
            }
        }

    llAverage = llAverage / llMemSet;

    Console::WriteLine("\n  Data Info:");
    Console::WriteLine("    Min value = {0}", nMin);
    Console::WriteLine("    Max value = {0}", nMax);
    Console::WriteLine("    Average   = {0}\n", llAverage);
            
    // ----- close card -----
    Drv::spcm_vClose (hDevice);

    return 0;
    }

