clc,clear,close all

% load data set
load examgrades
x = grades(:,1);
y = grades(:,2);

n = numel(x);
m = numel(y);

t_degrees = n+m-2;
sx = std(x);
sy = std(y);
s = sqrt(((n-1)*sx^2+(m-1)*sy^2)/t_degrees);

% Construct test statistic
t = (mean(x)-mean(y))/(sqrt((std(x)^2/n)+(std(y)^2/n)))

significance_level = 0.05;

% Interval estimation for \bar{x}, using pivot method
u_lowAlphaDiv2 = abs(tinv(significance_level/2,t_degrees));
interval = [mean(x)-mean(y)-s*u_lowAlphaDiv2*sqrt((n+m)/(n*m)),...
    mean(x)-mean(y)+s*u_lowAlphaDiv2*sqrt((n+m)/(n*m))]

% Calculate p-value
pValue = 2*tcdf(-abs(t),t_degrees)

% Test null hypothesis
if pValue < significance_level
    h = 1
else
    h = 0
end

