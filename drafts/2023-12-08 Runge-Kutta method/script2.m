clc,clear,close all

t = 0:0.1:2;

yt = @(t,y0) 1./(1+(1-y0)/y0*exp(-t));

colors = [0.325,0.525,0.545;
    0.48,0.772,0.804;
    0.556,0.898,0.932;
    0.596,0.96,1; % CadetBlue
    0.27,0.545,0;
    0.4,0.804,0;
    0.464,0.932,0;
    0.498,1,0; % Chartreuse
    0.43,0.484,0.545;
    0.635,0.71,0.804;
    0.736,0.824,0.932;
    0.792,0.884,1; % LightSteelBlue
    0.545,0,0.545;
    0.804,0,0.804;
    0.932,0,0.932;
    1,0,1; % Magenta
    0,0.545,0.545
    0,0.804,0.804;
    0,0.932,0.932;
    0,1,1; % Cyan 
    ];

figure("Position",[199.66,381.66,970.66,664.66])
hold(gca,"on"),grid(gca,"on"),box(gca,"on")
IVs = 0:0.1:1.9;
for i = 1:numel(IVs)
    yts = yt(t,IVs(i));
    quiver(t(1:end-1),yts(1:end-1),t(2:end)-t(1:end-1),yts(2:end)-yts(1:end-1), ...
        "LineWidth",1.2,"AutoScaleFactor",0.2,"Color",colors(i,:),...
        "DisplayName",sprintf("y_0=%.2f",IVs(i)))
    scatter(t,yts,20,"Marker",".","MarkerEdgeColor","k","HandleVisibility","off")
end
legend("Location","westoutside","Interpreter","tex","FontName","Times New Roman")
ylim([-0.2,2])