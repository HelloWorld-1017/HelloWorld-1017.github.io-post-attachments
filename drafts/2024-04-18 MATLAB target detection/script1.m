clc,clear,close all
rng("default")

% Unzip the vehicle images and load the vehicle ground truth data
unzip vehicleDatasetImages.zip
data = load("vehicleDatasetGroundTruth.mat");
vehicleDataset = data.vehicleDataset;

% Add the full path to the local vehicle data folder.
vehicleDataset.imageFilename = fullfile(pwd,vehicleDataset.imageFilename);

% Dataset partition
shuffledIndices = randperm(height(vehicleDataset));
idx = floor(0.6*length(shuffledIndices));
trainingDataTbl = vehicleDataset(shuffledIndices(1:idx),:);
testDataTbl = vehicleDataset(shuffledIndices(idx+1:end),:);

% Create image datastores for loading the images
imdsTrain = imageDatastore(trainingDataTbl.imageFilename);
imdsTest = imageDatastore(testDataTbl.imageFilename);

% Create datastore for the ground truth bounding boxes
bldsTrain = boxLabelDatastore(trainingDataTbl(:,2));
bldsTest = boxLabelDatastore(testDataTbl(:,2));

% Combine the image and box label datastores
trainingData = combine(imdsTrain,bldsTrain);
testData = combine(imdsTest,bldsTest);

% Use validateInputData to detect invalid images, bounding boxes or labels
validateInputData(trainingData);
validateInputData(testData);

% Data augmentation
augmentedTrainingData = transform(trainingData,@augmentData);

% Visualize the augmented images
% Read the same image four times and display the augmented training data
augmentedData = cell(4,1);
for k = 1:4
    data = read(augmentedTrainingData);
    augmentedData{k} = insertShape(data{1,1},"Rectangle", data{1,2});
    reset(augmentedTrainingData);
end
figure
montage(augmentedData,"BorderSize", 10)


% Specify a network input size
networkInputSize = [227,227,3];








