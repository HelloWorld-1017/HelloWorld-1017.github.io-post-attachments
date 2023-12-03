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
axis(10*[-1,1,-1,1])

% Calculate matrix
rng("default")
matrix = [1.5,1;1,0];
mtx4vis = eye(2)+(matrix-eye(2))*((f-1)/(48-1));
b = [1,2]';
bprime = ((f-1)/(48-1))*b;

% Obtain the end points of grid lines
[x,y] = meshgrid(-4:1:4);
beginningPoints = [[x(:,1);x(1,:)'],[y(:,1);y(1,:)']];
endingPoints = [[x(:,end);x(end,:)'],[y(:,end);y(end,:)']];

% Plot fixed gray grid lines
for i = 1:height(beginningPoints)
    plot([beginningPoints(i,1),endingPoints(i,1)], ...
        [beginningPoints(i,2),endingPoints(i,2)], ...
        "Color",[0.3,0.3,0.3],"LineWidth",0.5);
end

% Plot blue animated grid lines
beginningPoints = (mtx4vis*beginningPoints')'+repmat(bprime',height(beginningPoints),1);
endingPoints = (mtx4vis*endingPoints')'+repmat(bprime',height(endingPoints),1);
for i = 1:height(beginningPoints)
    plot([beginningPoints(i,1),endingPoints(i,1)], ...
        [beginningPoints(i,2),endingPoints(i,2)], ...
        "Color",[109,155,222]/255,"LineWidth",0.1);
end

% Plot basis vectors
vec1 = [2;0];
vec2 = [0;2];
vec1_prime = mtx4vis*vec1+bprime;
vec2_prime = mtx4vis*vec2+bprime;

qa = plot([0,vec1_prime(1)],[0,vec1_prime(2)],...
    "Color","r","linewidth",2,"DisplayName","a","Marker",".","MarkerSize",20);
qb = plot([0,vec2_prime(1)],[0,vec2_prime(2)],...
    "Color","g","linewidth",2,"DisplayName","b","Marker",".","MarkerSize",20);

qa1 = plot([bprime(1),vec1_prime(1)],[bprime(2),vec1_prime(2)],...
    "Color","r","linewidth",2,"LineStyle","-.","DisplayName","a'","Marker",".","MarkerSize",20);
qb1 = plot([bprime(1),vec2_prime(1)],[bprime(2),vec2_prime(2)],...
    "Color","g","linewidth",2,"LineStyle","-.","DisplayName","b'","Marker",".","MarkerSize",20);

% Scatter origin
scatter(0,0,"filled","MarkerFaceColor","w")
scatter(bprime(1),bprime(2),"filled","MarkerFaceColor","w")
s = sprintf("a_{%d} = [%.2f,%.2f], a'_{%d} = [%.2f,%.2f], a'_{%d}-A' vec1 = [%.2f,%.2f]\n", ...
    f,vec1_prime,f,vec1_prime-bprime,f,vec1_prime-bprime-mtx4vis*vec1)+...
    sprintf("b_{%d} = [%.2f,%.2f], b'_{%d} = [%.2f,%.2f], a'_{%d}-A' vec2 = [%.2f,%.2f]\n", ...
    f,vec2_prime,f,vec2_prime-bprime,f,vec2_prime-bprime-mtx4vis*vec2);
title(s,"Color","w")
legend([qa,qb,qa1,qb1],"Location","north","Orientation","horizontal","Interpreter","tex")
end