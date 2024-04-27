clc,clear,close all

% Load the training data set and standardize the signals to have zero mean and unit variance.
load(fullfile(pwd,"PumpSignalGAN","simulatedDataset.mat")) % load data set
% flow: 1201x1575
% labels: 1x1575

% Normalize the signals
[flowNormalized,meanFlow,stdFlow] = helperNormalizeSignals(flow);

% Define network structure and train the network
% numEpochs = 1000;
numEpochs = 10;
miniBathSize = 256;
[dlnetGenerator,dlnetDiscriminator] = helperDefineNetworkANDTrain(flowNormalized,labels,numEpochs,miniBathSize);