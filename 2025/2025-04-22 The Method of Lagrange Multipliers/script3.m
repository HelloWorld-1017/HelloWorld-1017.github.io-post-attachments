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

exportgraphics(fig, "fig3.jpg", "Resolution", 600)

function sc = helperPlot
x = -3:0.05:3;
y = -3:0.05:3;
[X, Y] = meshgrid(x, y);
fnc = @(x,y) x.*y.^2;
f = fnc(X,Y);
theta = 0:0.01:2*pi;
xx = sqrt(3)*cos(theta);
yy = sqrt(3)*sin(theta);
g = fnc(xx,yy);

hold(gca, "on")
box(gca, "on")
grid(gca, "on")
colormap("jet")
sc = surfc(X, Y, f, "EdgeColor", "none");
sc(1).FaceAlpha = 0.7;
sc(2).LevelList = min(f,[],"all"):0.4:max(f,[],"all");
sc(2).LineWidth = 1.5;
plot3(xx, yy, g, "LineWidth", 1.5, "Color", "k")
level = min(min(f))-3;
plot3(xx, yy, level*ones(size(xx)), "LineWidth", 1.5, "Color", "k")

x1 = sqrt(3);
y1 = 0;
fnc1 = fnc(x1,y1);

x2 = -sqrt(3);
y2 = 0;
fnc2 = fnc(x2,y2);

x3 = 1;
y3 = sqrt(2);
fnc3 = fnc(x3,y3);

x4 = 1;
y4 = -sqrt(2);
fnc4 = fnc(x4,y4);

x5 = -1;
y5 = sqrt(2);
fnc5 = fnc(x5,y5);

x6 = -1;
y6 = -sqrt(2);
fnc6 = fnc(x6,y6);

scatter3([x1, x2, x3, x4, x5, x6], [y1, y2, y3, y4, y5, y6], [fnc1, fnc2, fnc3, fnc4, fnc5, fnc6], 20, "filled", ...
    "MarkerEdgeColor", "k", "MarkerFaceColor", "k")
scatter3([x1, x2, x3, x4, x5, x6], [y1, y2, y3, y4, y5, y6], [level, level, level, level, level, level], 20, "filled", ...
    "MarkerEdgeColor", "k", "MarkerFaceColor", "k")
plot3([x1, x1], [y1, y1], [level, fnc1], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
plot3([x2, x2], [y2, y2], [level, fnc2], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
plot3([x3, x3], [y3, y3], [level, fnc3], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
plot3([x4, x4], [y4, y4], [level, fnc4], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
plot3([x5, x5], [y5, y5], [level, fnc5], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
plot3([x6, x6], [y6, y6], [level, fnc6], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
text(x1, y1, fnc1+0.5, "$(\sqrt{3},0,0)$", "Interpreter", "latex", "FontSize", 12)
text(x2, y2, fnc2+0.5, "$(-\sqrt{3},0,0)$", "Interpreter", "latex", "FontSize", 12)
text(x3, y3, fnc3+0.5, "$(1,\sqrt2,2)$", "Interpreter", "latex", "FontSize", 12)
text(x4, y4, fnc4+0.5, "$(1,-\sqrt2,2)$", "Interpreter", "latex", "FontSize", 12)
text(x5, y5, fnc5+0.5, "$(-1,\sqrt2,-2)$", "Interpreter", "latex", "FontSize", 12)
text(x6, y6, fnc6+0.5, "$(-1,-\sqrt2,-2)$", "Interpreter", "latex", "FontSize", 12)

xlabel("$x$", "Interpreter", "latex", "FontSize", 20)
ylabel("$y$", "Interpreter", "latex", "FontSize", 20)
zlabel("$f$", "Interpreter", "latex", "FontSize", 20)
end