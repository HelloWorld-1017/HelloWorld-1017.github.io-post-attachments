clc,clear,close all

helperCreateGIF()

function helperCreateGIF()
animFilename = "gif.gif";
fps = 6;

t = 0:0.1:1;

for frame = 1:numel(t)
    drawframe(frame,t)
    fig = gcf();
    im = getframe(fig);
    [A,map] = rgb2ind(im.cdata,256);
    if frame == 1
        imwrite(A,map,animFilename,"LoopCount",Inf,"DelayTime",1/fps);
    else
        imwrite(A,map,animFilename,"WriteMode","append","DelayTime", 1/fps);
    end
end
end

function drawframe(frame,t)
persistent fig ax
persistent y1 y2

if frame == 1
    y1 = 3*exp(t.^2/2)-t.^2-2;
    IV = 1;
    [~,y2,h] = helperEuler([0,1],IV,numel(t)-1);

    fig = figure("Position",[1000,918,560,420],"Color","w");
    ax = axes(fig);
    axis(ax,[0,1,0.8,2.2])
    ax.Toolbar.Visible = "off";
    hold(ax,"on"),grid(ax,"on"),box(ax,"on")
    plot(t,y1,"LineWidth",1,"Color","b","Marker",".","MarkerSize",10,"DisplayName","Solution curve")
    plot(t,y2,"LineWidth",1,"Color",0.7*[1,1,1],"Marker",".","MarkerSize",10,"DisplayName","Numerical Solution curve")

    title(sprintf("Initial value: IV = %2.f, Step size: h = %.2f",IV,h), ...
        "FontName","Times New Roman")
    xlabel(ax,"$t$","Interpreter","latex")
    ylabel(ax,"$y$","Interpreter","latex")
    legend();
    
end
if frame ~= numel(t)
    quiver(t(frame),y2(frame),t(frame+1)-t(frame),y2(frame+1)-y2(frame), ...
        "LineWidth",1,"AutoScaleFactor",1,"Color","r","MaxHeadSize",1,"HandleVisibility","off");
end

end

function [t,y,h] = helperEuler(interval,y0,n)
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
