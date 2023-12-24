clc,clear,close all

t = 0:0.1:1;

f = @(t) 3*exp(t.^2/2)-t.^2-2;
IV = 1;
[t1,y1] = helperEuler([0,1],IV,numel(t)-1);
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
axis([0,1,0.8,2.2])
plot(t,f(t))
plot(t1,y1)


function [t,y] = helperEuler(interval,y0,n)
h = (interval(2)-interval(1))/n;
t = nan(numel(n),1);
y = nan(numel(n),1);

t(1) = interval(1);
y(1) = y0;

for i = 1:n
    t(i+1) = t(i)+h;
    y(i+1) = eulerStep(t(i),y(i),h);
end
end

function y = eulerStep(t,y,h)
y = y+h*func(t,y);
end

function z = func(t,y)
z = t*y+t^3;
end

