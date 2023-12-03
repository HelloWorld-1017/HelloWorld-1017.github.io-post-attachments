clc,clear,close all

contestAnimator()

function contestAnimator()
animFilename = "gif.gif";
fps = 24;

for frame = 1:48
    drawframe(frame)
    fig = gcf();
    im = getframe(fig);
    [A,map] = rgb2ind(im.cdata,256);
    if frame == 1
        imwrite(A,map,animFilename,"LoopCount",Inf,"DelayTime",1/fps);
    elseif frame ~= 48
        imwrite(A,map,animFilename,"WriteMode","append","DelayTime",1/fps);
    else
        for i = 1:24
            imwrite(A,map,animFilename,"WriteMode","append","DelayTime",1/fps);
        end
    end
end
end

function drawframe(f)
cla
set(gcf,"Color","k","Position",[693.67,281.67,1146,956.67])
ax = gca();
hold(ax,"on"),axis(ax,"off")
ax.Toolbar.Visible = "off";
daspect(ax,[1,1,1])
view(ax,3)
axis([-4,4,-4,4,-4,4])

% Calculate matrix
matrix = [0,1,0;0,0,1;1,0,0];
mtx4vis = eye(3)+(matrix-eye(3))*((f-1)/(48-1));

% Obtain the end points of grid lines
[x,y,z] = meshgrid(-4:2:4);
beginningPoints = [];
endingPoints = [];
% 1-3
for i = 1:size(x,1)
    for j = 1:size(x,3)
        beginningPoints = [beginningPoints;x(1,i,j),y(1,i,j),z(1,i,j)]; %#ok
        endingPoints = [endingPoints;x(end,i,j),y(end,i,j),z(end,i,j)]; %#ok
    end
end
% 1-2
for i = 1:size(x,1)
    for j = 1:size(x,2)
        beginningPoints = [beginningPoints;x(i,j,1),y(i,j,1),z(i,j,1)]; %#ok
        endingPoints = [endingPoints;x(i,j,end),y(i,j,end),z(i,j,end)]; %#ok
    end
end
% 2-3
for i = 1:size(x,2)
    for j = 1:size(x,3)
        beginningPoints = [beginningPoints;x(i,1,j),y(i,1,j),z(i,1,j)]; %#ok
        endingPoints = [endingPoints;x(i,end,j),y(i,end,j),z(i,end,j)]; %#ok
    end
end

% Plot fixed gray grid lines
for i = 1:height(beginningPoints)
    plot3([beginningPoints(i,1),endingPoints(i,1)], ...
        [beginningPoints(i,2),endingPoints(i,2)], ...
        [beginningPoints(i,3),endingPoints(i,3)], ...
        "Color",[0.3,0.3,0.3],"LineWidth",0.5);
end

% Plot blue animated grid lines
beginningPoints = (mtx4vis*beginningPoints')';
endingPoints = (mtx4vis*endingPoints')';
for i = 1:height(beginningPoints)
    plot3([beginningPoints(i,1),endingPoints(i,1)], ...
        [beginningPoints(i,2),endingPoints(i,2)], ...
        [beginningPoints(i,3),endingPoints(i,3)], ...
        "Color",[109,155,222]/255,"LineWidth",0.1);
end

% Plot basis vectors
basis = mtx4vis*[4,0,0;0,4,0;0,0,4];
quiver3(0,0,0,basis(1,1),basis(2,1),basis(3,1), ...
    "filled","Color","r","linewidth",2,"MaxHeadSize",0.5)
quiver3(0,0,0,basis(1,2),basis(2,2),basis(3,2), ...
    "filled","Color","g","linewidth",2,"MaxHeadSize",0.5)
quiver3(0,0,0,basis(1,3),basis(2,3),basis(3,3), ...
    "filled","Color","b","linewidth",2,"MaxHeadSize",0.5)
end