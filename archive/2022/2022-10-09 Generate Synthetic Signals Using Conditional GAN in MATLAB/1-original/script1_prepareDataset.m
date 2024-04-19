clc,clear,close all

% Download the data
dataURL = 'https://ssd.mathworks.com/supportfiles/SPT/data/PumpSignalGAN.zip';
saveFolder = fullfile(pwd,'PumpSignalGAN'); 
zipFile = fullfile(pwd,'PumpSignalGAN.zip');
if ~exist(saveFolder,'dir')
    websave(zipFile,dataURL);
end

% Unzip the data
unzip(zipFile,saveFolder)