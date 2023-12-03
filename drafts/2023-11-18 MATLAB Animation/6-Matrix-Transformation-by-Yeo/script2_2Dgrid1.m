clc,clear,close all

[x,y] = meshgrid(-2:0.5:2);
[m,n] = size(x);

figure
hold(gca,"on"),box(gca,"on")
daspect(gca,[1,1,1])
axis([-3,3,-3,3])
for i = 1:n
    plot([x(i,1),x(i,end)],[y(i,1),y(i,end)],"Color","r","LineWidth",1.5)
end

for i = 1:m
    plot([x(1,i),x(1,i)],[y(1,i),y(end,i)],"Color","b","LineWidth",1.5)
end