clc,clear,close all

% Load the example data
filename = "factoryReports.csv";
data = readtable(filename,"TextType","string");

% Convert labels to `categorical`-class array
data.Category = categorical(data.Category);

% Dataset partition
cvp = cvpartition(data.Category,"Holdout",0.1);
dataTrain = data(cvp.training,:);
dataTest = data(cvp.test,:);

% Extract the text data and labels from the tables
textDataTrain = dataTrain.Description;
textDataTest = dataTest.Description;
YTrain = dataTrain.Category;
YTest = dataTest.Category;

% Use the example preprocessing function `preprocessText`
% to prepare the text data.
documents = preprocessText(textDataTrain);

% Create a bag-of-words model from the tokenized documents
bag = bagOfWords(documents);

% Remove words from the bag-of-words model that do not appear more than two times in total. 
% move any documents containing no words from the bag-of-words model, 
% and remove the corresponding entries in labels.
bag = removeInfrequentWords(bag,2);
[bag,idx] = removeEmptyDocuments(bag);
YTrain(idx) = [];

% Train a multiclass linear classification model
XTrain = bag.Counts;
mdl = fitcecoc(XTrain,YTrain,"Learners","linear");

% Test the classifier
documentsTest = preprocessText(textDataTest);
XTest = encode(bag,documentsTest);
YPred = predict(mdl,XTest);
acc = sum(YPred == YTest)/numel(YTest);

% Predict Using New Data
str = [
    "Coolant is pooling underneath sorter."
    "Sorter blows fuses at start up."
    "There are some very loud rattling sounds coming from the assembler."];
documentsNew = preprocessText(str);
XNew = encode(bag,documentsNew);
labelsNew = predict(mdl,XNew);

function documents = preprocessText(textData)
% Tokenize the text.
documents = tokenizedDocument(textData);

% Remove a list of stop words then lemmatize the words. To improve
% lemmatization, first use addPartOfSpeechDetails.
documents = addPartOfSpeechDetails(documents);
documents = removeStopWords(documents);
documents = normalizeWords(documents,"Style","lemma");

% Erase punctuation.
documents = erasePunctuation(documents);

% Remove words with 2 or fewer characters, and words with 15 or more
% characters.
documents = removeShortWords(documents,2);
documents = removeLongWords(documents,15);
end

% Copyright 2018 The MathWorks, Inc.



