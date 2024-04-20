clc,clear,close all

% Load an MRI dataset
load mristack

% Display the first seven images
figure("Color","w")
img = montage(mristack,"Indices",1:7);
