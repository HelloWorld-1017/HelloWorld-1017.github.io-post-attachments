clc,clear,close all

y1 = [1.5,0.5];
y2 = [0.5,1.5];

ts = 0:0.1:20;

y1_hat = repmat([-2,1],numel(ts),1)+repmat(ts',1,2); % along y = x+3;
y2_hat = repmat([-3,3],numel(ts),1)+repmat(ts',1,2); % along y = x+6;

RMSE1 = sqrt((1/2)*sum((y1-y1_hat).^2+(y2-y1_hat).^2,2));
MAE1 = (1/2)*sum(abs(y1-y1_hat)+abs(y2-y1_hat),2);

RMSE2 = sqrt((1/2)*sum((y1-y2_hat).^2+(y2-y2_hat).^2,2));
MAE2 = (1/2)*sum(abs(y1-y2_hat)+abs(y2-y2_hat),2);

figure("Color","w","Position",[241,273,1283,409])
tiledlayout(1,2)
nexttile
hold(gca,"on")
scatter(y1(1),y1(2),"filled","MarkerFaceColor","k")
scatter(y2(1),y2(2),"filled","MarkerFaceColor","k")

% scatter(y1_hat(1,1),y1_hat(1,2),"filled","MarkerFaceColor","r")
plot(y1_hat(:,1),y1_hat(:,2),"Color","r")

% scatter(y2_hat(1,1),y2_hat(1,2),"filled","MarkerFaceColor","b")
plot(y2_hat(:,1),y2_hat(:,2),"Color","b")

nexttile
hold(gca,"on")
plot(ts,RMSE1,"DisplayName","RMSE1","Color","r","LineStyle","-")
plot(ts,RMSE2,"DisplayName","RMSE2","Color","b","LineStyle","-")
plot(ts,MAE1,"DisplayName","MAE1","Color","r","LineStyle","-.")
plot(ts,MAE2,"DisplayName","MAE2","Color","b","LineStyle","-.")
legend("Location","northwest")