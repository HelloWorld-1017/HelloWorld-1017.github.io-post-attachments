---
dfrafted_at: 2024‎-02-22 ‏‎21:33:30 +0800
---



```matlab
clc,clear,close all
rng("default")

% Download data
dataFolder = fullfile(tempdir,"turbofan");
if ~exist(dataFolder,'dir')
    mkdir(dataFolder);
end
filename = matlab.internal.examples.downloadSupportFile("nnet","data/TurbofanEngineDegradationSimulationData.zip");
unzip(filename,dataFolder)

% Prepare training data
filenamePredictors = fullfile(dataFolder,"train_FD001.txt");
[XTrain,YTrain] = processTurboFanDataTrain(filenamePredictors);
m = min([XTrain{:}],[],2);
M = max([XTrain{:}],[],2);
idxConstant = M == m;

for i = 1:numel(XTrain)
    XTrain{i}(idxConstant,:) = [];
end

% Normalize training predictors
mu = mean([XTrain{:}],2);
sig = std([XTrain{:}],0,2);

for i = 1:numel(XTrain)
    XTrain{i} = (XTrain{i} - mu) ./ sig;
end
thr = 150;
for i = 1:numel(YTrain)
    YTrain{i}(YTrain{i} > thr) = thr;
end

% Prepare data for padding
for i=1:numel(XTrain)
    sequence = XTrain{i};
    sequenceLengths(i) = size(sequence,2);
end

[sequenceLengths,idx] = sort(sequenceLengths,'descend');
XTrain = XTrain(idx);
YTrain = YTrain(idx);

% Define network architecture
numFeatures = size(XTrain{1},1);
numResponses = size(YTrain{1},1);
numHiddenUnits = 200;

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits,'OutputMode','sequence')
    fullyConnectedLayer(50)
    dropoutLayer(0.5)
    fullyConnectedLayer(numResponses)
    regressionLayer];

maxEpochs = 60;
miniBatchSize = 20;

options = trainingOptions('adam', ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'InitialLearnRate',0.01, ...
    'GradientThreshold',1, ...
    'Shuffle','never', ...
    'Plots','training-progress',...
    'Verbose',0);

% Train the network
net = trainNetwork(XTrain,YTrain,layers,options);
```





<br>

**References**

[Train Convolutional Neural Network for Regression - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/train-a-convolutional-neural-network-for-regression.html).

[Sequence-to-Sequence Regression Using Deep Learning - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/sequence-to-sequence-regression-using-deep-learning.html).

[MATLAB `trainNetwork`: (Not recommended) Train neural network - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/trainnetwork.html).

[Define Custom Regression Output Layer - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/define-custom-regression-output-layer.html).



