clc,clear,close all

[x,y,z] = meshgrid(-4:4);

figure("Position",[708.33,503.67,865.33,720.67])
hold(gca,"on"),box(gca,"on")
view(3)
axis(5*[-1,1,-1,1,-1,1])
daspect(gca,[1,1,1])

beginningPoints = [];
enddingPoints = [];

% 1-2
for i = 1:size(x,1)
    for j = 1:size(x,2)
        beginningPoints = [beginningPoints;x(i,j,1),y(i,j,1),z(i,j,1)]; %#ok
        enddingPoints = [enddingPoints;x(i,j,end),y(i,j,end),z(i,j,end)]; %#ok
    end
end

% 1-3
for i = 1:size(x,1)
    for j = 1:size(x,3)
        beginningPoints = [beginningPoints;x(i,1,j),y(i,1,j),z(i,1,j)]; %#ok
        enddingPoints = [enddingPoints;x(i,end,j),y(i,end,j),z(i,end,j)]; %#ok
    end
end

% 2-3
for i = 1:size(x,2)
    for j = 1:size(x,3)
        beginningPoints = [beginningPoints;x(1,i,j),y(1,i,j),z(1,i,j)]; %#ok
        enddingPoints = [enddingPoints;x(end,i,j),y(end,i,j),z(end,i,j)]; %#ok
    end
end

for i = 1:height(beginningPoints)
    plot3([beginningPoints(i,1),enddingPoints(i,1)], ...
        [beginningPoints(i,2),enddingPoints(i,2)], ...
        [beginningPoints(i,3),enddingPoints(i,3)], ...
        "Color",[0.5,0.5,0.5],"LineWidth",0.1)
end