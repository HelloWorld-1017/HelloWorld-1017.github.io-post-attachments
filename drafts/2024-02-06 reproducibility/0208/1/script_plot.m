clc,clear,close all

loss_default = nan(10,2840);
loss_shuffle = nan(10,2840);
loss_none = nan(10,2840);

figure("Color","w","Position",[145,192.2,1170.4,339.2])
tiledlayout(1,3)
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
for i = 1:10
    fileName = sprintf("losses%s_%s.mat",num2str(i),"default");
    s = load(fileName);
    x = 1:numel(s.losses);
    y = s.losses;
    interval = 10;
    plot(x(1:interval:end),y(1:interval:end))

    loss_default(i,:) = y;
end
ylim([0,6])

nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
for i = 1:10
    fileName = sprintf("losses%s_%s.mat",num2str(i),"shuffle");
    s = load(fileName);
    x = 1:numel(s.losses);
    y = s.losses;
    interval = 10;
    plot(x(1:interval:end),y(1:interval:end))
    
    loss_shuffle(i,:) = y;
end
ylim([0,6])

nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
for i = 1:10
    fileName = sprintf("losses%s_%s.mat",num2str(i),"none");
    s = load(fileName);
    x = 1:numel(s.losses);
    y = s.losses;
    interval = 10;
    plot(x(1:interval:end),y(1:interval:end))

    loss_none(i,:) = y;
end
ylim([0,6])


disp(mean(std(loss_default)))
disp(mean(std(loss_shuffle)))
disp(mean(std(loss_none)))



