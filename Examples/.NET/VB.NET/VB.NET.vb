Imports System
Imports System.Text
Imports System.Runtime.InteropServices
Imports Spcm

Module Example

    Sub Main()

        Dim hDevice, pBuffer As IntPtr
        Dim hBufferHandle As GCHandle
        Dim lErrorVal, lCardType, lSerialNumber, lMaxChannels, lBytesPerSample, lValue As Integer
        Dim dwError, dwErrorReg As UInteger
        Dim i, llMemSet, llAverage, llInstMem, llMaxSamplerate As Long
        Dim nMin, nMax As Short
        Dim pnData(1) As Short
        Dim pbyData(1) As SByte
        Dim sErrorText As StringBuilder = New StringBuilder(1024)

        llMemSet = 16384

        ' ----- open card -----
        hDevice = Drv.spcm_hOpen("/dev/spcm0")

        If (hDevice = IntPtr.Zero) Then
            Console.WriteLine("Error: Could not open card\n")
        Else

            ' ----- get card type -----
            dwError = Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_PCITYP, lCardType)
            dwError = Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_PCISERIALNR, lSerialNumber)

            Select Case (lCardType And CardType.TYP_SERIESMASK)

                Case CardType.TYP_M2ISERIES
                    Console.WriteLine("M2i.{0:x} sn {1}", lCardType And CardType.TYP_VERSIONMASK, lSerialNumber)

                Case CardType.TYP_M2IEXPSERIES
                    Console.WriteLine("M2i.{0:x}-Exp sn {1}", lCardType And CardType.TYP_VERSIONMASK, lSerialNumber)

                Case CardType.TYP_M3ISERIES
                    Console.WriteLine("M3i.{0:x} sn {1}", lCardType And CardType.TYP_VERSIONMASK, lSerialNumber)

                Case CardType.TYP_M3IEXPSERIES
                    Console.WriteLine("M3i.{0:x}-Exp sn {1}", lCardType And CardType.TYP_VERSIONMASK, lSerialNumber)

                Case CardType.TYP_M4IEXPSERIES
                    Console.WriteLine("M4i.{0:x}-x8 sn {1}", lCardType And CardType.TYP_VERSIONMASK, lSerialNumber)

                Case CardType.TYP_M4XEXPSERIES
                    Console.WriteLine("M4x.{0:x}-x4 sn {1}", lCardType And CardType.TYP_VERSIONMASK, lSerialNumber)

                Case CardType.TYP_M2PEXPSERIES
                    Console.WriteLine("M2p.{0:x}-x4 sn {1}", lCardType And CardType.TYP_VERSIONMASK, lSerialNumber)                    
                    
                Case Else
                    Console.WriteLine("Typ: {0:x} not supported so far", lCardType)

            End Select

            Console.WriteLine()

            ' ----- get max memsize -----
            dwError = Drv.spcm_dwGetParam_i64(hDevice, Regs.SPC_PCIMEMSIZE, llInstMem)
            Console.WriteLine("  Installed memory  :  {0} MByte", llInstMem / 1024 / 1024)

            ' ----- get max samplerate -----
            dwError = Drv.spcm_dwGetParam_i64(hDevice, Regs.SPC_MIINST_MAXADCLOCK, llMaxSamplerate)
            Console.WriteLine("  Max sampling rate :  {0} MS/s", llMaxSamplerate / 1000000)

            ' ----- get max number of channels -----
            dwError = Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_MIINST_MODULES, lValue)
            dwError = Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_MIINST_CHPERMODULE, lMaxChannels)
            lMaxChannels = lMaxChannels * lValue
            Console.WriteLine("  Channels          :   {0}", lMaxChannels)

            ' ----- get kernel version -----
            dwError = Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_GETKERNELVERSION, lValue)
            Console.WriteLine("  Kernel Version    : {0}.{1} build {2}", lValue >> 24, (lValue >> 16) And 255, lValue And 65535)

            ' ----- get library version -----
            dwError = Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_GETDRVVERSION, lValue)
            Console.WriteLine("  Library Version   : {0}.{1} build {2}", lValue >> 24, (lValue >> 16) And 255, lValue And 65535)

            ' ----- get bytes per sample -----
            dwError = Drv.spcm_dwGetParam_i32(hDevice, Regs.SPC_MIINST_BYTESPERSAMPLE, lBytesPerSample)

            ' ----- setup card -----
            dwError = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_AMP0, 1000)
            dwError = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_CARDMODE, Regs.SPC_REC_STD_SINGLE)
            dwError = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_CHENABLE, 1)
            dwError = Drv.spcm_dwSetParam_i64(hDevice, Regs.SPC_MEMSIZE, llMemSet)
            dwError = Drv.spcm_dwSetParam_i64(hDevice, Regs.SPC_POSTTRIGGER, llMemSet / 2)
            dwError = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_CLOCKMODE, Regs.SPC_CM_INTPLL)
            dwError = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_SAMPLERATE, 100000)
            dwError = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_TRIG_ORMASK, Regs.SPC_TMASK_SOFTWARE)

            ' ----- check error code and print error message -----
            If (dwError <> 0) Then
                Drv.spcm_dwGetErrorInfo_i32(hDevice, dwErrorReg, lErrorVal, sErrorText)
                Console.WriteLine()
                Console.WriteLine("Error occurred : {0}", sErrorText)
            End If

            ' ----- start card and wait until acquisition has finished -----
            Console.WriteLine()
            Console.Write("  Start acquisition ..... ")
            dwError = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_M2CMD, Regs.M2CMD_CARD_START Or Regs.M2CMD_CARD_ENABLETRIGGER Or Regs.M2CMD_CARD_WAITREADY)
            Console.WriteLine("done")

            ' ----- set data transfer function -----
            If (lBytesPerSample = 2) Then

                ' ----- 12, 14, 16 bit per sample -----
                ReDim pnData(llMemSet - 1)

                ' ----- lock memory -----
                hBufferHandle = GCHandle.Alloc(pnData, GCHandleType.Pinned)
            Else

                ' ----- 8 bit per sample -----
                ReDim pbyData(llMemSet - 1)

                ' ----- lock memory -----
                hBufferHandle = GCHandle.Alloc(pbyData, GCHandleType.Pinned)
            End If

            ' ----- get pointer to locked memory -----
            pBuffer = hBufferHandle.AddrOfPinnedObject()

            dwError = Drv.spcm_dwDefTransfer_i64(hDevice, Drv.SPCM_BUF_DATA, Drv.SPCM_DIR_CARDTOPC, 0, pBuffer, 0, lBytesPerSample * llMemSet)

            ' ----- start DMA data transfer and wait until transfer has finished -----
            Console.Write("  Start data transfer ... ")
            dwError = Drv.spcm_dwSetParam_i32(hDevice, Regs.SPC_M2CMD, Regs.M2CMD_DATA_STARTDMA Or Regs.M2CMD_DATA_WAITDMA)
            Console.WriteLine("done")

            ' ----- get some data infos -----
            nMin = 32767
            nMax = -32768
            llAverage = 0

            For i = 0 To llMemSet - 1 Step 1

                If (lBytesPerSample = 2) Then

                    ' ----- get min -----
                    If (pnData(i) < nMin) Then
                        nMin = pnData(i)
                    End If

                    ' ----- get max -----
                    If (pnData(i) > nMax) Then
                        nMax = pnData(i)
                    End If

                    ' ----- get average -----
                    llAverage = llAverage + pnData(i)
                Else

                    ' ----- get min -----
                    If (pbyData(i) < nMin) Then
                        nMin = pbyData(i)
                    End If

                    ' ----- get max -----
                    If (pbyData(i) > nMax) Then
                        nMax = pbyData(i)
                    End If

                    ' ----- get average -----
                    llAverage = llAverage + pbyData(i)
                End If

            Next i

            llAverage = llAverage / llMemSet

            Console.WriteLine()
            Console.WriteLine("  Data Info:")
            Console.WriteLine("    Min value = {0}", nMin)
            Console.WriteLine("    Max value = {0}", nMax)
            Console.WriteLine("    Average   = {0}", llAverage)
            Console.WriteLine()

            ' ----- close card -----
            Drv.spcm_vClose(hDevice)
        End If

    End Sub

End Module
