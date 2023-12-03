clc,clear,close all

contestAnimator()

function contestAnimator()
animFilename = "gif.gif";
fps = 8;

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
hold(ax,"on")
axis(ax,"off")
ax.Toolbar.Visible = "off";
daspect(ax,[1,1,1])
view(ax,[72.8877,4.2970])
axis(8*[-1,1,-1,1,-1,1])

% Calculate matrix
matrix = [0,1,0;0,0,1;1,0,0];
mtx4vis = eye(3)+(matrix-eye(3))*((f-1)/(48-1));
b = [2,1,3]';
bprime = ((f-1)/(48-1))*b;

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
beginningPoints = (mtx4vis*beginningPoints')'+repmat(bprime',height(beginningPoints),1);
endingPoints = (mtx4vis*endingPoints')'+repmat(bprime',height(endingPoints),1);
for i = 1:height(beginningPoints)
    plot3([beginningPoints(i,1),endingPoints(i,1)], ...
        [beginningPoints(i,2),endingPoints(i,2)], ...
        [beginningPoints(i,3),endingPoints(i,3)], ...
        "Color",[109,155,222]/255,"LineWidth",0.1);
end

% Plot basis vectors
vec1 = [2;0;0];
vec2 = [0;2;0];
vec3 = [0;0;2];
vec1_prime = mtx4vis*vec1+bprime;
vec2_prime = mtx4vis*vec2+bprime;
vec3_prime = mtx4vis*vec3+bprime;

qa = plot3([0,vec1_prime(1)],[0,vec1_prime(2)],[0,vec1_prime(3)],...
    "Color","r","linewidth",2,"DisplayName","a","Marker",".","MarkerSize",20);
qb = plot3([0,vec2_prime(1)],[0,vec2_prime(2)],[0,vec2_prime(3)],...
    "Color","g","linewidth",2,"DisplayName","b","Marker",".","MarkerSize",20);
qc = plot3([0,vec3_prime(1)],[0,vec3_prime(2)],[0,vec3_prime(3)],...
    "Color","b","linewidth",2,"DisplayName","c","Marker",".","MarkerSize",20);

qa1 = plot3([bprime(1),vec1_prime(1)],[bprime(2),vec1_prime(2)],[bprime(3),vec1_prime(3)],...
    "Color","r","linewidth",2,"LineStyle","-.","DisplayName","a'","Marker",".","MarkerSize",20);
qb1 = plot3([bprime(1),vec2_prime(1)],[bprime(2),vec2_prime(2)],[bprime(3),vec2_prime(3)],...
    "Color","g","linewidth",2,"LineStyle","-.","DisplayName","b'","Marker",".","MarkerSize",20);
qc1 = plot3([bprime(1),vec3_prime(1)],[bprime(2),vec3_prime(2)],[bprime(3),vec3_prime(3)],...
    "Color","b","linewidth",2,"LineStyle","-.","DisplayName","c'","Marker",".","MarkerSize",20);

% Scatter origin
scatter3(0,0,0,"filled","MarkerFaceColor","w")
scatter3(0,0,0,"filled","MarkerFaceColor","w")
scatter3(bprime(1),bprime(2),bprime(3),"filled","MarkerFaceColor","w")
s = sprintf("a_{%d} = [%.2f,%.2f,%.2f], a'_{%d} = [%.2f,%.2f,%.2f], a'_{%d}-A' vec1 = [%.2f,%.2f,%.2f]\n", ...
    f,vec1_prime,f,vec1_prime-bprime,f,vec1_prime-bprime-mtx4vis*vec1)+...
    sprintf("b_{%d} = [%.2f,%.2f,%.2f], b'_{%d} = [%.2f,%.2f,%.2f], b'_{%d}-A' vec2 = [%.2f,%.2f,%.2f]\n", ...
    f,vec2_prime,f,vec2_prime-bprime,f,vec2_prime-bprime-mtx4vis*vec2)+...
    sprintf("c_{%d} = [%.2f,%.2f,%.2f], c'_{%d} = [%.2f,%.2f,%.2f], c'_{%d}-A' vec3 = [%.2f,%.2f,%.2f]", ...
    f,vec3_prime,f,vec3_prime-bprime,f,vec3_prime-bprime-mtx4vis*vec3);
title(s,"Color","w")
legend([qa,qb,qc,qa1,qb1,qc1],"Location","north","Orientation","horizontal")
end