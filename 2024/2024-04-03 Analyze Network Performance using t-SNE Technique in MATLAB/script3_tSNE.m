clc,clear,close all
load results.mat

% Compute activations for `pool1`, `conv`, and `prob` layers
earlyLayerName = "pool1";
finalConvLayerName = "conv";
softmaxLayerName = "prob";
pool1Activations = activations(net,...
    augImdsVal,earlyLayerName,"OutputAs","rows");
finalConvActivations = activations(net,...
    augImdsVal,finalConvLayerName,"OutputAs","rows");
softmaxActivations = activations(net,...
    augImdsVal,softmaxLayerName,"OutputAs","rows");

% Conduct t-SNE technique
rng("default") % Attention here, set the random seed for reproducibility of the t-SNE result
pool1tsne = tsne(pool1Activations);
finalConvtsne = tsne(finalConvActivations);
softmaxtsne = tsne(softmaxActivations);

% Plot t-SNE data
markerSize = 7;
classList = unique(valImds.Labels);
numClasses = length(classList);
colors = lines(numClasses);

figure("Color","w","Position",[131,342,1711,328])
tiledlayout(1,3,"TileSpacing","compact")
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
gscatter(pool1tsne(:,1),pool1tsne(:,2),valImds.Labels,colors,'.',markerSize);
title("Max pooling activations")
legend("Location","bestoutside","Interpreter","none")

nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
gscatter(finalConvtsne(:,1),finalConvtsne(:,2),valImds.Labels,colors,'.',markerSize);
title("Final conv activations")
legend("Location","bestoutside","Interpreter","none")

nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
gscatter(softmaxtsne(:,1),softmaxtsne(:,2),valImds.Labels,colors,'.',markerSize);
title("Softmax activations")
legend("Location","bestoutside","Interpreter","none")
