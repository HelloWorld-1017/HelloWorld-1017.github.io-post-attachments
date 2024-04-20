clc,clear,close all

% Connect to the FRED data server
connection = fred("https://research.stlouisfed.org/fred2/");

% Retrieve S&P 500 series financial data
SP500 = fetch(connection,"SP500");

% Retrieve CBOE Volatility Index (VIX) series
VIX = fetch(connection,"VIXCLS");

% Close FRED connection
close(connection)

dateSP500 = datetime(SP500.Data(:,1),"ConvertFrom","datenum");
seriesSP500 = SP500.Data(:,2);
dateVIX = datetime(VIX.Data(:,1),"ConvertFrom","datenum");
seriesVIX = VIX.Data(:,2);
clear SP500 VIX

idxAlignment = find(dateSP500(1)==dateVIX);
dateVIX(1:idxAlignment-1) = [];
seriesVIX(1:idxAlignment-1) = [];
dateSP500(end) = [];
seriesSP500(end) = [];

idxNaNofSP500 = isnan(seriesSP500);
dateSP500(idxNaNofSP500) = [];
seriesSP500(idxNaNofSP500) = [];
dateVIX(idxNaNofSP500) = [];
seriesVIX(idxNaNofSP500) = [];

idxNaNofVIX = isnan(seriesVIX);
dateSP500(idxNaNofVIX) = [];
seriesSP500(idxNaNofVIX) = [];
dateVIX(idxNaNofVIX) = [];
seriesVIX(idxNaNofVIX) = [];

figure("color","w")
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
yyaxis left
plot(dateSP500,seriesSP500);
yyaxis right
plot(dateVIX,seriesVIX)
xtickformat("yyyy")


% seriesSP500 = normalize(seriesSP500);
% seriesVIX = normalize(seriesVIX);


corr(seriesSP500,seriesVIX)
corr(seriesSP500(31:end),seriesVIX(1:end-30))

corr(seriesSP500,seriesVIX,"type","Kendall")
corr(seriesSP500(31:end),seriesVIX(1:end-30),"type","Kendall")

corr(seriesSP500,seriesVIX,"type","Spearman")
corr(seriesSP500(31:end),seriesVIX(1:end-30),"type","Spearman")

figure
[c,lags] = xcorr(seriesSP500,seriesVIX);
stem(lags,c)








