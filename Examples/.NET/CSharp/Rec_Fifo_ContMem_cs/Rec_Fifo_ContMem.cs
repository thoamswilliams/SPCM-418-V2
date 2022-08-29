using System;
using System.Threading;
using System.Collections.Generic;
using System.Text;
using Spcm;
using System.Runtime.InteropServices;
using System.IO;

namespace Rec_Fifo_ContMem
    {
    class Rec_Fifo_ContMem
        {

        static bool m_bRunning = true;
        
        public static void vThreadDo()
            {
            ConsoleKeyInfo oKeyInfo = Console.ReadKey(true);
            m_bRunning = false;
            }

        static int Main()
            {
            IntPtr hDevice, pBuffer;
            GCHandle hBufferHandle;
            int lErrorVal, lCardType, lSerialNumber, lMaxChannels, lBytesPerSample, lValue;
            int lDataAvailBytes, lAvailPos;
            uint dwErrorReg, dwErrorCode;
            long llValue, llDataTransferred, llBufIdx;
            ulong qwContBufLen;
            short[] nBuffer;
            sbyte[] byBuffer;
            byte[] byTmpBuffer;
            bool bContMemUsed;

            bContMemUsed = false;

            byBuffer = null;
            byTmpBuffer = null;
            nBuffer = null;
            
            StringBuilder sErrorText = new StringBuilder(1024);

            uint dwBufferLen = 4 * 1024 * 1024;
            uint dwNotify = 4 * 1024;

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
            dwErrorCode = Drv.spcm_dwGetParam_i64(hDevice, Regs.SPC_PCIMEMSIZE, out llValue);
            Console.WriteLine("  Installed memory  :  {0} MByte", llValue / 1024 / 1024);

            // ----- get max samplerate -----
            dwErrorCode = Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_MIINST_MAXADCLOCK, out lValue);
            Console.WriteLine("  Max sampling rate :  {0} MS/s", lValue / 100000);

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
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_CARDMODE, Regs.SPC_REC_FIFO_SINGLE);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_CHENABLE, 1);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_PRETRIGGER, 16);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_SEGMENTSIZE, 1024);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_LOOPS, 0);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_CLOCKMODE, Regs.SPC_CM_INTPLL);
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_SAMPLERATE, 100000);
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
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_50OHM0, 1);

            // ----- check error code and print error message -----
            if (dwErrorCode != 0)
                {
                Drv.spcm_dwGetErrorInfo_i32(hDevice, out dwErrorReg, out lErrorVal, sErrorText);
                Console.WriteLine("\nError occurred : {0}", sErrorText);
                }

            if (lBytesPerSample == 1)
                {
                // ----- alloc buffer memory -----
                byBuffer = new sbyte[dwBufferLen];
                byTmpBuffer = new byte[dwBufferLen];

                // ----- get handle to locked buffer -----
                hBufferHandle = GCHandle.Alloc(byBuffer, GCHandleType.Pinned);
                }
            else
                {
                // ----- alloc buffer memory -----
                nBuffer = new short[dwBufferLen / 2];

                // ----- get handle to locked buffer -----
                hBufferHandle = GCHandle.Alloc(nBuffer, GCHandleType.Pinned);
                }

            // ----- check if continuous memory buffer is available -----
            dwErrorCode = Drv.spcm_dwGetContBuf_i64(hDevice, Drv.SPCM_BUF_DATA, out pBuffer, out qwContBufLen);

            if (qwContBufLen >= (ulong)(dwBufferLen))
                {
                // ----- use pointer to contin memory -----
                bContMemUsed = true;
                Console.WriteLine("\n  << Continuous memory used ({0} MByte configured) >>\n", qwContBufLen / 1024 / 1024);
                }
            else
                // ----- get pointer to locked memory -----
                pBuffer = hBufferHandle.AddrOfPinnedObject();

                
            // ----- setup card for data transfer -----
            dwErrorCode = Drv.spcm_dwDefTransfer_i64(hDevice, Drv.SPCM_BUF_DATA, Drv.SPCM_DIR_CARDTOPC, dwNotify, pBuffer, 0, dwBufferLen);

            // ----- create file stream objects -----
            FileStream oFileStream = new FileStream("stream.dat", FileMode.Create);
            BinaryWriter oBinWriter = new BinaryWriter(oFileStream);

            Console.WriteLine("\n  ----- Press any key to stop Fifo mode -----\n");

            // ----- start thread to check key press event -----
            Thread poThread = new Thread(new ThreadStart(vThreadDo));
            poThread.Start ();

            // ----- start card and DMA transfer -----
            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_M2CMD, Regs.M2CMD_CARD_START | Regs.M2CMD_CARD_ENABLETRIGGER | Regs.M2CMD_DATA_STARTDMA | Regs.M2CMD_DATA_WAITDMA);

            lDataAvailBytes = 0;
            lAvailPos = 0;
            llDataTransferred = 0;
           
            while (m_bRunning)
                {
                Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_DATA_AVAIL_USER_LEN, out lDataAvailBytes);
                Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_DATA_AVAIL_USER_POS, out lAvailPos);

                if ((lAvailPos + lDataAvailBytes) >= dwBufferLen)
                    lDataAvailBytes = (int)(dwBufferLen - lAvailPos);

                
                // ----- copy from unmanaged to managed data buffer -----
                if (bContMemUsed)
                    {
                    if (lBytesPerSample == 1)
                        {
                        Marshal.Copy(pBuffer + lAvailPos, byTmpBuffer, (lAvailPos / lBytesPerSample), (lDataAvailBytes / lBytesPerSample));
                        byBuffer = (sbyte[])(Array)byTmpBuffer;
                        }
                        else
                            Marshal.Copy(pBuffer + lAvailPos, nBuffer, (lAvailPos / lBytesPerSample), (lDataAvailBytes / lBytesPerSample));
                    }
            
                // ----- write data to file -----
                for (llBufIdx = (lAvailPos / lBytesPerSample); llBufIdx < (lAvailPos + lDataAvailBytes) / lBytesPerSample; llBufIdx++)
                    {
                    if (lBytesPerSample == 1)
                        oBinWriter.Write(byBuffer[llBufIdx]);
                    else
                        oBinWriter.Write(nBuffer[llBufIdx]);
                    }
                
                if (lDataAvailBytes > 0)
                    Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_DATA_AVAIL_CARD_LEN, lDataAvailBytes);

                llDataTransferred += lDataAvailBytes;

                Console.Write("\r  Transferred : {0} kBytes", llDataTransferred / 1024);

                dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_M2CMD, Regs.M2CMD_DATA_WAITDMA);
                }

            dwErrorCode = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_M2CMD, Regs.M2CMD_CARD_STOP);

            Console.WriteLine("\n\n  Fifo mode stopped.\n\n");


            oBinWriter.Close();
            oFileStream.Close(); 
            
            // ----- close card -----
            Drv.spcm_vClose (hDevice);

            return 0;
            }
        }
    }

