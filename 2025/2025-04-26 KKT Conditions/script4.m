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

exportgraphics(fig, "fig4.jpg", "Resolution", 600)

function sc = helperPlot
x = -3:0.05:3;
y = -3:0.05:3;
[X, Y] = meshgrid(x, y);
fnc = @(x,y) x.*y;
f = fnc(X, Y);

level = min(f, [], "all")-3;

hold(gca, "on")
box(gca, "on")
grid(gca, "on")
sc = surfc(X, Y, f, "EdgeColor", "none");

sc(1).FaceAlpha = 0.3;
sc(2).LineWidth = 1.5;
sc(2).LevelList = min(f,[],"all"):0.5:max(f,[],"all");

fy = 2-y.^2;
yy = y;
idx = ~(fy>=min(x) & fy<=max(x));
fy(idx) = [];
yy(idx)=[];

plot3(fy, yy, level*ones(size(fy)), ...
    "LineWidth", 1.5, "Color", "r")
plot3(fy, yy, fnc(2-yy.^2, yy), ...
    "LineWidth", 1.5, "Color", "r", "LineStyle", "--")

plot3(x, zeros(size(x)), level*ones(size(x)), ...
    "LineWidth", 1.5, "Color", "k")
plot3(x, zeros(size(x)), fnc(x, zeros(size(x))), ...
    "LineWidth", 1.5, "Color", "k", "LineStyle", "--")

plot3(zeros(size(y)), y, level*ones(size(x)), ...
    "LineWidth", 1.5, "Color", "k")
plot3(zeros(size(y)), y, fnc(x, zeros(size(x))), ...
    "LineWidth", 1.5, "Color", "k", "LineStyle", "--")

x1 = 0;
y1 = 0;
fnc1 = fnc(x1, y1);
scatter3(x1, y1, fnc1, 20, "filled", ...
    "MarkerEdgeColor", "k", "MarkerFaceColor", "k")
scatter3(x1, y1, level, 20, "filled", ...
    "MarkerEdgeColor", "k", "MarkerFaceColor", "k")
plot3([x1, x1], [y1, y1], [level, fnc1], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
text(x1, y1, fnc1+0.5, "$(0, 0, 0)$", "Interpreter", "latex", "FontSize", 12)

x1 = 4/3;
y1 = sqrt(2/3);
fnc1 = fnc(x1, y1);
scatter3(x1, y1, fnc1, 20, "filled", ...
    "MarkerEdgeColor", "k", "MarkerFaceColor", "k")
scatter3(x1, y1, level, 20, "filled", ...
    "MarkerEdgeColor", "k", "MarkerFaceColor", "k")
plot3([x1, x1], [y1, y1], [level, fnc1], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
text(x1, y1, fnc1+0.5, "$(4/3, \sqrt{2/3}, 4\sqrt6/9)$", "Interpreter", "latex", "FontSize", 12)

xlabel("$x$", "Interpreter", "latex", "FontSize", 20)
ylabel("$y$", "Interpreter", "latex", "FontSize", 20)
zlabel("$f$", "Interpreter", "latex", "FontSize", 20)

xlim([min(x), max(x)])
ylim([min(y), max(y)])
end
