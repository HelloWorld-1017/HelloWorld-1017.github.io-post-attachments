clc,clear,close all

% Connect to the FRED data server at https://research.stlouisfed.org/fred2/ 
connection = fred("https://research.stlouisfed.org/fred2/");

% Retrieve S&P 500 series financial data
SP500 = fetch(connection,"SP500");

% Close FRED connection
close(connection)

time = SP500.Data(:,1);
T = datestr(time);
T2 = datetime(time,"ConvertFrom","datenum");
