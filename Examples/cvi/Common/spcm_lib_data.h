/*
**************************************************************************

spcm_lib_data.h                                (c) Spectrum GmbH , 01/2006

**************************************************************************

Offers simple data manipulation routines for the SpcMDrv data format. 
Feel free to use this source for own projects and modify it in any kind

**************************************************************************
*/


#ifndef SPCM_LIB_DATA_H
#define SPCM_LIB_DATA_H

#include <stdio.h>

// ----- include standard driver header from library -----
#include "../c_header/dlltyp.h"
#include "../c_header/regs.h"
#include "../c_header/spcerr.h"
#include "../c_header/spcm_drv.h"

// ----- include of common example librarys -----
#include "spcm_lib_card.h"



/*
**************************************************************************
bSpcMDemuxAnalogDataToInt16

demultiplexes the analog channel data to seperate arrays of int16 values.
The data buffers for the demultiplexed data must be allocated by the 
caller. Each buffer must be of the size (LenInSamples * BytesPerSample)
**************************************************************************
*/

bool bSpcMDemuxAnalogDataToInt16 (
    ST_SPCM_CARDINFO   *pstCardInfo,    // pointer to a filled card info structure
    void               *pvMuxData,      // pointer to the muxed data
    uint32              dwLenInSamples, // length ot muxed data in samples
    int16              **ppnData);       // array of pointers for demuxed data


/*
**************************************************************************
bSpcMDemuxDigitalDataToInt8

demultiplexes the digital channel data to seperate arrays of int8 values.
The data buffers for the demultiplexed data must be allocated by the 
caller. 
**************************************************************************
*/

bool bSpcMDemuxDigitalDataToInt8 (
    ST_SPCM_CARDINFO  *pstCardInfo,	  // pointer to a filled card info structure
    void              *pvMuxData,	  // pointer to the muxed data
    uint32            dwLenInSamples, // length ot muxed data in samples
    int8              **ppbyData);	  // array of pointers for demuxed data


/*
**************************************************************************
bMMuxData

multiplexes a series of channels into one buffer. The function retains
the information how much bytes one sample has from the CardInfo structure.
The source buffers must be same format and the destination buffer must be
lSetChannels * llMemsize for all the data
**************************************************************************
*/

bool bSpcMMuxData (
    ST_SPCM_CARDINFO   *pstCardInfo,    // pointer to a filled card info structure
    void               *pvMuxData,      // pointer to the empty muxed data buffer
    uint32              dwLenInSamples, // length ot channel data in samples
    void              **ppvData);       // array of pointers for demuxed data



/*
**************************************************************************
dSpcMIntToVoltage

recalculates an integer value to a voltage value taking selected range
and selected offset into account
**************************************************************************
*/

double dSpcMIntToVoltage (                      // returns the calculated voltage value 
    ST_SPCM_CARDINFO   *pstCardInfo,            // pointer to a filled card info structure
    int32               lChannel,               // channel for which the data is valid
    double              dValue);                // channel value



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

bool bSpcMDemuxAnalogDataToVoltage (
    ST_SPCM_CARDINFO   *pstCardInfo,    // pointer to a filled card info structure
    void               *pvMuxData,      // pointer to the muxed data
    uint32              dwLenInSamples, // length ot muxed data in samples
    float             **ppfData);       // array of pointers for demuxed data



/*
**************************************************************************
bSplitAnalogAndDigitalData

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

bool bSpcMSplitAnalogAndDigitalData (
    ST_SPCM_CARDINFO   *pstCardInfo,    // pointer to a filled card info structure
    void               *pvMergedData,   // pointer to the merged data
    uint32              dwLenInSamples, // length ot merged data in samples
    void               *pvAnalogData,   // pointer to a free buffer for analog data
    void               *pvDigitalData); // pointer to a free buffer for digital data



/*
**************************************************************************
dCalcXXX

some simple calculation routines for data
**************************************************************************
*/

double dSpcMCalcAverage (               // returns the average (DC) of the signal
    int16              *pnData,         // 16 bit data array
    uint32              dwLenInSamples);// length of the data array

int16 nSpcMCalcMin (                    // returns the min value of the signal
    int16              *pnData,         // 16 bit data array
    uint32              dwLenInSamples);// length of the data array

int16 nSpcMCalcMax (                    // returns the max value of the signal
    int16              *pnData,         // 16 bit data array
    uint32              dwLenInSamples);// length of the data array



/*
**************************************************************************
bCalcSignal

calculates simple signal shapes for output card test
**************************************************************************
*/

// signal shapes
typedef enum E_SPCM_SIGSHAPE 
    {
    eDCZero,        // zero level
    eDCPlusFS,      // positive full scale level (max)
    eDCMinusFS,     // negative full scale level (min)
    eSine,          // sine signal, one full 360° sine per loop
    eRectangle,     // rectangle with 50% duty
    eTriangle,      // triangle starting at -full scale level
    eSawtooth       // sawtooth starting at -full scale level
    } E_SPCM_SIGSHAPE;


bool bSpcMCalcSignal (                  // return true if calculation has succeeded
    ST_SPCM_CARDINFO   *pstCardInfo,    // pointer to a filled card info structure (needed for resolution)
    void               *pvData,         // pointer to free buffer for calculated data
    uint32              dwLenInSamples, // length of the data array in samples
    uint32              dwByteWidth,	// bytes width (for digital cards), if zero we expect a matching width to analog resolution
    E_SPCM_SIGSHAPE     eShape, 		// shape of signal to calculate
    uint32              dwLoops,    	// number of loops in calculated signal 
    uint32              dwGainP); 		// gain in percent in relation to resolution


#endif
