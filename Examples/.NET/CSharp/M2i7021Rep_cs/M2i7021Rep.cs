using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;
using Spcm;

namespace M2i7021Rep
    {
    class M2i7021Rep
        {
        static int Main()
            {
            IntPtr hDevice, pBuffer;
            GCHandle hBufferHandle;
            int lCardType, lSerialNumber, lMaxChannels, lSamplerate, lBytesPerSample, lWordsPerSample, lValue;
            uint dwErrorCode;
            long llChEnable, llMemInBytes;
            short[] nData;
            
            StringBuilder sErrorText = new StringBuilder(1024);

            llChEnable      = unchecked((long)0xFFFFFFFFFFFFFFFF);
            llMemInBytes    = 80000;
            lBytesPerSample = 8; // 64 channels used -> 8 *  8 bit
            lWordsPerSample = 4; // 64 channels used -> 4 * 16 bit
            lSamplerate     = 1000;

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

                default: Console.WriteLine("Typ: {0:x} not supported so far\n", lCardType);
                    break;
                }

            // ----- get max memsize -----
            dwErrorCode = Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_PCIMEMSIZE, out lValue);
            Console.WriteLine("  Installed memory  :  {0} MByte", lValue / 1024 / 1024);

            // ----- get max samplerate -----
            dwErrorCode = Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_MIINST_MAXADCLOCK, out lValue);
            Console.WriteLine("  Max sampling rate :  {0} MS/s", lValue / 1000000);

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

            dwErrorCode += Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_M2CMD,         Regs.M2CMD_CARD_RESET);
            dwErrorCode += Drv.spcm_dwSetParam_i64(hDevice, Regs.SPC_CHENABLE,      llChEnable);
            dwErrorCode += Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_CARDMODE,      Regs.SPC_REP_STD_SINGLE);
            dwErrorCode += Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_CLOCKMODE,     Regs.SPC_CM_INTPLL);
            dwErrorCode += Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_SAMPLERATE,    lSamplerate);
            dwErrorCode += Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_TRIG_ORMASK,   Regs.SPC_TMASK_SOFTWARE);
            dwErrorCode += Drv.spcm_dwSetParam_i64(hDevice, Regs.SPC_MEMSIZE,       llMemInBytes / lBytesPerSample);
            dwErrorCode += Drv.spcm_dwSetParam_i64(hDevice, Regs.SPC_LOOPS,         1);
            dwErrorCode += Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_CH0_STOPLEVEL, Regs.SPCM_STOPLVL_LOW);
            dwErrorCode += Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_CH1_STOPLEVEL, Regs.SPCM_STOPLVL_LOW);

            nData = new short[llMemInBytes / 2];

            int lCnt = 0;
            
            // ----- create same signal for all 64 channels -----
            for (int lIdx = 0; lIdx < (llMemInBytes / 2) - lWordsPerSample; lIdx += lWordsPerSample)
                {
                if ((lCnt % 2) == 0)
                    {
                    nData[lIdx]     = unchecked((short)0xFFFF);  // D15 - D0
                    nData[lIdx + 1] = unchecked((short)0xFFFF);  // D47 - D32
                    nData[lIdx + 2] = unchecked((short)0xFFFF);  // D31 - D16
                    nData[lIdx + 3] = unchecked((short)0xFFFF);  // D63 - D48
                    }
                else
                    {
                    nData[lIdx]     = 0x0000;  // D15 - D0
                    nData[lIdx + 1] = 0x0000;  // D47 - D32
                    nData[lIdx + 2] = 0x0000;  // D31 - D16
                    nData[lIdx + 3] = 0x0000;  // D63 - D48
                    }

                lCnt++;
                }

            // ----- lock memory -----
            hBufferHandle = GCHandle.Alloc(nData, GCHandleType.Pinned);

            // ----- get pointer to locked memory -----
            pBuffer = hBufferHandle.AddrOfPinnedObject();

            // ----- commit software data buffer -----
            dwErrorCode = Drv.spcm_dwDefTransfer_i64(hDevice, Drv.SPCM_BUF_DATA, Drv.SPCM_DIR_PCTOCARD, 0, pBuffer, 0, (ulong)(llMemInBytes));

            // ----- calculate complete replay time -----
            double dReplayTime = 1.0 / (double)lSamplerate * (double)(llMemInBytes / lBytesPerSample);

            // ----- start DMA transfer -----
            Console.Write("\n\n  Transfer Data to card ...........");
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_M2CMD, Regs.M2CMD_DATA_STARTDMA | Regs.M2CMD_DATA_WAITDMA);
            Console.WriteLine(" Done");

            // ----- start card replay -----
            Console.Write("  Start replay ({0} sec) .......", dReplayTime);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_M2CMD, Regs.M2CMD_CARD_START | Regs.M2CMD_CARD_ENABLETRIGGER | Regs.M2CMD_CARD_WAITREADY);
            Console.WriteLine(" Done\n");

            // ----- close card -----
            Drv.spcm_vClose (hDevice);

            return 0;
            }
        }
    }
