clc,clear,close all

% Define a simple 15-by-15 pixel segmentation matrix of class labels.
A = repmat("blue",8,15);
B = repmat("green",7,5);
C = repmat("black",7,5);
segmentation = [A;B C B];

% Convert the segmentation matrix into a categorical array.
segmentation = categorical(segmentation);

% One-hot encode the segmentation matrix into an array of type single. 
% Expand the encoded labels into the third dimension.
encodedSegmentation = onehotencode(segmentation,3,"single");