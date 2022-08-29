%**************************************************************************
% Spectrum Matlab Library Package                     (c) Spectrum GmbH
%**************************************************************************
% Supplies different common functions for Matlab programs accessing the 
% SpcM driver interface. Feel free to use this source for own projects and
% modify it in any kind
%**************************************************************************
% spcMSetupClockDirectExternal:
% direct external clock (M2p)
%**************************************************************************

function [success, cardInfo] = spcMSetupClockDirectExternal (cardInfo, clockTerm, threshold_lvl)

	global mRegs;
    if (isempty (mRegs))
        mRegs = spcMCreateRegMap ();
    end

    if (clockTerm ~= 0) & (clockTerm ~= 1)
        sprintf (cardInfo.errorText, 'spcMSetupClockDirectExternal: clockTerm must be 0 (disable) or 1 (enable)');
        success = false;
        return;
    end

    error = 0;

    % ----- setup the clock mode -----
    error = error + spcm_dwSetParam_i32 (cardInfo.hDrv, mRegs('SPC_CLOCKMODE'), mRegs('SPC_CM_EXTERNAL'));
    error = error + spcm_dwSetParam_i32 (cardInfo.hDrv, mRegs('SPC_CLOCK50OHM'), clockTerm);
    error = error + spcm_dwSetParam_i32 (cardInfo.hDrv, mRegs('SPC_CLOCK_THRESHOLD'), threshold_lvl);
	
    cardInfo.setSamplerate = 1;
    cardInfo.oversampling  = 1;
    
    [success, cardInfo] = spcMCheckSetError (error, cardInfo);



    



