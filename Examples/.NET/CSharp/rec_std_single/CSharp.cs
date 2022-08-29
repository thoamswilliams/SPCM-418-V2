using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;
using Spcm;

namespace CSharp
    {
    class CSharp
        {
        static int Main()
            {
            IntPtr hDevice, pBuffer;
            GCHandle hBufferHandle;
            int lErrorVal, lCardType, lSerialNumber, lMaxChannels, lBytesPerSample, lValue;
            uint dwErrorReg, dwErrorCode;
            long i, llMemSet, llAverage, llInstMem, llMaxSamplerate;
            short nMin, nMax;
            short[] nData;
            sbyte[] byData;

            StringBuilder sErrorText = new StringBuilder(1024);

            llMemSet = 16384;

            // ----- open card -----
            hDevice = Drv.spcm_hOpen("/dev/spcm0");
            if (hDevice == IntPtr.Zero)
                {
                Console.WriteLine("Error: Could not open card\n");
                return 1;
                }

            // ----- get card type -----
            dwErrorCode = Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_PCITYP, out lCardType);
            dwErrorCode = Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_PCISERIALNR, out lSerialNumber);

            switch (lCardType & CardType.TYP_SERIESMASK)
                {
                case CardType.TYP_M2ISERIES:
                    Console.WriteLine("M2i.{0:x} sn {1}\n", lCardType & CardType.TYP_VERSIONMASK, lSerialNumber);
                    break;

                case CardType.TYP_M2IEXPSERIES:
                    Console.WriteLine("M2i.{0:x}-Exp sn {1}\n", lCardType & CardType.TYP_VERSIONMASK, lSerialNumber);
                    break;

                case CardType.TYP_M3ISERIES:
                    Console.WriteLine("M3i.{0:x} sn {1}\n", lCardType & CardType.TYP_VERSIONMASK, lSerialNumber);
                    break;

                case CardType.TYP_M3IEXPSERIES:
                    Console.WriteLine("M3i.{0:x}-Exp sn {1}\n", lCardType & CardType.TYP_VERSIONMASK, lSerialNumber);
                    break;

                case CardType.TYP_M4IEXPSERIES:
                    Console.WriteLine("M4i.{0:x}-x8 sn {1}\n", lCardType & CardType.TYP_VERSIONMASK, lSerialNumber);
                    break;

                case CardType.TYP_M4XEXPSERIES:
                    Console.WriteLine("M4x.{0:x}-x4 sn {1}\n", lCardType & CardType.TYP_VERSIONMASK, lSerialNumber);
                    break;

                case CardType.TYP_M2PEXPSERIES:
                    Console.WriteLine("M2p.{0:x}-x4 sn {1}\n", lCardType & CardType.TYP_VERSIONMASK, lSerialNumber);
                    break;

                default: Console.WriteLine("Typ: {0:x} not supported so far\n", lCardType);
                    break;
                }

            // ----- get max memsize -----
            dwErrorCode = Drv.spcm_dwGetParam_i64(hDevice, Regs.SPC_PCIMEMSIZE, out llInstMem);
            Console.WriteLine("  Installed memory  :  {0} MByte", llInstMem / 1024 / 1024);

            // ----- get max samplerate -----
            dwErrorCode = Drv.spcm_dwGetParam_i64(hDevice, Regs.SPC_MIINST_MAXADCLOCK, out llMaxSamplerate);
            Console.WriteLine("  Max sampling rate :  {0} MS/s", llMaxSamplerate / 1000000);

            // ----- get max number of channels -----
            dwErrorCode = Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_MIINST_MODULES, out lValue);
            dwErrorCode = Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_MIINST_CHPERMODULE, out lMaxChannels);
            lMaxChannels *= lValue;
            Console.WriteLine("  Channels          :   {0}", lMaxChannels);

            // ----- get kernel version -----
            dwErrorCode = Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_GETKERNELVERSION, out lValue);
            Console.WriteLine("  Kernel Version    : {0}.{1} build {2}", lValue >> 24, (lValue >> 16) & 0xff, lValue & 0xffff);

            // ----- get library version -----
            dwErrorCode = Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_GETDRVVERSION, out lValue);
            Console.WriteLine("  Library Version   : {0}.{1} build {2}", lValue >> 24, (lValue >> 16) & 0xff, lValue & 0xffff);

            // ----- get bytes per sample -----
            dwErrorCode = Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_MIINST_BYTESPERSAMPLE, out lBytesPerSample);

            // ----- setup card -----
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_AMP0, 1000);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_CARDMODE, Regs.SPC_REC_STD_SINGLE);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_CHENABLE, 1);

            // Hint : To program all 64 channels of a digital card, the following typecast is necessary
            //dwErrorCode = Drv.spcm_dwSetParam_i64(hDevice, Regs.SPC_CHENABLE, unchecked((long)0xFFFFFFFFFFFFFFFF)); 

            dwErrorCode = Drv.spcm_dwSetParam_i64(hDevice, Regs.SPC_MEMSIZE, llMemSet);
            dwErrorCode = Drv.spcm_dwSetParam_i64(hDevice, Regs.SPC_POSTTRIGGER, llMemSet/2);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_CLOCKMODE, Regs.SPC_CM_INTPLL);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_SAMPLERATE, 100000);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_TRIG_ORMASK, Regs.SPC_TMASK_SOFTWARE);
            
            // ----- check error code and print error message -----
            if (dwErrorCode != 0)
                {
                Drv.spcm_dwGetErrorInfo_i32 (hDevice, out dwErrorReg, out lErrorVal, sErrorText);
                Console.WriteLine("\nError occurred : {0}", sErrorText);
                }

            // ----- start card and wait until acquisition has finished -----
            Console.Write("\n  Start acquisition ..... ");
            dwErrorCode = Drv.spcm_dwSetParam_i32 (hDevice, Regs.SPC_M2CMD, Regs.M2CMD_CARD_START | Regs.M2CMD_CARD_ENABLETRIGGER | Regs.M2CMD_CARD_WAITREADY);
            Console.WriteLine("done");

            // ----- set data transfer function -----
            if (lBytesPerSample == 2) 
                {
                // ----- 12, 14, 16 bit per sample -----
                nData = new short[llMemSet];
                byData = null;

                // ----- lock memory -----
                hBufferHandle = GCHandle.Alloc(nData, GCHandleType.Pinned);
                }
            else
                {
                // ----- 8 bit per sample -----
                byData = new sbyte[llMemSet];
                nData = null;

                // ----- lock memory -----
                hBufferHandle = GCHandle.Alloc(byData, GCHandleType.Pinned);
                }

            // ----- get pointer to locked memory -----
            pBuffer = hBufferHandle.AddrOfPinnedObject();

            dwErrorCode = Drv.spcm_dwDefTransfer_i64(hDevice, Drv.SPCM_BUF_DATA, Drv.SPCM_DIR_CARDTOPC, 0, pBuffer, 0, (ulong)(lBytesPerSample * llMemSet));
                
            // ----- start DMA data transfer and wait until transfer has finished -----
            Console.Write("  Start data transfer ... ");
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_M2CMD, Regs.M2CMD_DATA_STARTDMA | Regs.M2CMD_DATA_WAITDMA);
            Console.WriteLine("done");
            
            // ----- get some data infos -----
            nMin = 32767;
            nMax = -32768;
            llAverage = 0;

            for (i = 0; i < llMemSet; i++)
                {
                if (lBytesPerSample == 2)
                    {
                    if (nData[i] < nMin) nMin = nData[i];
                    if (nData[i] > nMax) nMax = nData[i];
                    llAverage += nData[i];
                    }
                else
                    {
                    if (byData[i] < nMin) nMin = byData[i];
                    if (byData[i] > nMax) nMax = byData[i];
                    llAverage += byData[i];
                    }
                }

            llAverage = llAverage / llMemSet;

            Console.WriteLine("\n  Data Info:");
            Console.WriteLine("    Min value = {0}", nMin);
            Console.WriteLine("    Max value = {0}", nMax);
            Console.WriteLine("    Average   = {0}\n", llAverage);
            
            // ----- close card -----
            Drv.spcm_vClose (hDevice);

            return 0;
            }
        }
    }
