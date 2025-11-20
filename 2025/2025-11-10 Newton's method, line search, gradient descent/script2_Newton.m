clc, clear, close all

syms x1 x2
f_sym = (1-x1).^2+100*(x2-x1.^2).^2;
% f_sym = x1.^2+3*x1.*x2+9*x2.^2+2*x1-5*x2;

g_sym = gradient(f_sym, [x1, x2]);
H_sym = hessian(f_sym, [x1, x2]);

f = matlabFunction(f_sym, 'Vars', {x1, x2});
g = matlabFunction(g_sym, 'Vars', {x1, x2});
H = matlabFunction(H_sym, 'Vars', {x1, x2});

x0 = [-1.2, 1]';
% x0 = [0, 0]';
helperNewton(f, g, H, x0)

function helperNewton(f, g, H, x0)
xOld = x0;
numIter = 100;

xk = nan(numIter, 2);
iters = (1:numIter)';

for i = 1:numIter
    %  ============ Newton's method ============
    gi = g(xOld(1), xOld(2));
    Hi = H(xOld(1), xOld(2));
    
    xNew = xOld-Hi\gi;
    % =====================================

    xk(i,:) = xNew;
    xOld = xNew;

    % % Stop if diverge
    % if f(xNew(1), xNew(2))>100
    %     break
    % end
    % 
    % % Early stop if converge
    % if i>1 && norm(f(xk(i,1), xk(i,2)) - f(xk(i-1,1), xk(i-1,2)))<=1e-4
    %     xk(i+1:end, :) = [];
    %     iters(i+1:end) = [];
    %     break
    % end
end

xk(isnan(xk)) = [];

xs1 = [x0(1); xk(:,1)];
xs2 = [x0(2); xk(:,2)];
iters = [0; iters(1:(height(xs1)-1))];
fs = f(xs1, xs2);

fprintf('Final function value: %.4f\n', f(xNew(1), xNew(2)))

% Present results
helperPlot(f, xs1, xs2, iters, fs)
end

function helperPlot(f, xs1, xs2, iters, fs)
figure('Color', 'w', 'Position', [305,283,1915,835])
tiledlayout(2, 3, 'TileSpacing', 'compact')
LineWidth = 1.5;
FontSize = 13;
FontName = 'Times New Roman';

%% Axes 1
nexttile
hold(gca, 'on'), grid(gca, 'on'), box(gca, 'on')
scatter(iters(1), xs1(1), 100, 'Marker', 'hexagram', ...
    'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'none', 'DisplayName', 'Initial point')
plot(iters, xs1, 'LineWidth', LineWidth, 'Color', 'b', 'DisplayName', 'Iteration curve')
scatter(iters(end), xs1(end), 100, 'Marker', 'o', ...
    'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'none', 'DisplayName', 'Final point')
xlabel('Iteration')
ylabel('$x_1$', 'Interpreter', 'latex')
legend('Box', 'off')
title(sprintf('Final value of %s: %.4f', '$x_1$', xs1(end)), 'Interpreter', 'latex')
set(gca, 'FontSize', FontSize, 'FontName', FontName)

%% Axes 2
nexttile
hold(gca, 'on'), grid(gca, 'on'), box(gca, 'on')
scatter(iters(1), xs2(1), 100, 'Marker', 'hexagram', ...
    'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'none', 'DisplayName', 'Initial point')
plot(iters, xs2, 'LineWidth', LineWidth, 'Color', 'b', 'DisplayName', 'Iteration curve')
scatter(iters(end), xs2(end), 100, 'Marker', 'o', ...
    'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'none', 'DisplayName', 'Final point')
xlabel('Iteration')
ylabel('$x_2$', 'Interpreter', 'latex')
legend('Box', 'off')
title(sprintf('Final value of %s: %.4f', '$x_2$', xs2(end)), 'Interpreter', 'latex')
set(gca, 'FontSize', FontSize, 'FontName', FontName)

%% Axes 3
nexttile
hold(gca, 'on'), grid(gca, 'on'), box(gca, 'on')
scatter(iters(1), fs(1), 100, 'Marker', 'hexagram', ...
    'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'none', 'DisplayName', 'Initial point')
plot(iters, fs, 'LineWidth', LineWidth, 'Color', 'b', 'DisplayName', 'Iteration curve')
scatter(iters(end), fs(end), 100, 'Marker', 'o', ...
    'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'none', 'DisplayName', 'Final point')
xlabel('Iteration')
ylabel('$f(x_1,x_2)$', 'Interpreter', 'latex')
legend('Box', 'off')
title(sprintf('Final value of %s: %.4f', '$f(x_1,x_2)$', fs(end)), 'Interpreter', 'latex')
set(gca, 'FontSize', FontSize, 'FontName', FontName)

%% Axes 4
nexttile
view(3)
hold(gca, 'on')
ax1 = gca();

x_min = -2;
x_max = 2;
x1 = linspace(x_min, x_max, 100);
x2 = linspace(x_min, x_max, 100);

[X1, X2] = meshgrid(x1, x2);
y = f(X1, X2);
sc = surfc(X1, X2, y, 'FaceAlpha', 0.3, 'EdgeColor', 'none', 'DisplayName', '$f(x_1,x_2)$', 'HandleVisibility', 'off');
sc(2).HandleVisibility = 'off';
sc(2).LevelList = min(y,[],"all"):10:max(y,[],"all");
LevelStep = sc(2).LevelStep;

scatter3(xs1(1), xs2(1), fs(1), 100, 'Marker', 'hexagram', ...
    'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'none', 'DisplayName', '$f(x_1^{(0)}, x_2^{(0)})$')
scatter3(xs1(1), xs2(1), -LevelStep, 100, 'Marker', 'hexagram', ...
    'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'none', 'DisplayName', '$(x_1^{(0)}, x_2^{(0)})$')
scatter3(xs1(end), xs2(end), fs(end), 100, 'Marker', 'o', ...
    'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'none', 'DisplayName', '$f(x_1^{(end)}, x_2^{(end)})$')
scatter3(xs1(end), xs2(end), -LevelStep, 100, 'Marker', 'o', ...
    'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'none', 'DisplayName', '$(x_1^{(end)}, x_2^{(end)})$')

plot3(xs1, xs2, fs, 'LineWidth', LineWidth, 'Color', 'b', 'DisplayName', 'Trace of $f(x_1,x_2)$')
plot3(xs1, xs2, -LevelStep*ones(size(xs1)), 'LineWidth', LineWidth, 'Color', 'r', 'DisplayName', 'Trace of $(x_1,x_2)$')
% helperFill3(xs1, xs2, fs, xs1, xs2, -LevelStep*ones(size(xs1)), 'g')

xlim([x_min, x_max])
ylim([x_min, x_max])
xlabel('$x_1$', 'Interpreter', 'latex')
ylabel('$x_2$', 'Interpreter', 'latex')
zlabel('$f(x_1,x_2)$', 'Interpreter', 'latex')
lgd1 = legend('Interpreter', 'latex', 'Box', 'off', 'NumColumns', 2, 'Location', 'north', 'EdgeColor', 'none');
set(gca, 'FontSize', FontSize, 'FontName', FontName)

%% Axes 5
nexttile
ax2 = gca();
copyobj(allchild(ax1), ax2);
view([90,0])
xlim([x_min, x_max])
ylim([x_min, x_max])
xlabel('$x_1$', 'Interpreter', 'latex')
ylabel('$x_2$', 'Interpreter', 'latex')
zlabel('$f(x_1,x_2)$', 'Interpreter', 'latex')
% legend(ax2, lgd1.String, 'Interpreter', lgd1.Interpreter, ...
%     'Box', lgd1.Box, 'NumColumns', lgd1.NumColumns, ...
%     'Location', lgd1.Location, 'EdgeColor', lgd1.EdgeColor);
set(ax2, 'FontSize', FontSize, 'FontName', FontName)

%% Axes 6
nexttile
ax3 = gca();
copyobj(allchild(ax1), ax3);
view([0,90])
xlim([x_min, x_max])
ylim([x_min, x_max])
xlabel('$x_1$', 'Interpreter', 'latex')
ylabel('$x_2$', 'Interpreter', 'latex')
zlabel('$f(x_1,x_2)$', 'Interpreter', 'latex')
% legend(ax3, lgd1.String, 'Interpreter', lgd1.Interpreter, ...
%     'Box', lgd1.Box, 'NumColumns', lgd1.NumColumns, ...
%     'Location', lgd1.Location, 'EdgeColor', lgd1.EdgeColor);
set(gca, 'FontSize', FontSize, 'FontName', FontName)
end