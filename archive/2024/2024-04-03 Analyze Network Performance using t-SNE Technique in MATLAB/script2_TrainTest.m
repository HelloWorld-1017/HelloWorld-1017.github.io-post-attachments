clc,clear,close all
rng("default")

% Load the dataset
dataDir = fullfile(pwd,"ExampleFoodImageDataset");

% Define network structure
lgraph = layerGraph(squeezenet());
lgraph = lgraph.replaceLayer("ClassificationLayer_predictions",...
    classificationLayer("Name","ClassificationLayer_predictions"));

newConv =  convolution2dLayer([14,14],9,"Name","conv","Padding","same");
lgraph = lgraph.replaceLayer("conv10",newConv);

% Create training and validation dataset
imds = imageDatastore(dataDir, ...
    "IncludeSubfolders",true,"LabelSource","foldernames");
aug = imageDataAugmenter("RandXReflection",true, ...
    "RandYReflection",true, ...
    "RandXScale",[0.8,1.2], ...
    "RandYScale",[0.8,1.2]);

% Dataset partition and augmentation
trainingFraction = 0.65; % training ratio
[trainImds,valImds] = splitEachLabel(imds,trainingFraction);
augImdsTrain = augmentedImageDatastore([227,227],trainImds, ...
    "DataAugmentation",aug);
augImdsVal = augmentedImageDatastore([227,227],valImds);

% Train the network
options = trainingOptions("adam", ...
    "InitialLearnRate",1e-4, ...
    "MaxEpochs",30, ...
    "ValidationData",augImdsVal, ...
    "Verbose",false,...
    "Plots","training-progress", ...
    "ExecutionEnvironment","auto",...
    "MiniBatchSize",128);
net = trainNetwork(augImdsTrain,lgraph,options);

% Test the network
figure("Color","w");
YPred = classify(net,augImdsVal);
confusionchart(valImds.Labels,YPred,"ColumnSummary","column-normalized")

save("results.mat", ...
    "trainImds","valImds","augImdsTrain","augImdsVal","net","YPred")
