clc,clear,close all

figure("Color","w","Position",[364,391,1147,357])
tiledlayout(1,2)
nexttile
ax1 = gca();
hold(gca,"on")
set(gca,"DataAspectRatio",[1,1,1])
% xlim([-3,3])
% ylim([-3,3])
x = -3:0.1:3;
y = x;
plot(x,y,"LineStyle","--","Color",[0.7,0.7,0.7])

y1 = [1.5,0.5];
y2 = [0.5,1.5];

nexttile
hold(gca,"on")
a1 = animatedline("LineWidth",1.5,"Color","r","DisplayName","RMSE");
a2 = animatedline("LineWidth",1.5,"Color","b","DisplayName","MAE");
legend("Orientation","horizontal","Location","north")
% xlim([0,5])
% ylim([0,6])

ts = 0:0.1:10;
for i = 1:numel(ts)
    t = ts(i);
    y1_hat = [-2,-2]+t;
    y2_hat = [-3,-3.5]+t;

    scatter(ax1,y1(1),y1(2),"filled","MarkerFaceColor","k")
    scatter(ax1,y2(1),y2(2),"filled","MarkerFaceColor","b")

    s1 = scatter(ax1,y1_hat(1),y1_hat(2),"MarkerFaceColor","r","MarkerEdgeColor","none");
    s2 = scatter(ax1,y2_hat(1),y2_hat(2),"MarkerFaceColor","b","MarkerEdgeColor","none");

    p1 = plot(ax1,[y1(1),y1_hat(1)],[y1(2),y1_hat(2)],"LineWidth",1.5,"Color","k");
    p2 = plot(ax1,[y2(1),y2_hat(1)],[y2(2),y2_hat(2)],"LineWidth",1.5,"Color","k");

    RMSE = (1/2)*sqrt(sum(((y1-y1_hat).^2+(y2-y2_hat).^2),"all"));
    MAE = (1/2)*sum((abs(y1-y1_hat)+abs(y2-y2_hat)),"all");

    addpoints(a1,t,RMSE)
    addpoints(a2,t,MAE)
    drawnow
    pause(0.2)
    if i ~= numel(ts)
        delete(p1),delete(p2),delete(s1),delete(s2)
    end
    %     delete(p1,p2,s1,s2)
end
