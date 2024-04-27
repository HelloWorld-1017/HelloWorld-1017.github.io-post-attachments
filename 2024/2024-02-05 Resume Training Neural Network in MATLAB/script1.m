clc,clear,close all

rng("default")

% Prepare training dataset
[XTrain,YTrain] = digitTrain4DArrayData;

% Define newtwork architecture
layers = [
    imageInputLayer([28 28 1])
    
    convolution2dLayer(3,8,"Padding","same")
    batchNormalizationLayer
    reluLayer    
    maxPooling2dLayer(2,"Stride",2) 
    
    convolution2dLayer(3,16,"Padding","same")
    batchNormalizationLayer
    reluLayer    
    maxPooling2dLayer(2,"Stride",2)
    
    convolution2dLayer(3,32,"Padding","same")
    batchNormalizationLayer
    reluLayer   
    averagePooling2dLayer(7)  
    
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];

% Specify Training Options
checkpointPath = pwd;
options = trainingOptions("sgdm", ...
    "InitialLearnRate",0.1, ...
    "MaxEpochs",20, ...
    "Verbose",false, ...
    "Plots","training-progress", ...
    "Shuffle","every-epoch", ...
    "CheckpointPath",checkpointPath);

% Train the network
net1 = trainNetwork(XTrain,YTrain,layers,options);