clc,clear,close all

% For reproducibility
rng("default")
gpurng("default")

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

figure("Color","w","Position",[105,249,1360.8,374.4])
tiledlayout(1,3)

% Plot the training loss and training accuracy as iteration increases
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
plot(1:info.OutputNetworkIteration,info.TrainingLoss)
ylabel("Loss")
xlabel("Iteration")
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
plot(1:info.OutputNetworkIteration,info.TrainingAccuracy)
ylabel("Accuracy")
xlabel("Iteration")

% Calculate and visualize the confusion matrix
nexttile
cm = confusionchart(YTest,predictions);
cm.DiagonalColor = [0,0,1];
cm.OffDiagonalColor = [1,0,0];
