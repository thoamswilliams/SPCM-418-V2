%**************************************************************************
% Spectrum Matlab Library Package               (c) Spectrum GmbH, 2018
%**************************************************************************
% Supplies different common functions for Matlab programs accessing the 
% SpcM driver interface. Feel free to use this source for own projects and
% modify it in any kind
%**************************************************************************
% spcMInitCardByIdx
% opens the driver with the given index, reads out card information and
% returns a filled cardInfo structure
%**************************************************************************

function [success, cardInfo] = spcMInitCardByIdx (cardIdx)
    
    %open the driver for the card. We can use the linux notation here as the windows driver only looks for the ending number. 
    deviceString = sprintf ('/dev/spcm%d', cardIdx);
    
    [success, cardInfo] = spcMInitDevice (deviceString);
            