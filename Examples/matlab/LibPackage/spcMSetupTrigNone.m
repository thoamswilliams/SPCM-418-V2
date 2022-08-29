%**************************************************************************
% Spectrum Matlab Library Package               (c) Spectrum GmbH, 2019
%**************************************************************************
% Supplies different common functions for Matlab programs accessing the 
% SpcM driver interface. Feel free to use this source for own projects and
% modify it in any kind
%**************************************************************************
% spcMSetupTrigNone
%**************************************************************************

function [success, cardInfo] = spcMSetupTrigNone (cardInfo)
    
	global mRegs;
    if (isempty (mRegs))
        mRegs = spcMCreateRegMap ();
    end
	
    error = 0;
    
    % ----- clear all trigger masks -----
    error = error + spcm_dwSetParam_i32 (cardInfo.hDrv, mRegs('SPC_TRIG_ORMASK'),      0);
    error = error + spcm_dwSetParam_i32 (cardInfo.hDrv, mRegs('SPC_TRIG_ANDMASK'),     0);
    error = error + spcm_dwSetParam_i32 (cardInfo.hDrv, mRegs('SPC_TRIG_CH_ORMASK0'),  0);
    error = error + spcm_dwSetParam_i32 (cardInfo.hDrv, mRegs('SPC_TRIG_CH_ORMASK1'),  0);
    error = error + spcm_dwSetParam_i32 (cardInfo.hDrv, mRegs('SPC_TRIG_CH_ANDMASK0'), 0);
    error = error + spcm_dwSetParam_i32 (cardInfo.hDrv, mRegs('SPC_TRIG_CH_ANDMASK1'), 0);
    
    [success, cardInfo] = spcMCheckSetError (error, cardInfo);    