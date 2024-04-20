clc,clear,close all

% Load an MRI dataset
load mristack

% Display the dataset
% `montage` treats the data as a multiframe image and displays each slice
figure("Color","w")
img = montage(mristack);
