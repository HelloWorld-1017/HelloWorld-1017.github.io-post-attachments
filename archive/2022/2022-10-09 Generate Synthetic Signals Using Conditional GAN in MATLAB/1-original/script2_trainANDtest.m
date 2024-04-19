clc,clear,close all

% Load the training data set and standardize the signals to have zero mean and unit variance.
load(fullfile(pwd,"PumpSignalGAN","simulatedDataset.mat")) % load data set
meanFlow = mean(flow,2);
flowNormalized = flow-meanFlow;
stdFlow = std(flowNormalized(:));
flowNormalized = flowNormalized/stdFlow;

%% Define Gnerator Network
numFilters = 64;
numLatentInputs = 100;
projectionSize = [4 1 1024];
numClasses = 2;
embeddingDimension = 100;

layersGenerator = [
    imageInputLayer([1 1 numLatentInputs],'Normalization','none','Name','in')
    projectAndReshapeLayer(projectionSize,numLatentInputs,'proj');
    concatenationLayer(3,2,'Name','cat');
    transposedConv2dLayer([5 1],8*numFilters,'Name','tconv1')
    batchNormalizationLayer('Name','bn1','Epsilon',5e-5)
    reluLayer('Name','relu1')
    transposedConv2dLayer([10 1],4*numFilters,'Stride',4,'Cropping',[1 0],'Name','tconv2')
    batchNormalizationLayer('Name','bn2','Epsilon',5e-5)
    reluLayer('Name','relu2')
    transposedConv2dLayer([12 1],2*numFilters,'Stride',4,'Cropping',[1 0],'Name','tconv3')
    batchNormalizationLayer('Name','bn3','Epsilon',5e-5)
    reluLayer('Name','relu3')
    transposedConv2dLayer([5 1],numFilters,'Stride',4,'Cropping',[1 0],'Name','tconv4')
    batchNormalizationLayer('Name','bn4','Epsilon',5e-5)
    reluLayer('Name','relu4')
    transposedConv2dLayer([7 1],1,'Stride',2,'Cropping',[1 0],'Name','tconv5')
    ];

lgraphGenerator = layerGraph(layersGenerator);

layers = [
    imageInputLayer([1 1],'Name','labels','Normalization','none')
    embedAndReshapeLayer(projectionSize(1:2),embeddingDimension,numClasses,'emb')];

lgraphGenerator = addLayers(lgraphGenerator,layers);
lgraphGenerator = connectLayers(lgraphGenerator,'emb','cat/in2');

% To train the network with a custom training loop and enable automatic differentiation
% Convert the layer graph to a dlnetwork object.
dlnetGenerator = dlnetwork(lgraphGenerator);

%% Define Discriminator Network
scale = 0.2;
inputSize = [1201 1 1];

layersDiscriminator = [
    imageInputLayer(inputSize,'Normalization','none','Name','in')
    concatenationLayer(3,2,'Name','cat')
    convolution2dLayer([17 1],8*numFilters,'Stride',2,'Padding',[1 0],'Name','conv1')
    leakyReluLayer(scale,'Name','lrelu1')
    convolution2dLayer([16 1],4*numFilters,'Stride',4,'Padding',[1 0],'Name','conv2')
    leakyReluLayer(scale,'Name','lrelu2')
    convolution2dLayer([16 1],2*numFilters,'Stride',4,'Padding',[1 0],'Name','conv3')
    leakyReluLayer(scale,'Name','lrelu3')
    convolution2dLayer([8 1],numFilters,'Stride',4,'Padding',[1 0],'Name','conv4')
    leakyReluLayer(scale,'Name','lrelu4')
    convolution2dLayer([8 1],1,'Name','conv5')];

lgraphDiscriminator = layerGraph(layersDiscriminator);

layers = [
    imageInputLayer([1 1],'Name','labels','Normalization','none')
    embedAndReshapeLayer(inputSize,embeddingDimension,numClasses,'emb')];

lgraphDiscriminator = addLayers(lgraphDiscriminator,layers);
lgraphDiscriminator = connectLayers(lgraphDiscriminator,'emb','cat/in2');

% Convert the layer graph to a dlnetwork object.
dlnetDiscriminator = dlnetwork(lgraphDiscriminator);

%% Tain Model
% Specify training options
params.numLatentInputs = numLatentInputs;
params.numClasses = numClasses;
params.sizeData = [inputSize length(labels)];
params.numEpochs = 1000;
params.miniBatchSize = 256;

% Specify the options for Adam optimizer
params.learnRate = 0.0002;
params.gradientDecayFactor = 0.5;
params.squaredGradientDecayFactor = 0.999;
executionEnvironment = "gpu";
params.executionEnvironment = executionEnvironment;

trainNow = true; % or false

if trainNow
    % Train the CGAN
    [dlnetGenerator,dlnetDiscriminator] = trainGAN(dlnetGenerator, ...
        dlnetDiscriminator,flowNormalized,labels,params); 
else
    % Use pretrained CGAN (default)
    load(fullfile(pwd, "GANModel.mat")) % load data set
end

%% Synthesize Flow Signals
rng("default")

% Generate 2000 signals
numTests = 2000;
ZNew = randn(1,1,numLatentInputs,numTests,'single');
dlZNew = dlarray(ZNew,'SSCB');

% Specify that the first 1000 random arrays are healthy and the rest are faulty.
TNew = ones(1,1,1,numTests,'single');
TNew(1,1,1,numTests/2+1:end) = single(2);
dlTNew = dlarray(TNew,'SSCB');

% To generate signals using the GPU, convert the data to gpuArray objects
if executionEnvironment == "gpu"
    dlZNew = gpuArray(dlZNew);
    dlTNew = gpuArray(dlTNew);
end

% Use the predict function on the generator with the batch of 1-by-1-by-100 arrays of random values and labels to generate synthetic signals 
% and revert the standardization step that you performed on the original flow signals.
dlXGeneratedNew = predict(dlnetGenerator,dlZNew,dlTNew)*stdFlow+meanFlow;

% Signal Feature Visualization
% Feature extraction
% Combine the original real signal and the generated signals in one data matrix. 
% Use the helper function extractFeatures to extract the feature including common signal statistics 
% such as the mean and variance as well as spectral characteristics. 
idxGenerated = 1:numTests;
idxReal = numTests+1:numTests+size(flow,2);

XGeneratedNew = squeeze(extractdata(gather(dlXGeneratedNew)));
x = [XGeneratedNew single(flow)];

features = zeros(size(x,2),14,'like',x);
for ii = 1:size(x,2)
    features(ii,:) = extractFeatures(x(:,ii));
end
% Each row of features corresponds to the features of one signal

% Modify the labels for the generated healthy and faulty signals 
% as well as real healthy and faulty signals.
L = [squeeze(TNew)+2;labels.'];
% The labels now have these definitions:
% 1: Generated healthy signals
% 2: Generated faulty signals
% 3: Real healthy signals
% 4: Real faulty signals

% Principal Component Analysis (via svd)
featuresReal = features(idxReal,:);
mu = mean(featuresReal,1);
[~,S,W] = svd(featuresReal-mu);
S = diag(S);
Y = (features-mu)*W;

sum(S(1:3))/sum(S)

% Plot the features of all the signals using the first three principal components. 
% In the PCA subspace, the distribution of the generated signals is similar to the distribution of the real signals.
idxHealthyR = L==1;
idxFaultR = L==2;

idxHealthyG = L==3;
idxFaultG = L==4;

pp = Y(:,1:3);

figure("Color","w")
scatter3(pp(idxHealthyR,1),pp(idxHealthyR,2),pp(idxHealthyR,3),'o')
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
zlabel('3rd Principal Component')
hold on
scatter3(pp(idxFaultR,1),pp(idxFaultR,2),pp(idxFaultR,3),'d')
scatter3(pp(idxHealthyG,1),pp(idxHealthyG,2),pp(idxHealthyG,3),'s')
scatter3(pp(idxFaultG,1),pp(idxFaultG,2),pp(idxFaultG,3),'+')
view(-10,20)
legend('Real healthy','Real faulty','Generated healthy','Generated faulty', ...
    'Location','Best')
hold off

%%  Predict Labels of Real Signals
% Set the generated signals as the training data set and 
% the real signals as the test data set. 
% Change the numeric labels to character vectors.
LABELS = {'Healthy','Faulty'};
strL = LABELS([squeeze(TNew);labels.']).';

dataTrain = features(idxGenerated,:);
dataTest = features(idxReal,:);

labelTrain = strL(idxGenerated);
labelTest = strL(idxReal);

predictors = dataTrain; 
response = labelTrain;
cvp = cvpartition(size(predictors,1),'KFold',5);

% Train an SVM classifier using the generated signals.
SVMClassifier = fitcsvm( ...
    predictors(cvp.training(1),:), ...
    response(cvp.training(1)),'KernelFunction','polynomial', ...
    'PolynomialOrder',2, ...
    'KernelScale','auto', ...
    'BoxConstraint',1, ...
    'ClassNames',LABELS, ...
    'Standardize',true);

% Use the trained classifier to obtain the predicted labels for the real signals. 
% The classifier achieves a prediction accuracy above 90%.
actualValue = labelTest;
predictedValue = predict(SVMClassifier,dataTest);
predictAccuracy = mean(cellfun(@strcmp,actualValue,predictedValue))

figure("Color","w")
confusionchart(actualValue,predictedValue)

%% Case study
% From the plot, the generated healthy signal has relatively high power values at 47.5 Hz and 2 times 47.5 Hz, 
% which is exactly the same as the real healthy signal.
Fs = 1000;
pspectrum([x(:,1) x(:,2006)],Fs)
set(gca,'XScale','log')
legend('Generated healthy','Real healthy')

% Plot the spectra for one case of real and generated faulty signals. 
% The generated signal has relatively high power values at around 15.833 Hz and its harmonics, 
% which is similar to the real faulty signal.
pspectrum([x(:,1011) x(:,2100)],Fs)
set(gca,'XScale','log')
legend('Generated faulty','Real faulty')

% Plot spectra for another case of real and generated faulty signals. 
% The spectral characteristics of the generated faulty signals do not match the theoretical analysis very well and 
% are different from the real faulty signal. 
% NOTE WELL HERE: The CGAN can still be possibly improved by tuning the network structure or hyperparameters.
pspectrum([x(:,1001) x(:,2600)],Fs)
set(gca,'XScale','log')
legend('Generated faulty','Real faulty')


%%  Compare computation time
The Simulink simulation takes about 14 hours to generate 2000 pump flow signals. 
% This duration can be reduced to about 1.7 hours with eight parallel workers if you have Parallel Computing Toolbox™.
% The CGAN takes 1.5 hours to train and 70 seconds to generate the same amount of synthetic data with an NVIDIA Titan V GPU.
% 
% Copyright 2020 The MathWorks, Inc.
