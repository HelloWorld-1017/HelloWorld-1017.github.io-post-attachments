clc,clear,close all

load nets2.mat
figure("Color","w","Position",[289.8,127.4,968,603.2])
tiledlayout(3,2,"TileSpacing","tight")
helperPlot(nets_default,"Loss")
helperPlot(nets_default,"Accuracy")
helperPlot(nets_shuffle,"Loss")
helperPlot(nets_shuffle,"Accuracy")
helperPlot(nets_none,"Loss")
helperPlot(nets_none,"Accuracy")

function helperPlot(nets_info,TEXT)
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
iterations = 1:nets_info(1).info.OutputNetworkIteration;
% n = numel(nets_info);
n = 10;
values = nan(n,numel(iterations));
for i = 1:n
    plot(1:nets_info(i).info.OutputNetworkIteration, ...
        nets_info(i).info.("Training"+TEXT),"Color",0.7*[1,1,1]);
    
    values(i,:) = nets_info(i).info.("Training"+TEXT);
end
rightPart = std(values)*abs(tinv(0.05/2,n-1))/sqrt(n);
ci = fill([iterations,fliplr(iterations)], ...
    [mean(values)+rightPart,fliplr(mean(values)-rightPart)],"r", ...
    "FaceAlpha",0.7,"EdgeColor","none");
plot(iterations,mean(values),"LineWidth",1,"Color","b")
% uistack(ci,"bottom")
ylabel(TEXT)
xlabel("Iteration")
end
