clc,clear,close all

load nets.mat
figure("Color","w")
num = 3;
tiledlayout(3,num)

for i = 1:num
    nexttile
    cm = confusionchart(nets_default(i).YTest,nets_default(i).predictions);
    cm.DiagonalColor = [0,0,1];
    cm.OffDiagonalColor = [1,0,0];
    title((sum(nets_default(i).YTest==nets_default(i).predictions))/numel(nets_default(i).YTest))
end

for i = 1:num
    nexttile
    cm = confusionchart(nets_shuffle(i).YTest,nets_shuffle(i).predictions);
    cm.DiagonalColor = [0,0,1];
    cm.OffDiagonalColor = [1,0,0];
    title((sum(nets_shuffle(i).YTest==nets_shuffle(i).predictions))/numel(nets_shuffle(i).YTest))
end

for i = 1:num
    nexttile
    cm = confusionchart(nets_none(i).YTest,nets_none(i).predictions);
    cm.DiagonalColor = [0,0,1];
    cm.OffDiagonalColor = [1,0,0];
    title((sum(nets_none(i).YTest==nets_none(i).predictions))/numel(nets_none(i).YTest))
end