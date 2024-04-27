clc,clear,close all

% Connect to the FRED data server at https://research.stlouisfed.org/fred2/ 
connection = fred("https://research.stlouisfed.org/fred2/");

% Retrieve S&P 500 series financial data
% startdate = "04/12/2023"; 
% enddate = "04/12/2024";
startdate = "04/12/1998"; 
enddate = "04/12/2025";
SP500 = fetch(connection,"SP500",startdate,enddate);

% Close FRED connection
close(connection)

% For verifying the date range
time = SP500.Data(:,1);
T = datetime(time,"ConvertFrom","datenum");