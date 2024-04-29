clc,clear,close all

% Create a string array containing a series of file names
fileFolder = fullfile(matlabroot,"toolbox","images","imdata");
dirOutput = dir(fullfile(fileFolder,"AT3_1m4_*.tif"));
fileNames = string({dirOutput.name});

% Display the images as a rectangular montage
% Specify the shape of the montage as a 2-by-5 rectangle.
fig1 = figure("Color","w");
montage(fileNames,"Size",[2,5]);
title("Specify the shape of the montage as a 2-by-5 rectangle")

% Adjust the contrast of the images in the montage (ONLY functional for gray images)
fig2 = figure("Color","w");
montage(fileNames,"Size",[2,5],"DisplayRange",[75,200]);
title("Adjust the contrast of the images in the montage")