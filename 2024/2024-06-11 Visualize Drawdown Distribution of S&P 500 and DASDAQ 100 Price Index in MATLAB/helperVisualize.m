function helperVisualize(date,index,seriesID)
% Preprocess index
index = fillmissing(index,"previous");

% Calculate drawdown for each day
maxIndexEver = nan(numel(index),1);
daysOfToday2PreviousHighest = nan(numel(index),1);
for i = 1:height(index)
    [maxIndexEver(i),idx] = max(index(1:i));
    daysOfToday2PreviousHighest(i) = days(date(i)-date(idx));
end
drawDown = (maxIndexEver-index)./maxIndexEver*100;

% Calculate and show the number of days to a new high
daysOfToday2PreviousHighest = diff(daysOfToday2PreviousHighest);
daysOfToday2PreviousHighest(daysOfToday2PreviousHighest>=0) = [];
daysOfToday2PreviousHighest = -daysOfToday2PreviousHighest;
daysOfToday2PreviousHighest = (daysOfToday2PreviousHighest-1);
daysOfToday2PreviousHighest(daysOfToday2PreviousHighest==0) = [];
[ecdff2,ecdfx2] = ecdf(daysOfToday2PreviousHighest);
dateList = 0.2:0.1:1;
for i = 1:numel(dateList)
    idx = find(ecdff2 >= dateList(i));
    idx = idx(1);
    fprintf("There is a %.2f%% possibility to reach a new high within %d days. \n", ...
        ecdff2(idx)*100,ecdfx2(idx))
end

figure("Color","w","Position",[103,206,1723,600]);
tiledlayout(1,2,"TileSpacing","tight")

% Visualize the price index as date
nexttile
set(gca,"FontName","Times New Roman","FontSize",15)
hold(gca,"on")
plot(date,index,"Color","b")
title("Historical data")
xlabel("Date")
xtickformat("yyyy")
ylabel("Price index")

% Visualize the distribution of maximum drawdown
nexttile
set(gca,"FontName","Times New Roman","FontSize",15)
xlabel("Drawdown (%)")
hold(gca,"on"),box(gca,"on")
xlim([0,max(drawDown)])

% Plot the histogram of drawdown
yyaxis left
histogram(drawDown,100,"FaceColor","b");
ylabel("Frequency")
set(gca,"YColor",[0,0,1])
% Plot the empirical cumulative distribution function
yyaxis right
hold(gca,"on")
set(gca,"YColor",[1,0,0])
ylim([0,1.1])
yticks(0:0.2:1)
yticklabels(0:0.2:1)
[ecdff,ecdfx] = ecdf(drawDown);
stairs(ecdfx',ecdff',"LineWidth",1.5,"Color","r","LineStyle","-")
ylabel("Cumulative probability")
title("Drawdown distribution")

helperLine(ecdfx,ecdff,0.9)
helperLine(ecdfx,ecdff,0.8)
helperLine(ecdfx,ecdff,0.5)
box(gca,"off")

% Add title
gridTitle = sprintf("%s price index (from %s to %s)", ...
    seriesID,date(1),date(end));
sgtitle(gridTitle)
end

function helperLine(x,y,k)
idx = find(y >= k);
xline(x(idx(1)),"--",sprintf("%.2f%%",x(idx(1))), ...
    "LineWidth",1.5,"Color",0.2*ones(1,3),"FontSize",20)
yline(y(idx(1)),"--",sprintf("%.2f",y(idx(1))), ...
    "LineWidth",1.5,"Color",0.2*ones(1,3),"FontSize",20)
scatter(x(idx(1)),y(idx(1)),100,"Marker","x","MarkerEdgeColor","r","LineWidth",2)
end