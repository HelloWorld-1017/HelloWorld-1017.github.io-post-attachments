clc,clear,close all

% Create an ImageDatastore object containing a series of ten images from 
% the Image Processing Toolbox™ sample image folder.
fileFolder = fullfile(matlabroot,"toolbox","images","imdata");
imds = imageDatastore(fullfile(fileFolder,"AT3*"));

% Display the contents of the datastore as a montage
figure("Color","w")
montage(imds)

