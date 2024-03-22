clc,clear,close all

% Prepare training and test dataset
[XTrain,YTrain] = digitTrain4DArrayData;
[XTest,YTest] = digitTest4DArrayData;

% Define newtwork architecture
layers = [
    imageInputLayer([28,28,1])
    
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

% Specify training options
options = trainingOptions("sgdm", ...
    "InitialLearnRate",0.1, ...
    "MaxEpochs",20, ...
    "Verbose",false, ...
    "Plots","training-progress", ...
    "Shuffle","once", ...
    "ExecutionEnvironment","auto");

% Train the network
[net,info] = trainNetwork(XTrain,YTrain,layers,options);