clc, clear, close all

x = -1:0.05:3;
fnc = @(x) -x.^3+3*x.^2-2*x;
y = fnc(x);

fig = figure("Color", "w");
hold(gca, "on")
box(gca, "on")
grid(gca, "on")
plot(x, y, "LineWidth", 1.5, "Color", "b")
yline(0, "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
xline(0, "LineWidth", 1.5, "LineStyle", "--", "Color", "r")

x1 = (3+sqrt(3))/3;
y1 = fnc(x1);
scatter3(x1, y1, 20, "filled", ...
    "MarkerEdgeColor", "k", "MarkerFaceColor", "k")
text(x1, y1+0.5, "$(1.5774, 0.3849)$", "Interpreter", "latex", "FontSize", 12)

x2 = (3-sqrt(3))/3;
y2 = fnc(x2);
scatter3(x2, y2, 20, "filled", ...
    "MarkerEdgeColor", "k", "MarkerFaceColor", "k")
text(x2, y2-0.5, "$(0.4226, -0.3849)$", "Interpreter", "latex", "FontSize", 12)

exportgraphics(fig, "fig5.jpg", "Resolution", 600)