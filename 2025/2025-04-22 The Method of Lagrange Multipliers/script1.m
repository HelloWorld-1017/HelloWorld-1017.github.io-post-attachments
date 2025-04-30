clc, clear, close all

fig = figure("Color", "w", "Position", [303,521.66,1900,564.66]);
tiledlayout(1,3)

nexttile
view([32.89,11.58])
sc1 = helperPlot;

nexttile
view([90,0])
helperPlot;

nexttile
view([0,90])
sc2 = helperPlot;
sc2(1).FaceAlpha = 0;

exportgraphics(fig, "fig1.jpg", "Resolution", 600)

function sc = helperPlot
x = -1.5:0.05:1.5;
y = -1.5:0.05:1.5;
[X, Y] = meshgrid(x, y);
fnc = @(x,y) (x+y);

theta = 0:0.01:2*pi;
xx = cos(theta);
yy = sin(theta);
f = fnc(X, Y);
g = xx+yy;

hold(gca, "on")
box(gca, "on")
grid(gca, "on")
sc = surfc(X, Y, f, "EdgeColor", "none");
sc(1).FaceAlpha = 0.7;
sc(2).LineWidth = 1.5;
sc(2).LevelList = min(f,[],"all"):0.2:max(f,[],"all");
plot3(xx, yy, g, "LineWidth", 1.5, "Color", "k")
level = min(min(f))-3;
plot3(xx, yy, level*ones(size(xx)), "LineWidth", 1.5, "Color", "k")

x1 = -sqrt(2)/2;
y1 = -sqrt(2)/2;
fnc1 = fnc(x1, y1);

x2 = sqrt(2)/2;
y2 = sqrt(2)/2;
fnc2 = fnc(x2,y2);

scatter3([x1, x2], [y1, y2], [fnc1, fnc2], 20, "filled", ...
    "MarkerEdgeColor", "k", "MarkerFaceColor", "k")
scatter3([x1, x2], [y1, y2], [level, level], 20, "filled", "MarkerEdgeColor", "k", "MarkerFaceColor", "k")
plot3([x1, x1], [y1, y1], [level, fnc1], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
plot3([x2, x2], [y2, y2], [level, fnc2], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
text(x1, y1, fnc1+0.5, "$(-\sqrt{2}/2,-\sqrt{2}/2,-\sqrt{2})$", "Interpreter", "latex", "FontSize", 12)
text(x2, y2, fnc2+0.5, "$(\sqrt{2}/2,\sqrt{2}/2,\sqrt{2})$", "Interpreter", "latex", "FontSize", 12)

xlabel("$x$", "Interpreter", "latex", "FontSize", 20)
ylabel("$y$", "Interpreter", "latex", "FontSize", 20)
zlabel("$f$", "Interpreter", "latex", "FontSize", 20)
end