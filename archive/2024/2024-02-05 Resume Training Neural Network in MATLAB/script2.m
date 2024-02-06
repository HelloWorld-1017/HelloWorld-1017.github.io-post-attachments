clc,clear,close all

rng("default")

% Load checkpoint network
load net_checkpoint__780__2024_02_05__20_02_53.mat

% Prepare training dataset
[XTrain,YTrain] = digitTrain4DArrayData;

% Sepcify training options
options = trainingOptions("sgdm", ...
    "InitialLearnRate",0.05, ...
    "MaxEpochs",15, ...
    "Verbose",false, ...
    "Plots","training-progress", ...
    "Shuffle","every-epoch", ...
    "CheckpointPath",pwd);

% Resume training
net2 = trainNetwork(XTrain,YTrain,net.Layers,options);
