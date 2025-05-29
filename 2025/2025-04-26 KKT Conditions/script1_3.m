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

exportgraphics(fig, "fig1.jpg", "Resolution", 600)

function sc = helperPlot
x = -3:0.05:3;
y = -3:0.05:3;
[X, Y] = meshgrid(x, y);
fnc = @(x,y) (x.^2+y.^2);
f = fnc(X, Y);

alpha = 1;

level = min(min(f))-3;

hold(gca, "on")
box(gca, "on")
grid(gca, "on")
sc = surfc(X, Y, f, "EdgeColor", "none");

sc(1).FaceAlpha = 0.3;
sc(2).LineWidth = 1.5;
sc(2).LevelList = min(f,[],"all"):0.5:max(f,[],"all");

plot3(x, alpha*ones(size(x)), level*ones(size(x)), ...
    "LineWidth", 1.5, "Color", "k")
plot3(x, alpha*ones(size(x)), fnc(x, alpha*ones(size(x))), ...
    "LineWidth", 1.5, "Color", "k", "LineStyle", "--");
plot3(x, 1-x, level*ones(size(x)), "LineWidth", 1.5, "Color", "r")
plot3(x, 1-x, fnc(x, 1-x), "LineWidth", 1.5, "LineStyle", "--", "Color", "r")

x1 = 1/2;
y1 = 1/2;
fnc1 = fnc(x1, y1);
scatter3(x1, y1, fnc1, 20, "filled", ...
    "MarkerEdgeColor", "k", "MarkerFaceColor", "k")
scatter3(x1, y1, level, 20, "filled", ...
    "MarkerEdgeColor", "k", "MarkerFaceColor", "k")
plot3([x1, x1], [y1, y1], [level, fnc1], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
text(x1, y1, fnc1+0.5, "$(1/2, 1/2, 1/2)$", "Interpreter", "latex", "FontSize", 12)

xlabel("$x$", "Interpreter", "latex", "FontSize", 20)
ylabel("$y$", "Interpreter", "latex", "FontSize", 20)
zlabel("$f$", "Interpreter", "latex", "FontSize", 20)

xlim([min(x), max(x)])
ylim([min(y), max(y)])
end
