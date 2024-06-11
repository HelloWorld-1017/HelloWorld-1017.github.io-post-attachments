clc,clear,close all

seriesID = "NASDAQ100";
matName = sprintf("%s_%s.mat",seriesID,string(datetime("now","Format","yyyyMMdd")));

if exist(matName,"file")
    series = load(matName);
    helperVisualize(series.dateOfSeries,series.indexOfSeries,seriesID)
end
% exportgraphics(gcf,seriesID+".jpg","Resolution",900)