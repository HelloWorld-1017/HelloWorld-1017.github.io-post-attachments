clc,clear,close all

% Retrieve DJIA series
helperRetrieveAndSaveSeries("DJIA")

function helperRetrieveAndSaveSeries(seriesID)
matName = sprintf("%s_%s.mat",seriesID,string(datetime("now","Format","yyyyMMdd")));

if ~exist(matName,"file")
    % Connect to the FRED data server
    connection = fred("https://research.stlouisfed.org/fred2/");

    % Retrieve series
    series = fetch(connection,seriesID);

    % Close FRED connection
    close(connection)

    % Preprocess Series
    dateOfSeries = datetime(series.Data(:,1),"ConvertFrom","datenum");
    indexOfSeries = series.Data(:,2);

    save(matName,"dateOfSeries","indexOfSeries")
end
end