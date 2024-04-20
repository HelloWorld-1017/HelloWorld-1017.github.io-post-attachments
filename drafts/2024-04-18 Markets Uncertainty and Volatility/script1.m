clc,clear,close all

% Connect to the FRED data server
connection = fred("https://research.stlouisfed.org/fred2/");

% Retrieve S&P 500 series financial data
[dateSP500,seriesSP500] = helperFetchSeries(connection,"SP500");

% Retrieve CBOE Volatility Index (VIX) series
[dateVIX,seriesVIX] = helperFetchSeries(connection,"VIXCLS");

% Close FRED connection
close(connection)

figure("color","w")
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
yyaxis left
plot(dateSP500,seriesSP500,"Color","r","DisplayName","S&P 500");
yyaxis right
plot(dateVIX,seriesVIX,"Color","b","DisplayName","VIX")
xtickformat("yyyy")
xlabel("Date")
legend()


function [seriesDate,seriesData] = helperFetchSeries(connection,seriesID)
% Fetch data from FRED server
Series = fetch(connection,seriesID);

% Extract date
seriesDate = datetime(Series.Data(:,1),"ConvertFrom","datenum");

% Extract corresponding series data
seriesData = Series.Data(:,2);
end



