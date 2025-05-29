clc, clear, close all

fig = figure("Color", "w", "Position", [303,521.66,1900,564.66]);
tiledlayout(1,3)

nexttile
view([32.89,11.58])
helperPlot;

nexttile
view([90,0])
helperPlot;

nexttile
view([0,90])
sc = helperPlot;
sc(1).FaceAlpha = 0;

exportgraphics(fig, "fig3.jpg", "Resolution", 600)

function sc = helperPlot
x = -5:0.05:5;
y = -5:0.05:5;
[X, Y] = meshgrid(x, y);
fnc = @(x,y) (x.^2+y.^2);
f = fnc(X, Y);

level = min(min(f))-20;

theta = 0:0.01:2*pi;
xx = sqrt(5)*cos(theta);
yy = sqrt(5)*sin(theta);

hold(gca, "on")
box(gca, "on")
grid(gca, "on")
sc = surfc(X, Y, f, "EdgeColor", "none");

sc(1).FaceAlpha = 0.3;
sc(2).LineWidth = 1.5;
sc(2).LevelList = min(f,[],"all"):1:max(f,[],"all");

plot3(xx, yy, level*ones(size(xx)), ...
    "LineWidth", 1.5, "Color", "r")
plot3(xx, yy, fnc(xx, yy), ...
    "LineWidth", 1.5, "Color", "r", "LineStyle", "--")

plot3(x, (4-x)./2, level*ones(size(x)), ...
    "LineWidth", 1.5, "Color", "r")
plot3(x, (4-x)./2, fnc(x, (4-x)./2), ...
    "LineWidth", 1.5, "Color", "r", "LineStyle", "--")

plot3(x, zeros(size(x)), level*ones(size(x)), ...
    "LineWidth", 1.5, "Color", "k")
plot3(x, zeros(size(x)), fnc(x, zeros(size(x))), ...
    "LineWidth", 1.5, "Color", "k", "LineStyle", "--")

plot3(zeros(size(y)), y, level*ones(size(x)), ...
    "LineWidth", 1.5, "Color", "k")
plot3(zeros(size(y)), y, fnc(x, zeros(size(x))), ...
    "LineWidth", 1.5, "Color", "k", "LineStyle", "--")

xlabel("$x$", "Interpreter", "latex", "FontSize", 20)
ylabel("$y$", "Interpreter", "latex", "FontSize", 20)
zlabel("$f$", "Interpreter", "latex", "FontSize", 20)

x1 = 4/5;
y1 = 8/5;
fnc1 = fnc(x1, y1);
scatter3(x1, y1, fnc1, 20, "filled", ...
    "MarkerEdgeColor", "k", "MarkerFaceColor", "k")
scatter3(x1, y1, level, 20, "filled", ...
    "MarkerEdgeColor", "k", "MarkerFaceColor", "k")
plot3([x1, x1], [y1, y1], [level, fnc1], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
text(x1, y1, fnc1+0.5, "$(4/5, 8/5, 16/5)$", "Interpreter", "latex", "FontSize", 12)

xlim([min(x), max(x)])
ylim([min(y), max(y)])
zlim([level, max(f,[],"all")])
end