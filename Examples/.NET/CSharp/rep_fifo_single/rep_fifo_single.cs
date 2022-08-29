using System;
using System.Threading;
using System.Collections.Generic;
using System.Text;
using Spcm;
using System.Runtime.InteropServices;
using System.IO;

namespace SPCM_6XXX_Rep_Fifo
    {
    class SPCM_6XXX_Rep_Fifo
        {
        static uint m_dwBufferLen  = 16 * 1024 * 1024; // Buffer length = 16 MByte
        static uint m_dwNotifySize = 1024*1024;        // Nofify size   = 1 MByte
        static uint m_dwSamplerate = 1000000;     // Sample rate, will be changed depending on card series
        static bool m_bRunning     = true;

        public static void vThreadDo()
            {
            ConsoleKeyInfo oKeyInfo = Console.ReadKey(true);
            m_bRunning = false;
            }

        public static void vDoDataCalculation (short[] nBuffer, long llSampleStartPos, long llSamplesToCalculate, int lMaxDACValue)
            {
            long llBufIdx, i;

            double dSineXScale = 2.0 * 3.141 / (m_dwNotifySize / 2);

            i = 0;

            for (llBufIdx = llSampleStartPos; llBufIdx < (llSampleStartPos + llSamplesToCalculate); llBufIdx++)
                {
                nBuffer[llBufIdx] = (short)(lMaxDACValue * System.Math.Sin(dSineXScale * i));
                i++;
                }
            }

        static int Main()
            {
            IntPtr hDevice, pBuffer;
            GCHandle hBufferHandle;
            long llAvailUser, llUserPos, llCalcLen, llTransferredBytes, llValue;
            int lErrorVal, lCardType, lSerialNumber, lMaxChannels, lBytesPerSample, lMaxDACValue, lValue;
            uint dwErrorReg, dwErrorCode;
            short[] nBuffer;

            StringBuilder sErrorText = new StringBuilder(1024);

            llTransferredBytes = 0;

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
                    m_dwSamplerate = 1000000;     // Sample rate   = 1 MS
                    break;

                case CardType.TYP_M2IEXPSERIES:
                    Console.WriteLine("M2i.{0:x}-Exp sn {1}\n", lCardType & CardType.TYP_VERSIONMASK, lSerialNumber);
                    m_dwSamplerate = 1000000;     // Sample rate   = 1 MS
                    break;

                case CardType.TYP_M2PEXPSERIES:
                    Console.WriteLine("M2p.{0:x}-x4 sn {1}\n", lCardType & CardType.TYP_VERSIONMASK, lSerialNumber);
                    m_dwSamplerate = 1000000;     // Sample rate   = 1 MS
                    break;

                case CardType.TYP_M4IEXPSERIES:
                    Console.WriteLine("M4i.{0:x}-x8 sn {1}\n", lCardType & CardType.TYP_VERSIONMASK, lSerialNumber);
                    m_dwSamplerate = 100000000;     // Sample rate   = 100 MS
                    break;

                case CardType.TYP_M4XEXPSERIES:
                    Console.WriteLine("M4x.{0:x}-x4 sn {1}\n", lCardType & CardType.TYP_VERSIONMASK, lSerialNumber);
                    m_dwSamplerate = 100000000;     // Sample rate   = 100 MS
                    break;

                default: Console.WriteLine("Typ: {0:x} not supported so far\n", lCardType);
                    break;
                }

            // ----- get max memsize -----
            dwErrorCode = Drv.spcm_dwGetParam_i64(hDevice, Regs.SPC_PCIMEMSIZE, out llValue);
            Console.WriteLine("  Installed memory  :  {0} MByte", llValue / 1024 / 1024);

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

            // ----- get bytes per sample -----
            dwErrorCode = Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_MIINST_BYTESPERSAMPLE, out lBytesPerSample);

            // ----- get maximum DAC value -----
            dwErrorCode = Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_MIINST_MAXADCVALUE, out lMaxDACValue);

            // ----- setup card -----
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_CARDMODE, Regs.SPC_REP_FIFO_SINGLE);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_CHENABLE, 1);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_SEGMENTSIZE, 1024);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_LOOPS, 0);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_CLOCKMODE, Regs.SPC_CM_INTPLL);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_SAMPLERATE, (int)m_dwSamplerate);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_EXTERNOUT, 0);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_TRIG_ORMASK, Regs.SPC_TMASK_SOFTWARE);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_TRIG_ANDMASK, 0);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_TRIG_CH_ORMASK0, 0);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_TRIG_CH_ORMASK1, 0);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_TRIG_CH_ANDMASK0, 0);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_TRIG_CH_ANDMASK1, 0);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_TRIGGEROUT, 0);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_AMP0, 1000);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_OFFS0, 0);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_ENABLEOUT0, 1);
            if (lMaxChannels > 1)
                {
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_AMP1, 1000);
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_OFFS1, 0);
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_ENABLEOUT1, 1);
                }
            if (lMaxChannels > 2)
                {
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_AMP2, 1000);
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_OFFS2, 0);
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_ENABLEOUT2, 1);
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_AMP3, 1000);
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_OFFS3, 0);
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_ENABLEOUT3, 1);
                }
            if (lMaxChannels > 4)
                {
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_AMP4, 1000);
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_OFFS4, 0);
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_ENABLEOUT4, 1);
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_AMP5, 1000);
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_OFFS5, 0);
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_ENABLEOUT5, 1);
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_AMP6, 1000);
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_OFFS6, 0);
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_ENABLEOUT6, 1);
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_AMP7, 1000);
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_OFFS7, 0);
                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_ENABLEOUT7, 1);
                }

            // ----- check error code and print error message -----
            if (dwErrorCode != 0)
                {
                Drv.spcm_dwGetErrorInfo_i32(hDevice, out dwErrorReg, out lErrorVal, sErrorText);
                Console.WriteLine("\nError occurred : {0}", sErrorText);
                }

            // ----- alloc buffer memory -----
            nBuffer = new short[m_dwBufferLen / 2];

            // ----- get handle to locked buffer -----
            hBufferHandle = GCHandle.Alloc(nBuffer, GCHandleType.Pinned);

            // ----- get pointer to locked memory -----
            pBuffer = hBufferHandle.AddrOfPinnedObject();

            // ----- setup card for data transfer -----
            dwErrorCode = Drv.spcm_dwDefTransfer_i64(hDevice, Drv.SPCM_BUF_DATA, Drv.SPCM_DIR_PCTOCARD, m_dwNotifySize, pBuffer, 0, m_dwBufferLen);
            vDoDataCalculation (nBuffer, 0, m_dwBufferLen / 2, lMaxDACValue - 1);
            Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_DATA_AVAIL_CARD_LEN, (int)m_dwBufferLen);

            // now buffer is full of data and we start the transfer (output is not started yet), timeout is 1 second
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_TIMEOUT, 1000);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_M2CMD, Regs.M2CMD_DATA_STARTDMA | Regs.M2CMD_DATA_WAITDMA);

            Console.WriteLine("\n  ----- Press any key to stop Fifo mode -----\n");

            // ----- start thread to check key press event -----
            Thread poThread = new Thread(new ThreadStart(vThreadDo));
            poThread.Start ();

            // ----- start card -----
            Console.WriteLine("\n  Start Fifo Replay (Ch0, {0} MS)\n", (double)m_dwSamplerate / (1000 * 1000));
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_M2CMD, Regs.M2CMD_CARD_START | Regs.M2CMD_CARD_ENABLETRIGGER);

            // ----- fifo loop -----
            while (m_bRunning)
                {
                // ----- get number of available bytes -----
                Drv.spcm_dwGetParam_i64(hDevice, Regs.SPC_DATA_AVAIL_USER_LEN, out llAvailUser);

                if (llAvailUser >= m_dwNotifySize)
                    {
                    Drv.spcm_dwGetParam_i64(hDevice, Regs.SPC_DATA_AVAIL_USER_POS, out llUserPos);

                    if (((llUserPos + m_dwNotifySize) / 2) <= nBuffer.Length)
                        llCalcLen = m_dwNotifySize / 2;
                    else
                        llCalcLen = nBuffer.Length - (llUserPos / 2);

                    llTransferredBytes += llCalcLen * 2;

                    Console.Write ("\r  {0} MBytes transferred          ", llTransferredBytes / 1024 / 1024);

                    vDoDataCalculation (nBuffer, llUserPos / 2, llCalcLen, lMaxDACValue - 1);
                    dwErrorCode = Drv.spcm_dwSetParam_i64(hDevice, Regs.SPC_DATA_AVAIL_CARD_LEN, llCalcLen * 2);
                    }

                // ----- wait for the next buffer to be free -----
                if (dwErrorCode == 0)
                    dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_M2CMD, Regs.M2CMD_DATA_WAITDMA);
                }

            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_M2CMD, Regs.M2CMD_CARD_STOP);

            Console.WriteLine("\n\n  Fifo mode stopped.\n\n");

            // ----- close card -----
            Drv.spcm_vClose (hDevice);

            return 0;
            }
        }
    }
