clc,clear,close all
rng("default")

[images,digits,angles] = digitTrain4DArrayData;

images = reshape(images,28*28,5000)';

Y = tsne(images,"Distance","minkowski");
gscatter(Y(:,1),Y(:,2),digits)

% size(images)