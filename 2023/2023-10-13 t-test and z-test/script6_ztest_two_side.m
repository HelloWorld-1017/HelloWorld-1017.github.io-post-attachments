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
u_lowAlphaDiv2 = abs(norminv(significance_level/2,0,1));
interval = [mean(x)-sigma*u_lowAlphaDiv2/sqrt(n),...
    mean(x)+sigma*u_lowAlphaDiv2/sqrt(n)]

% Calculate p-value
pValue = 2*normcdf(-abs(z),0,1)

% Test null hypothesis
if pValue < significance_level
    h = 1
else
    h = 0
end

% % Plot schematics
% figure
% hold(gca,"on"),box(gca,"on"),grid(gca,"on")
% xx = -10:0.01:10;
% plot(xx,normpdf(xx,0,1))
% legend()
% 
% stem([norminv(pValue/2,0,1),-norminv(pValue/2,0,1)],...
%     normpdf([norminv(pValue/2,0,1),-norminv(pValue/2,0,1)],0,1),"filled")