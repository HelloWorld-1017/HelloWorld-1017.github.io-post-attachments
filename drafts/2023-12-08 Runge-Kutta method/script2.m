clc,clear,close all

helperCreateGIF()

function helperCreateGIF()
animFilename = "gif.gif";
fps = 6;

for frame = 1:20
    drawframe(frame)
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

function drawframe(f)
persistent colors t yt IVs
persistent fig ax yts
if f == 1
    IVs = 0:0.1:1.9;
    fig = figure("Position",[199.66,381.66,970.66,664.66],"Color","w");
    ax = axes(fig);
    axis(ax,[0,2,-0.2,2])
    ax.Toolbar.Visible = "off";
    hold(ax,"on"),grid(ax,"on"),box(ax,"on")
    colors = [
        0.325,0.525,0.545; 0.48,0.772,0.804; 0.556,0.898,0.932; 0.596,0.96,1; % CadetBlue
        0.27,0.545,0; 0.4,0.804,0; 0.464,0.932,0; 0.498,1,0; % Chartreuse
        0.43,0.484,0.545; 0.635,0.71,0.804; 0.736,0.824,0.932; 0.792,0.884,1; % LightSteelBlue
        0.545,0,0.545; 0.804,0,0.804; 0.932,0,0.932; 1,0,1; % Magenta
        0,0.545,0.545; 0,0.804,0.804; 0,0.932,0.932; 0,1,1; % Cyan
        ];

    t = 0:0.1:2;
    yt = @(t,y0) 1./(1+(1-y0)/y0*exp(-t));
    yts = nan(numel(IVs),numel(t));
    for i = 1:numel(IVs)
        yts(i,:) = yt(t,IVs(i));
        plot(t,yts(i,:),"Marker",".","HandleVisibility","off","Color",0.7*[1,1,1],"MarkerSize",10)
    end
end

qs = gobjects(numel(IVs),1);
for i = 1:numel(IVs)
    qs(i) = quiver(t(f),yts(i,f),t(f+1)-t(f),yts(i,f+1)-yts(i,f), ...
        "LineWidth",1,"AutoScaleFactor",0.9,"Color",colors(i,:),...
        "DisplayName",sprintf("y_0=%.2f",IVs(i)),"MaxHeadSize",1);
    if f ~= 1
        qs(i).HandleVisibility = "off";
    end
end
legend("Location","westoutside","Interpreter","tex","FontName","Times New Roman")
end