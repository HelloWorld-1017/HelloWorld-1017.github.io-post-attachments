clc,clear,close all

nets_default = struct();
nets_shuffle = struct();
nets_none = struct();

num = 100;

for i = 1:num
    [nets_default(i).info,nets_default(i).YTest,nets_default(i).predictions] = ...
        helperLoop("default");
    [nets_shuffle(i).info,nets_shuffle(i).YTest,nets_shuffle(i).predictions] = ...
        helperLoop("shuffle");
    [nets_none(i).info,nets_none(i).YTest,nets_none(i).predictions] = ...
        helperLoop();
    disp(i)
end

save("nets2.mat","nets_default","nets_shuffle","nets_none")

function [info,YTest,predictions] = helperLoop(seed)
if nargin == 1
    rng(seed)
    gpurng(seed)
end

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
    "Plots","none", ...
    "Shuffle","once", ...
    "ExecutionEnvironment","auto");

% Train the network
[net,info] = trainNetwork(XTrain,YTrain,layers,options);

% Make a prediction for the test dataset
predictions = net.classify(XTest);
end
