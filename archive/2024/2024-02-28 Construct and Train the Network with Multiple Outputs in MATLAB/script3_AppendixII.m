clc,clear,close all
rng("default")

% Load training data
[XTrain,T1Train,T2Train] = digitTrain4DArrayData;

dsXTrain = arrayDatastore(XTrain,IterationDimension=4);
dsT1Train = arrayDatastore(T1Train);
dsT2Train = arrayDatastore(T2Train);

dsTrain = combine(dsXTrain,dsT1Train,dsT2Train);

classNames = categories(T1Train);
numClasses = numel(classNames);
numObservations = numel(T1Train);

% Define deep learning model
% Define the main block of layers as a layer graph.
layers = [
    imageInputLayer([28 28 1],Normalization="none")

    convolution2dLayer(5,16,Padding="same")
    batchNormalizationLayer
    reluLayer(Name="relu_1")

    convolution2dLayer(3,32,Padding="same",Stride=2)
    batchNormalizationLayer
    reluLayer
    convolution2dLayer(3,32,Padding="same")
    batchNormalizationLayer
    reluLayer

    additionLayer(2,Name="add")

    fullyConnectedLayer(numClasses)
    softmaxLayer(Name="softmax")];

lgraph = layerGraph(layers);

% And the skip connection
layers = [
    convolution2dLayer(1,32,Stride=2,Name="conv_skip")
    batchNormalizationLayer
    reluLayer(Name="relu_skip")];

lgraph = addLayers(lgraph,layers);
lgraph = connectLayers(lgraph,"relu_1","conv_skip");
lgraph = connectLayers(lgraph,"relu_skip","add/in2");

% Add the fully connected layer for regression.
layers = fullyConnectedLayer(1,Name="fc_2");
lgraph = addLayers(lgraph,layers);
lgraph = connectLayers(lgraph,"add","fc_2");

% Create a dlnetwork object from the layer graph.
net = dlnetwork(lgraph);

% Specify Training Options
numEpochs = 30;
miniBatchSize = 128;

% Train the network
mbq = minibatchqueue(dsTrain,...
    MiniBatchSize=miniBatchSize,...
    MiniBatchFcn=@preprocessData,...
    MiniBatchFormat=["SSCB" "" ""]);

% Initialize the training progress plot.
figure("Color","w")
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
C = colororder;
lineLossTrain = animatedline("Color",C(2,:));
ylim([0 inf])
xlabel("Iteration")
ylabel("Loss")

% Initialize parameters for Adam.
trailingAvg = [];
trailingAvgSq = [];

% Train the model
iteration = 0;
start = tic;

losses = [];
lossLabels = [];
lossAngles = [];
% Loop over epochs.
for epoch = 1:numEpochs

    % Shuffle data.
    shuffle(mbq)

    % Loop over mini-batches
    while hasdata(mbq)

        iteration = iteration + 1;

        [X,T1,T2] = next(mbq);

        % Evaluate the model loss, gradients, and state using
        % the dlfeval and modelLoss functions.
        [loss,gradients,state,lossLabel,lossAngle] = dlfeval(@modelLoss_modified,net,X,T1,T2);
        losses = [losses,loss];
        lossLabels = [lossLabels,lossLabel];
        lossAngles = [lossAngles,lossAngle];
        net.State = state;

        % Update the network parameters using the Adam optimizer.
        [net,trailingAvg,trailingAvgSq] = adamupdate(net,gradients, ...
            trailingAvg,trailingAvgSq,iteration);

        % Display the training progress.
        D = duration(0,0,toc(start),Format="hh:mm:ss");
        loss = double(loss);
        addpoints(lineLossTrain,iteration,loss)
        title("Epoch: " + epoch + ", Elapsed: " + string(D))
        drawnow
    end
end

% Test the model
% Load test data set
[XTest,T1Test,T2Test] = digitTest4DArrayData;

dsXTest = arrayDatastore(XTest,IterationDimension=4);
dsT1Test = arrayDatastore(T1Test);
dsT2Test = arrayDatastore(T2Test);

dsTest = combine(dsXTest,dsT1Test,dsT2Test);

mbqTest = minibatchqueue(dsTest,...
    MiniBatchSize=miniBatchSize,...
    MiniBatchFcn=@preprocessData,...
    MiniBatchFormat=["SSCB" "" ""]);

classesPredictions = [];
anglesPredictions = [];
classCorr = [];
angleDiff = [];

% Loop over mini-batches.
while hasdata(mbqTest)

    % Read mini-batch of data.
    [X,T1,T2] = next(mbqTest);

    % Make predictions using the predict function.
    [Y1,Y2] = predict(net,X,Outputs=["softmax" "fc_2"]);

    % Determine predicted classes.
    Y1 = onehotdecode(Y1,classNames,1);
    classesPredictions = [classesPredictions Y1]; %#ok

    % Dermine predicted angles
    Y2 = extractdata(Y2);
    anglesPredictions = [anglesPredictions Y2]; %#ok

    % Compare predicted and true classes
    T1 = onehotdecode(T1,classNames,1);
    classCorr = [classCorr Y1 == T1]; %#ok

    % Compare predicted and true angles
    angleDiffBatch = Y2 - T2;
    angleDiffBatch = extractdata(gather(angleDiffBatch));
    angleDiff = [angleDiff angleDiffBatch]; %#ok
end

% Evaluate the classification accuracy.
accuracy = mean(classCorr);

% Evaluate the regression accuracy
angleRMSE = sqrt(mean(angleDiff.^2));

% View some of the images with their predictions. 
% Display the predicted angles in red and the correct labels in green.
idx = randperm(size(XTest,4),9);
figure("Color","w")
for i = 1:9
    subplot(3,3,i)
    I = XTest(:,:,:,idx(i));
    imshow(I)
    hold on

    sz = size(I,1);
    offset = sz/2;

    thetaPred = anglesPredictions(idx(i));
    plot(offset*[1-tand(thetaPred) 1+tand(thetaPred)],[sz 0],"r--")

    thetaValidation = T2Test(idx(i));
    plot(offset*[1-tand(thetaValidation) 1+tand(thetaValidation)],[sz 0],"g--")

    hold off
    label = string(classesPredictions(idx(i)));
    title("Label: " + label)
end

% Plot losses
figure("Position",[643.66,445.66,940.66,645.33],"Color","w")
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
set(gca,"FontSize",15,"FontName","Times New Roman")
LineWidth = 1.2;
plot(1:numel(lossLabels),1e-6*lossLabels, ...
    "DisplayName","Classification loss","LineWidth",LineWidth)
plot(1:numel(lossAngles),lossAngles, ...
    "DisplayName","Regression loss","LineWidth",LineWidth)
plot(1:numel(lossAngles),1e6*lossAngles, ...
    "DisplayName","0.1 $\times$ regression loss","LineWidth",LineWidth)
plot(1:numel(losses),losses, ...
    "DisplayName","Total loss","LineWidth",LineWidth)
xlabel("Iteration")
ylabel("Loss")
legend("Interpreter","latex")

% Define the modified model loss function
function [loss,gradients,state,lossLabels,lossAngles] = modelLoss_modified(net,X,T1,T2)
[Y1,Y2,state] = forward(net,X,Outputs=["softmax" "fc_2"]);

lossLabels = crossentropy(Y1,T1);
lossAngles = mse(Y2,T2);

loss = 1e-6*lossLabels + 1e6*lossAngles;
gradients = dlgradient(loss,net.Learnables);
end
