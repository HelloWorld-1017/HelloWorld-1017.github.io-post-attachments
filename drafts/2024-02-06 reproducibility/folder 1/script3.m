clc,clear,close all

load nets.mat
figure("Color","w","Position",[289.8,127.4,968,603.2])
tiledlayout(3,2,"TileSpacing","tight")
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
for i = 1:numel(nets_default)
%     plot(1:nets_default(i).info.OutputNetworkIteration, ...
%         nets_default(i).info.TrainingLoss)
    iterations = 1:nets_default(i).info.OutputNetworkIteration;
    losses_default(i,:) = nets_default(i).info.TrainingLoss;
end
n = height(losses_default);
rightPart = std(losses_default)*abs(tinv(0.05/2,n-1))/sqrt(n);
% plot(iterations,mean(losses_default)+rightPart,"LineWidth",2)
% plot(iterations,mean(losses_default)-rightPart,"LineWidth",2)
ci = fill([iterations,fliplr(iterations)], ...
    [mean(losses_default)+rightPart,fliplr(mean(losses_default)-rightPart)],"b", ...
    "FaceAlpha",0.2,"EdgeColor","none");
% uistack(ci,"bottom")
ylabel("Loss")
xlabel("Iteration")


nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
for i = 1:numel(nets_default)
    plot(1:nets_default(i).info.OutputNetworkIteration, ...
        nets_default(i).info.TrainingAccuracy)
end
ylabel("Accuracy")
xlabel("Iteration")

nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
for i = 1:numel(nets_shuffle)
%     plot(1:nets_shuffle(i).info.OutputNetworkIteration, ...
%         nets_shuffle(i).info.TrainingLoss)
    losses_shuffle(i,:) = nets_shuffle(i).info.TrainingLoss;
end
ylabel("Loss")
xlabel("Iteration")
n = height(losses_shuffle);
rightPart = std(losses_shuffle)*abs(tinv(0.05/2,n-1))/sqrt(n);
% plot(iterations,mean(losses_shuffle)+rightPart,"LineWidth",2)
% plot(iterations,mean(losses_shuffle)-rightPart,"LineWidth",2)
ci = fill([iterations,fliplr(iterations)], ...
    [mean(losses_shuffle)+rightPart,fliplr(mean(losses_shuffle)-rightPart)],"b", ...
    "FaceAlpha",0.1,"EdgeColor","none");
uistack(ci,"bottom")



nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
for i = 1:numel(nets_default)
    plot(1:nets_shuffle(i).info.OutputNetworkIteration, ...
        nets_shuffle(i).info.TrainingAccuracy)
end
ylabel("Accuracy")
xlabel("Iteration")



nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
for i = 1:numel(nets_default)
    plot(1:nets_none(i).info.OutputNetworkIteration, ...
        nets_none(i).info.TrainingLoss)
end
ylabel("Loss")
xlabel("Iteration")
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
for i = 1:numel(nets_default)
    plot(1:nets_none(i).info.OutputNetworkIteration, ...
        nets_none(i).info.TrainingAccuracy)
end
ylabel("Accuracy")
xlabel("Iteration")
