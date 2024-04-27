clc,clear,close all
rng("default")

[images,digits,angles] = digitTrain4DArrayData;

images = reshape(images,28*28,5000)';

% idx = randperm(5000,1000)';
% images = images(idx,:);

% images = rescale(images);


% % mu = mean(images);
% % images = images-mu;
% % sigma = std(images(:));
% % images = images/sigma;

Y = tsne(images,"Algorithm","exact","Perplexity",300,"Standardize",true, ...
    "Distance","euclidean");

figure("color","w")
gs = gscatter(Y(:,1),Y(:,2),digits);
box(gca,"off")
for i = 1:numel(gs)
    gs(i).MarkerSize = 15;
end

% size(images)