clc,clear,close all

% Load data set
load examgrades
x = grades(:,1);

mu = 65;
sigma = 10;
n = numel(x);
z_degrees = n-1;

% Construct test statistic
z = (mean(x)-mu)/(sigma/sqrt(n))

significance_level = 0.05;

% Interval estimation for \bar{x}, using pivot
u_lowAlpha = abs(norminv(significance_level,0,1));
interval = [mean(x)-sigma*u_lowAlpha/sqrt(n), Inf]

% Calculate p-value
pValue = normcdf(-abs(z),0,1)

% Test null hypothesis
if pValue < significance_level
    h = 1
else
    h = 0
end