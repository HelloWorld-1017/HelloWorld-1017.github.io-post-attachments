clc,clear,close all

load('results-Epochs10000-1000.mat')
numEpoch = 10000;
numGs = 10:10:1000;
% numGs = 1e3:100:1e4;
% numGs = 1e4:200:2e4;

figure("Position",[197,30,1553,840],"Color","w")
tiledlayout(2,1)
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
plot(numGs,pValue_As,"LineWidth",1.5,"DisplayName","Wiki version","Color","b","Marker","o")
plot(numGs,pValue_skew_correcteds,"LineWidth",1.5,"DisplayName","Real Statistics Version","Color","r","Marker","square")
xlabel("Sample size")
ylabel("p-value")
legend("Location","southeast")
title(sprintf("Test for skewness (the number of repeated experiment: %s)",num2str(numEpoch)))
ylim([0,1])

nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
plot(numGs,pValue_Bs,"LineWidth",1.5,"DisplayName","Wiki version","Color","b","Marker","o")
plot(numGs,pValue_kurt_correcteds,"LineWidth",1.5,"DisplayName","Real Statistics Version","Color","r","Marker","square")
xlabel("Sample size")
ylabel("p-value")
legend("Location","southeast")
title(sprintf("Test for kurtosis (the number of repeated experiment: %s)",num2str(numEpoch)))
ylim([0,1])

pngFileName = sprintf("results-Epochs%s-%s.png",num2str(numEpoch),num2str(numGs(end)));
exportgraphics(gcf,pngFileName,"Resolution",600)