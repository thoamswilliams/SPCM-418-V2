/*
**************************************************************************

spcm_lib_data.cpp                              (c) Spectrum GmbH , 01/2006

**************************************************************************

Offers simple data manipulation routines for the SpcMDrv data format. 
Feel free to use this source for own projects and modify it in any kind

**************************************************************************
*/

// ----- include of common example librarys -----
#include "spcm_lib_data.h"


// ----- standard c include files -----
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>



/*
**************************************************************************
bSpcMDemuxAnalogData

demultiplexes the analog channel data to seperate arrays.
The data buffers for the demultiplexed data must be allocated by the 
caller. Each buffer must be of the size (LenInSamples * BytesPerSample)
**************************************************************************
*/

bool bSpcMDemuxAnalogDataToInt16 (ST_SPCM_CARDINFO *pstCardInfo, void *pvMuxData, uint32 dwLenInSamples, int16 **ppnChannelData)
    {
    uint32  dwSample;
    int32   lCh;
    int16*  ppnChPtr[SPCM_MAX_AICHANNEL];

    if (!pstCardInfo || !pvMuxData)
        return false;

    // set the sorting table for the channels
    for (lCh=0; lCh < pstCardInfo->lSetChannels; lCh++)
        ppnChPtr[lCh] = ppnChannelData[lCh];

    // if two modules are active data is sorted mod0ch0, mod1ch0, mod0ch1, ...
    if (pstCardInfo->qwSetChEnableMap & ~((1 << (pstCardInfo->lMaxChannels / pstCardInfo->lModulesCount)) - 1))
        for (lCh=0; lCh < (pstCardInfo->lSetChannels >> 1); lCh++)
            {
            ppnChPtr[2 * lCh + 0] = ppnChannelData[lCh];
            ppnChPtr[2 * lCh + 1] = ppnChannelData[(pstCardInfo->lSetChannels >> 1) + lCh];
            }

    // split word data
    if (pstCardInfo->lBytesPerSample > 1)
        {
        int16* pnMuxBuf = (int16*) pvMuxData;

        for (dwSample = 0; dwSample < dwLenInSamples; dwSample++)
            for (lCh = 0; lCh < pstCardInfo->lSetChannels; lCh++)
                *ppnChPtr[lCh]++ = *pnMuxBuf++;
        }

    // split byte data
    else
        {
        int8* pbyMuxBuf = (int8*) pvMuxData;

        for (dwSample = 0; dwSample < dwLenInSamples; dwSample++)
            for (lCh = 0; lCh < pstCardInfo->lSetChannels; lCh++)
                *ppnChPtr[lCh]++ = *pbyMuxBuf++;
        }

    return true;
    }

/*
**************************************************************************
bSpcMDemuxDigitalData

demultiplexes the digital channel data to seperate arrays.
The data buffers for the demultiplexed data must be allocated by the 
caller. 
**************************************************************************
*/

bool bSpcMDemuxDigitalDataToInt8 (ST_SPCM_CARDINFO *pstCardInfo, void *pvMuxData, uint32 dwLenInSamples, int8 **ppbyData)
    {
    int16 nGroupSample;
    int8 bySample;
    int32 lIdxOffset, lChIdx, lSampleIdx;
    uint32 dwGroupIdx;
    int16* ppnBuf;

    ppnBuf = (int16*)pvMuxData;
    lSampleIdx = -1;

    // split data
    for (dwGroupIdx=0; dwGroupIdx < dwLenInSamples; dwGroupIdx++)
        {

        nGroupSample = ppnBuf[dwGroupIdx];

        switch (pstCardInfo->lSetChannels)
        {
            // 1, 2, 4, 8 channels
            case 1:
            case 2:
            case 4:
            case 8:
                for (lChIdx=0; lChIdx < 16; lChIdx++)
                    {

                    if (!(lChIdx%pstCardInfo->lSetChannels))
                        lSampleIdx++;

                    bySample = (int8)(nGroupSample & 0x0001);
                    nGroupSample = nGroupSample >> 1;

                    ppbyData[lChIdx%pstCardInfo->lSetChannels][lSampleIdx] = bySample;
                    }

                break;

            // 16 channels
            case 16 :
                for (lChIdx=0; lChIdx < 16; lChIdx++)
                    {
                    bySample = (int8)(nGroupSample & 0x0001);
                    nGroupSample = nGroupSample >> 1;

                    ppbyData[lChIdx][dwGroupIdx] = bySample;
                    }

                break;

            // 32 channels
            case 32 :
                if (!(dwGroupIdx%2))
                    {
                    lIdxOffset = 0;
                    lSampleIdx++;
                    }
                else
                    lIdxOffset = 16;

                for (lChIdx=0; lChIdx < 16; lChIdx++)
                    {
                    bySample = (int8)(nGroupSample & 0x0001);
                    nGroupSample = nGroupSample >> 1;

                    ppbyData[lChIdx + lIdxOffset][lSampleIdx] = bySample;
                    }

                break;

            // 64 channels
            case 64 :
                switch (dwGroupIdx%4)
                    {
                    case 0 :
                        lIdxOffset = 0;
                        lSampleIdx++;
                        break;
                    case 1 :
                        lIdxOffset = 32;
                        break;
                    case 2 :
                        lIdxOffset = 16;
                        break;
                    case 3 : 
                        lIdxOffset = 48;
                        break;
                    }

                for (lChIdx=0; lChIdx < 16; lChIdx++)
                    {
                    bySample = (int8)(nGroupSample & 0x0001);
                    nGroupSample = nGroupSample >> 1;

                    ppbyData[lChIdx + lIdxOffset][lSampleIdx] = bySample;
                    }

                break;

            default:
                return false;
            }
        }

    return true;
    }


/*
**************************************************************************
dSpcMIntToVoltage: recalculates an integer value to a voltage value taking 
selected range and selected offset into account
**************************************************************************
*/

double dSpcMIntToVoltage (ST_SPCM_CARDINFO *pstCardInfo, int32 lChannel, double dValue)
    {
    double dVoltage_mv;
    
    if (!pstCardInfo)
        return 0;

    if ((lChannel < 0) || (lChannel >= pstCardInfo->lMaxChannels))
        {
        sprintf (pstCardInfo->szError, "SpcMIntToVoltage: channel number %d not valid. Channels range from 0 to %d\n", lChannel, pstCardInfo->lMaxChannels);
        return 0;
        }

    // recalculate with input range
    switch (pstCardInfo->uCfg.stAI.lResolution)
        {
        case 8:  dVoltage_mv = pstCardInfo->uCfg.stAI.lSetRange[lChannel] * dValue / 127; break;
        case 12: dVoltage_mv = pstCardInfo->uCfg.stAI.lSetRange[lChannel] * dValue / 2047; break;
        case 14: dVoltage_mv = pstCardInfo->uCfg.stAI.lSetRange[lChannel] * dValue / 8191; break;
        case 16: dVoltage_mv = pstCardInfo->uCfg.stAI.lSetRange[lChannel] * dValue / 32767; break;
        default: dVoltage_mv = 0;
        }

    // add the signal offset
    if (pstCardInfo->uCfg.stAI.bOffsPercentMode)
        dVoltage_mv -= pstCardInfo->uCfg.stAI.lSetRange[lChannel] * pstCardInfo->uCfg.stAI.lSetOffset[lChannel] / 100;
    else
        dVoltage_mv -= pstCardInfo->uCfg.stAI.lSetOffset[lChannel];

    return (dVoltage_mv / 1000.0);
    }



/*
**************************************************************************
bSpcMDemuxAnalogDataToVoltage

demultiplexes the analog channel data to seperate arrays.
The data buffers for the demultiplexed data must be allocated by the 
caller. Each buffer must be of the size (LenInSamples * sizeof(float))

Recalculates the plain data to voltage levels taking resolution, offset 
and range into account.
**************************************************************************
*/

bool bSpcMDemuxAnalogDataToVoltage (ST_SPCM_CARDINFO *pstCardInfo, void *pvMuxData, uint32 dwLenInSamples, float **ppfData)
    {
    uint32  dwSample;
    int32   lCh;
    float*  ppfChPtr[SPCM_MAX_AICHANNEL];
    double  dOffset[SPCM_MAX_AICHANNEL], dFactor[SPCM_MAX_AICHANNEL];
    
    if (!pstCardInfo || !pvMuxData)
        return false;

    // set the sorting table for the channels
    for (lCh=0; lCh < pstCardInfo->lSetChannels; lCh++)
        ppfChPtr[lCh] = ppfData[lCh];

    // if two modules are active data is sorted mod0ch0, mod1ch0, mod0ch1, ...
    if (pstCardInfo->qwSetChEnableMap & ~((1 << (pstCardInfo->lMaxChannels / pstCardInfo->lModulesCount)) - 1))
        for (lCh=0; lCh < (pstCardInfo->lSetChannels >> 1); lCh++)
            {
            ppfChPtr[2 * lCh + 0] = ppfData[lCh];
            ppfChPtr[2 * lCh + 1] = ppfData[(pstCardInfo->lSetChannels >> 1) + lCh];
            }



    // calculate offset and factor for re-calculation to voltage
    for (lCh=0; lCh < pstCardInfo->lSetChannels; lCh++)
        {
        switch (pstCardInfo->uCfg.stAI.lResolution)
            {
            case 8:  dFactor[lCh] = (double) pstCardInfo->uCfg.stAI.lSetRange[lCh] / 127.0 / 1000.0; break;
            case 12: dFactor[lCh] = (double) pstCardInfo->uCfg.stAI.lSetRange[lCh] / 2047.0 / 1000.0; break;
            case 14: dFactor[lCh] = (double) pstCardInfo->uCfg.stAI.lSetRange[lCh] / 8191.0 / 1000.0; break;
            case 16: dFactor[lCh] = (double) pstCardInfo->uCfg.stAI.lSetRange[lCh] / 32767.0 / 1000.0; break;
            default: dFactor[lCh] = 0.0;
            }

        // add the signal offset
        if (pstCardInfo->uCfg.stAI.bOffsPercentMode)
            dOffset[lCh] = -(double) pstCardInfo->uCfg.stAI.lSetRange[lCh] * pstCardInfo->uCfg.stAI.lSetOffset[lCh] / 100.0 / 1000.0;
        else
            dOffset[lCh] = -(double) pstCardInfo->uCfg.stAI.lSetOffset[lCh] / 1000.0;
        }



    // split word data
    if (pstCardInfo->lBytesPerSample > 1)
        {
        int16* pnMuxBuf = (int16*) pvMuxData;

        for (dwSample = 0; dwSample < dwLenInSamples; dwSample++)
            for (lCh = 0; lCh < pstCardInfo->lSetChannels; lCh++)
                *ppfChPtr[lCh]++ = (float) (dOffset[lCh] + dFactor[lCh] * *pnMuxBuf++);
        }

    // split byte data
    else
        {
        int8* pbyMuxBuf = (int8*) pvMuxData;

        for (dwSample = 0; dwSample < dwLenInSamples; dwSample++)
            for (lCh = 0; lCh < pstCardInfo->lSetChannels; lCh++)
                *ppfChPtr[lCh]++ = (float) (dOffset[lCh] + dFactor[lCh] * *pbyMuxBuf++);
        }

    return true;
    }



/*
**************************************************************************
bMMuxData

multiplexes a series of channels into one buffer. The function retains
the information how much bytes one sample has from the CardInfo structure.
The source buffers must be same format and the destination buffer must be
lSetChannels * llMemsize for all the data
**************************************************************************
*/

bool bSpcMMuxData (ST_SPCM_CARDINFO *pstCardInfo, void *pvMuxData, uint32 dwLenInSamples, void **ppvData)
    {
    int32   lCh;
    void*   ppvChPtr[SPCM_MAX_AICHANNEL];
    uint32  dwSample;
    uint32 	dwBytesPerSumSample;
    uint32 	dwBytesPerSample;

    if (!pstCardInfo || !pvMuxData)
        return false;

    // set the sorting table for the channels
    for (lCh=0; lCh < pstCardInfo->lSetChannels; lCh++)
        ppvChPtr[lCh] = ppvData[lCh];

    // if two modules are active data is sorted mod0ch0, mod1ch0, mod0ch1, ...
    if (pstCardInfo->qwSetChEnableMap & ~((1 << (pstCardInfo->lMaxChannels / pstCardInfo->lModulesCount)) - 1))
        for (lCh=0; lCh < (pstCardInfo->lSetChannels >> 1); lCh++)
            {
            ppvChPtr[2 * lCh + 0] = ppvData[lCh];
            ppvChPtr[2 * lCh + 1] = ppvData[(pstCardInfo->lSetChannels >> 1) + lCh];
            }

    // now start the mux loop
    dwBytesPerSumSample = (uint32) (pstCardInfo->lSetChannels * pstCardInfo->lBytesPerSample);
    dwBytesPerSample = pstCardInfo->lBytesPerSample;

    for (dwSample = 0; dwSample < dwLenInSamples; dwSample++)
        for (lCh = 0; lCh < pstCardInfo->lSetChannels; lCh++)
            memcpy (((uint8*) pvMuxData) + dwSample * dwBytesPerSumSample + lCh * dwBytesPerSample, ((uint8*) ppvChPtr[lCh]) + dwSample * dwBytesPerSample, dwBytesPerSample);

    return true;
    }



/*
**************************************************************************
bSpcMSplitAnalogAndDigitalData

If synchronous digital inputs have been used with analog data acquistion,
analog and digital data are stored in combined samples, the digital data
using the upper bits of the analog word.

This function splits analog and digital data into separate arrays. Analog
data is sign extended to int16 again to use it with any calculation 
routine. Digital data 

The caller is responsible to allocate buffer data for the split data. The
analog data buffer must be of the size (LenInSamples * Channels * 2), the 
digital data needs (LenInSamples * Channels)
**************************************************************************
*/

bool bSpcMSplitAnalogAndDigitalData (ST_SPCM_CARDINFO *pstCardInfo, void *pvMergedData, uint32 dwLenInSamples, void *pvAnalogData, void *pvDigitalData)
    {
    if (!pstCardInfo)
        return false;

    printf ("*** function not yet implemented ***\n");

    return true;
    }



/*
**************************************************************************
dCalcXXX

some simple calculation routines for data
**************************************************************************
*/

double dSpcMCalcAverage (int16 *pnData, uint32 lLenInSamples)
    {
    uint32 j;
    double dAverage;
    
    if (!pnData)
        return 0;

    for (dAverage = 0, j=0; j<lLenInSamples; j++, pnData++)
        dAverage += *pnData;

    return (dAverage / lLenInSamples);
    }

// ***********************************************************************

int16 nSpcMCalcMin (int16 *pnData, uint32 lLenInSamples)
    {
	int16 nMin;
    uint32 j;
    
    if (!pnData)
        return 0;

    for (nMin = 32767, j=0; j<lLenInSamples; j++, pnData++)
        if (*pnData < nMin)
            nMin = *pnData;

    return nMin;
    }

// ***********************************************************************

int16 nSpcMCalcMax (int16 *pnData, uint32 lLenInSamples)
    {
	int16 nMax;
    uint32 j;
    
    if (!pnData)
        return 0;

    for (nMax = -32768, j=0; j<lLenInSamples; j++, pnData++)
        if (*pnData > nMax)
            nMax = *pnData;

    return nMax;
    }



/*
**************************************************************************
bCalcSignal: calculates simple signal shapes for output card test
**************************************************************************
*/

bool bSpcMCalcSignal (ST_SPCM_CARDINFO *pstCardInfo, void *pvData, uint32 dwLenInSamples, uint32 dwByteWidth, E_SPCM_SIGSHAPE eShape, uint32 dwLoops, uint32 dwGainP)
    {
    int64   llMinFS, llMaxFS, llValue;
    uint32  i;
    int32   lResolution;
    double  dScale;
    int8*   pbyData = (int8*)  pvData;
    int16*  pnData =  (int16*) pvData;
    int32*  plData =  (int32*) pvData;
    int64*  pllData = (int64*) pvData;
    double dSineXScale;
    uint32 dwBlock;
    uint32 dwBlockHalf;
    uint32 dwPosInBlock;
    int64  llSpan;

    if (!pstCardInfo || !pvData || !dwLenInSamples)
        return false;


    // examine the resolution, bytewidth and min/max values
    switch (pstCardInfo->eCardFunction)
        {
        case AnalogIn:
        case AnalogOut:
            if (pstCardInfo->eCardFunction == AnalogIn)
                lResolution = pstCardInfo->uCfg.stAI.lResolution;
            else
                lResolution = pstCardInfo->uCfg.stAO.lResolution;

            switch (lResolution)
                {
                default:
                case 8:
                    dwByteWidth = 1;
                    llMinFS = -128;
                    llMaxFS = +127;
                    dScale = 127.0 * dwGainP / 100.0;
                    break;

                case 12:
                    dwByteWidth = 2;
                    llMinFS = -2048;
                    llMaxFS = +2047;
                    dScale = 2047.0 * dwGainP / 100.0;
                    break;

                case 14:
                    dwByteWidth = 2;
                    llMinFS = -8192;
                    llMaxFS = +8191;
                    dScale = 8191.0 * dwGainP / 100.0;
                    break;

                case 16:
                    dwByteWidth = 2;
                    llMinFS = -32768;
                    llMaxFS = +32767;
                    dScale = 32767.0 * dwGainP / 100.0;
                    break;

                }

            break;

        case DigitalIn:
        case DigitalOut:
        case DigitalIO:
            if (dwByteWidth == 0)
                {
                sprintf (pstCardInfo->szError, "ByteWidth can't be zero for digital cards as we didn't know how much channels are activated\n");
                return false;
                }
            llMinFS = 0;
            llMaxFS = -1; // all bits set to 1 for digital cards max full scale
            dScale = 65536.0 * dwGainP / 100.0;
            break;
        }


    // calculation of different signal shapes
    dSineXScale = 2.0 * 3.14159 / dwLenInSamples * dwLoops;
    dwBlock = dwLenInSamples / dwLoops;
    dwBlockHalf = dwBlock / 2;
    llSpan = (llMaxFS - llMinFS);
    for (i=0; i<dwLenInSamples; i++)
        {

        dwPosInBlock = ((i + 1) % dwBlock);

        // calculation of value
        switch (eShape)
            {

            // DC level
            case eDCZero:    llValue = 0; break;
            case eDCPlusFS:  llValue = llMaxFS; break;
            case eDCMinusFS: llValue = llMinFS; break;

            // sine
            case eSine:
                llValue = (int64) (dScale * sin (dSineXScale * i));
                break;

            // rectangle
            case eRectangle:
                if (dwPosInBlock < dwBlockHalf)
                    llValue = llMinFS;
                else
                    llValue = llMaxFS;
                break;

            // triangel
            case eTriangle:
                if (dwPosInBlock < dwBlockHalf)
                    llValue = llMinFS + dwPosInBlock * llSpan / dwBlockHalf;
                else
                    llValue = llMaxFS - (dwPosInBlock - dwBlockHalf) * llSpan / dwBlockHalf;
                break;

            // sawtooth
            case eSawtooth:
                llValue = llMinFS + dwPosInBlock * llSpan / dwBlock;
                break;

            default:
                sprintf (pstCardInfo->szError, "Unknown signal shape selected\n");
                return false;
            }

        // write value to array
        if(pstCardInfo->eCardFunction != DigitalIO && pstCardInfo->eCardFunction != DigitalOut)
	        {
	        // if output shape is eSine, the following would transform it into a rectangle, so don't use for digital out
	        if (llValue < llMinFS)
    	        llValue = llMinFS;
        	else if (llValue > llMaxFS)
	            llValue = llMaxFS;
			}
			
        switch (dwByteWidth)
            {
            default:
            case 1: *pbyData++ = (int8)  llValue; break;
            case 2: *pnData++ =  (int16) llValue; break;
            case 4: *plData++ =  (int32) llValue; break;
            case 8: *pllData++ = (int64) llValue; break;
            }
		} // end of for-loop

    return true;
    }
