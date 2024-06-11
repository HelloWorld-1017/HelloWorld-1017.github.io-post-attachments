function helperPlot(date,Index,indexName)
% Calculate maximum drawdown
maxIndexEver = nan(numel(Index),1);
dateEver = nan(numel(Index),1);
for i = 1:height(Index)
    [maxIndexEver(i),idx] = max(Index(1:i));
    dateEver(i) = days(date(i)-date(idx));
%     if idx == i
%         dateEver(i) = 0;
%     else
%         dateEver(i) = caldiff([date(idx),date(i)],"days");
%     end
end
drawDown = (maxIndexEver-Index)./maxIndexEver*100;

dateEver = diff(dateEver);
dateEver(dateEver>=0) = [];
dateEver = -dateEver;
% dateEver(dateEver<=31) = [];
% dateEver = dateEver/31;

% Find the first 10% maximum drawdown
[~,maxDrawDownIdx] = maxk(drawDown,ceil(numel(Index)*0.1));

fig = figure("Color","w","Position",[250,231,1466,568]);
tiledlayout(2,2,"TileSpacing","tight")
% Visualize the price index as date
nexttile
set(gca,"FontName","Times New Roman","FontSize",15)
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
plot(date,Index,"Color","b")
scatter(date(maxDrawDownIdx),Index(maxDrawDownIdx),"Marker","x","MarkerEdgeColor","r")
title(sprintf("%s Price index historical data (from %s to %s)",indexName,date(1),date(end)))
xlabel("Date")
xtickformat("yyyy")
ylabel("Price index")

% Visualize the distribution of maximum drawdown
nexttile
set(gca,"FontName","Times New Roman","FontSize",15)
xlabel("Maximum drawdown (%)")
hold(gca,"on"),box(gca,"on")
xlim([0,max(drawDown)])
% Plot the histogram of maximum drawdown
yyaxis left
h1 = histogram(drawDown,100,"FaceColor","b");
ylabel("Frequency")
set(gca,"YColor",[0,0,1])

% Plot the empirical cumulative distribution function
yyaxis right
hold(gca,"on")
set(gca,"YColor",[1,0,0])
ylim([0,1.2])
yticks(0:0.2:1)
yticklabels(0:0.2:1)
[cdfx1,cdfy1] = helperCDF(h1);
stairs(cdfx1,cdfy1,"LineWidth",1.5,"Color","r")

[ecdff,ecdfx] = ecdf(drawDown);
stairs(ecdfx',ecdff',"LineWidth",1.5,"Color","g","LineStyle","-")
helperLine(cdfx1,cdfy1,0.9)
helperLine(cdfx1,cdfy1,0.8)
helperLine(cdfx1,cdfy1,0.5)
box(gca,"off")

%
nexttile
ax3 = gca();
set(gca,"FontName","Times New Roman","FontSize",15)
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
h2 = histogram(dateEver,100,"FaceColor","b");
xlim(h2.BinLimits)
title("The number of days to reach a new high")

nexttile
ax4 = gca();
copy_of_ax3 = copyobj(ax3,fig);
copy_of_ax3.Position = ax4.Position;
delete(ax4)
copy_of_ax3.YLim = [0,10];
copy_of_ax3.XLabel = [];
copy_of_ax3.YLabel = [];
copy_of_ax3.Box = "on";
yline(ax3,10,"--","10","LineWidth",1.5,"Color",0.2*ones(1,3),"FontSize",20)

%
% yyaxis right
% [cdfx2,cdfy2] = helperCDF(h2);
% stairs(cdfx2,cdfy2,"LineWidth",1.5,"Color","r")
%


% % Add title
% gridTitle = sprintf("%s Price Index Historical Index (from %s to %s)", ...
%     indexName,date(1),date(end));
% sgtitle(gridTitle)
end

function [cdfx,cdfy] = helperCDF(h)
fs = (h.Values)/sum(h.Values);
cdfx = (h.BinEdges(1:end-1)+h.BinEdges(2:end))/2;
cdfy = cumsum(fs);
end

function helperLine(x,y,k)
idx = find(y>=k);
xline(x(idx(1)),"--",sprintf("%.2f%%",x(idx(1))), ...
    "LineWidth",1.5,"Color",0.2*ones(1,3),"FontSize",20)
yline(y(idx(1)),"--",sprintf("%.2f",y(idx(1))), ...
    "LineWidth",1.5,"Color",0.2*ones(1,3),"FontSize",20)
scatter(x(idx(1)),y(idx(1)),100,"Marker","x","MarkerEdgeColor","r","LineWidth",2)
end

