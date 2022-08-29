%**************************************************************************
%
% rec_fifo_sync.m                               (c) Spectrum GmbH, 2019
%
%**************************************************************************
%
% Example for all SpcMDrv based (M2i) acquisition cards. 
% Shows the synchronization of one or more cards with acquisition mode.
%  
% The Star-Hub is accessed directly as this is very simple.
%
% Feel free to use this source for own projects and modify it in any kind.
%
%**************************************************************************

% helper maps to use label names for registers and errors
global mRegs;
global mErrors;
 
mRegs = spcMCreateRegMap ();
mErrors = spcMCreateErrorMap ();

starhubFound = false;

samplesToRec_MS = 100;
bufferSize = 8 * 1024 * 1024; % 8 MSample
notifySize = 4096;            % 4 kSample

for cardCount = 0 : 15

    % ***** init card and store infos in cardInfo struct *****
    [success, cardInfo] = spcMInitCardByIdx (cardCount);

    if success == false
        
        if cardCount == 0
            spcMErrorMessageStdOut (cardInfo, 'Error: Could not open card\n', true);
            return;
        end
        
        break;
    else
        if bitand (cardInfo.featureMap, mRegs('SPCM_FEAT_STARHUB5')) | bitand (cardInfo.featureMap, mRegs('SPCM_FEAT_STARHUB16'))  % SPCM_FEAT_STARHUB5 = 32, SPCM_FEAT_STARHUB16 = 64
            starhubFound = true;
            fprintf ('Starthub found\n');
        end
        
        cardInfos (cardCount+1) = cardInfo;
    end
end        

% ----- printf info of all cards -----
for idx = 1 : cardCount 
    cardInfoText = spcMPrintCardInfo (cardInfos(idx));
    fprintf ('\nCard%d:\n', idx-1);
    fprintf (cardInfoText);
end

% ----- not our example if there's no starhub -----
if (starhubFound == false)
    fprintf ('\nThere is no starhub in the system, this example can not run\n');
    starhubOk = false;
else
    starhubOk = true;  
end

% ----- the star hub is accessed under it's own handle -----
if starhubOk == true
    hSync = spcm_hOpen ('sync0');
    if hSync == 0
        fprintf ('\nCan not open starhub handle\n');
        starhubOk = false;
    end

    if starhubOk == true
        [errorCode, syncCards] = spcm_dwGetParam_i32 (hSync, mRegs('SPC_SYNC_READ_SYNCCOUNT'));
        
        % ----- show cable connection info -----
        fprintf ('\nStar-hub information:\n');
        fprintf ('Star-hub is connected with %d cards\n', syncCards);
        for idx = 0 : syncCards - 1
            [errorCode, cable] = spcm_dwGetParam_i32 (hSync, mRegs('SPC_SYNC_READ_CABLECON0') + idx);
            fprintf ('  Card Idx %d (sn %05d) is', idx, cardInfos(idx+1).serialNumber);
            if cable ~= -1
                fprintf (' connected on cable %d\n', cable);
            else
                fprintf (' not connected with the star-hub\n');
            end
        end
        fprintf ('\n');
        
        % ----- all cards got a similar setup -----
        for idx = 1 : cardCount
            
			% ----- FIFO mode setup, we run continuously and have 16 samples of pre data before trigger event -----
			[success, cardInfos(idx)] = spcMSetupModeRecFIFOSingle (cardInfos(idx), 0, 1, 16, 0, 0);
            
            % ----- we try to set the samplerate to 1 MHz on internal PLL, no clock output -----
            [success, cardInfos(idx)] = spcMSetupClockPLL (cardInfos(idx), 1000000, 0);  % clock output : enable = 1, disable = 0
            
            fprintf ('  Card%d: Sampling rate set to %.1f MHz\n', idx-1, cardInfos(idx).setSamplerate / 1000000);

            % ----- type dependent card setup -----
            switch cardInfos(idx).cardFunction
    
                % ----- analog acquisition card setup -----
                case mRegs('SPCM_TYPE_AI')
                    % ----- program all input channels to +/-1 V and 50 ohm termination (if it's available) -----
                    for i=0 : cardInfos(idx).maxChannels-1
                        if (cardInfos(idx).isM3i)
                            [success, cardInfos(idx)] = spcMSetupAnalogPathInputCh (cardInfos(idx), i, 0, 1000, 1, 0, 0, 0);
                        else
                            [success, cardInfos(idx)] = spcMSetupAnalogInputChannel (cardInfos(idx), i, 1000, 1, 0, 0);
                        end
                    end
                    
               % ----- digital acquisition card setup -----
                case { mRegs('SPCM_TYPE_DI'), mRegs('SPCM_TYPE_DIO') }
                    % ----- set all input channel groups, no 110 ohm termination ----- 
                    for i=0 : cardInfos(idx).DIO.groups-1
                        [success, cardInfos(idx)] = spcMSetupDigitalInput (cardInfos(idx), i, 0);
                    end
            end
            
            fprintf ('  Card%d: Allocate memory for FIFO transfer ...\n\n', idx-1);
            if cardInfos(idx).cardFunction == 1
                errorCode = spcm_dwSetupFIFOBuffer (cardInfos(idx).hDrv, 0, 1, 1, cardInfos(idx).bytesPerSample * bufferSize, cardInfos(idx).bytesPerSample * notifySize);   
            else
                errorCode = spcm_dwSetupFIFOBuffer (cardInfos(idx).hDrv, 0, 1, 1, cardInfos(idx).bytesPerSample * bufferSize, 2 * notifySize);   
            end
            if (errorCode ~= 0)
                [success, cardInfo] = spcMCheckSetError (errorCode, cardInfo);
                spcMErrorMessageStdOut (cardInfo, 'spcm_dwSetupFIFOBuffer:\n\t', true);
                return;
            end
        end
        
		% ----- clear all trigger masks for all cards -----
        for idx = 1 : cardCount
            [success, cardInfos(idx)] = spcMSetupTrigNone (cardInfos(idx));
		end
		
        % ----- 1st card is used as trigger master (un-comment the second line to have external trigger on card 0 -----
        [success, cardInfos(1)] = spcMSetupTrigSoftware (cardInfos(1), 0);  % trigger output : enable = 1, disable = 0
		%[success, cardInfos(1)] = spcMSetupTrigExternal (cardInfos(1), mRegs('SPC_TM_POS'), 0, 0, 1, 0);
       
        error = 0;
        syncEnableMask = bitshift (1, cardCount) - 1;
        syncClkMask = bitshift (1, (cardCount-1));
        
        % ----- sync setup, all card activated, last card is clock master -----
        error = error + spcm_dwSetParam_i32 (hSync, mRegs('SPC_SYNC_ENABLEMASK'), syncEnableMask);
        
        if cardInfos(idx).isM2i == true
            error = error + spcm_dwSetParam_i32 (hSync, mRegs('SPC_SYNC_CLKMASK'), syncClkMask);
        end
        
        % ----- start the card and wait for ready with timeout of 5 seconds (5000 ms) -----
        error = error + spcm_dwSetParam_i32 (hSync, mRegs('SPC_TIMEOUT'), 5000);
        
        if error == 0
            
            % ----- set command flags -----
            commandMask = bitor (mRegs('M2CMD_CARD_START'), mRegs('M2CMD_CARD_ENABLETRIGGER'));
            error = spcm_dwSetParam_i32 (hSync, mRegs('SPC_M2CMD'), commandMask);
            
            fprintf ('Try to record %d MS for each card, acquisition startet ...\n', samplesToRec_MS);
            
            % ----- set dataType: 0 = RAW (int16), 1 = Amplitude calculated (float) -----
            dataType = 0;

            transferred_MS = 0;
            transferred_Samples = 0;
            
            while transferred_MS < samplesToRec_MS    
                for idx = 1 : cardCount
                    % ***** wait for the next block *****
                    errorCode = spcm_dwSetParam_i32 (cardInfos(idx).hDrv, mRegs('SPC_M2CMD'), mRegs('M2CMD_DATA_WAITDMA'));
                    if (errorCode ~= 0)
                        break;
                    end
                  
                    if cardInfos(idx).cardFunction == mRegs ('SPCM_TYPE_AI')
        
                        % ***** get analog input data *****
                        switch cardInfos(idx).setChannels
            
                            case 1
                                % ----- get data block for one channel with offset = 0 ----- 
                                [errorCode, Dat_Block_Ch0] = spcm_dwGetData (cardInfos(idx).hDrv, 0, notifySize/cardInfos(idx).setChannels, cardInfos(idx).setChannels, dataType);
                            case 2
                                % ----- get data block for two channels with offset = 0 ----- 
                                [errorCode, Dat_Block_Ch0, Dat_Block_Ch1] = spcm_dwGetData (cardInfos(idx).hDrv, 0, notifySize/cardInfos(idx).setChannels, cardInfos(idx).setChannels, dataType);
                            case 4
                                % ----- get data block for four channels with offset = 0 ----- 
                                [errorCode, Dat_Block_Ch0, Dat_Block_Ch1, Dat_Block_Ch2, Dat_Block_Ch3] = spcm_dwGetData (cardInfos(idx).hDrv, 0, notifySize/cardInfos(idx).setChannels, cardInfos(idx).setChannels, dataType);
                        end
    
                    else
                        % ***** get digital input data *****
        
                        % ----- get whole digital data in one multiplexed data block -----
                        [errorCode, RAWData] = spcm_dwGetRawData (cardInfos(idx).hDrv, 0, notifySize, 2);
                    end
                    
                    if (errorCode ~= 0)
                        break;
                    end
                    
                    % !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    % !!!!!!!!!! this is the point to do anything with the data !!!!!!!!!!
                    % !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                end
                
                if (errorCode ~= 0)
                    break;
                end
                
                transferred_Samples = transferred_Samples + notifySize;
                tmp = floor (transferred_Samples / 1024 / 1024);
                if tmp ~= transferred_MS
                   transferred_MS = tmp;
                   fprintf ('Transferred %d MS\n', transferred_MS);
                end
            end
        end
    end
end

if (errorCode ~= 0)
    if errorCode == mErrors('ERR_TIMEOUT')
        fprintf ('\n..... Timeout !\n');
    else
        fprintf ('\n..... Error occurred !\n');
    end
else
    fprintf ('\n..... Sucessfully finished\n');
end

% ***** close driver *****
if hSync ~= 0
    spcm_vClose (hSync);
end

for idx=1 : cardCount 
    spcMCloseCard (cardInfos(idx));
end
