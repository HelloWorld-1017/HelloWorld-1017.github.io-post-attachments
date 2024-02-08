clc,clear,close all

% Convert the indices to one-hot vector.
% 3 observations and 4 classes
ind = [3,1,2];
n = 4;
vecConverted = full(ind2vec(ind,n)); 

% Convert one-hot matrix to indices.
[indConverted,n] = vec2ind(vecConverted);
