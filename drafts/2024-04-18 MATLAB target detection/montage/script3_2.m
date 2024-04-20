clc,clear,close all

% Read several images of different types and sizes into the workspace.
imRGB = imread("peppers.png");
imGray = imread("coins.png");

% Display a montage containing all of the images
figure("Color","w")
img = montage({imRGB,imGray,"cameraman.tif"}, ...
    "BackgroundColor","b","BorderSize",[200,100]);
