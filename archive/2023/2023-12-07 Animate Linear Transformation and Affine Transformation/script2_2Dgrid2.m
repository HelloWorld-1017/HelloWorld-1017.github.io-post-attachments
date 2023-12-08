clc,clear,close all

[x,y] = meshgrid(-4:1:4);
beginningPoints = [[x(:,1);x(1,:)'],[y(:,1);y(1,:)']];
endingPoints = [[x(:,end);x(end,:)'],[y(:,end);y(end,:)']];

box(gca,"on")
daspect(gca,[1,1,1])
axis(5*[-1,1,-1,1])

for i = 1:height(beginningPoints)
    line([beginningPoints(i,1),endingPoints(i,1)], ...
        [beginningPoints(i,2),endingPoints(i,2)],"Color","k")
end