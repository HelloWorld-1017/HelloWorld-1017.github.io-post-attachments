clc,clear,close all

p = 0.01:0.01:1;
crossEntropy = -log(p);
focalLoss = @(p,gamma) -(1-p).^gamma.*log(p);

figure("Color","w")
hold(gca,"on")
LineWidth = 1.5;
plot(p,crossEntropy,"LineWidth",LineWidth,"DisplayName","BCE")
plot(p,focalLoss(p,0.5),"LineWidth",LineWidth,"DisplayName","$\gamma$ = "+num2str(0.5))
plot(p,focalLoss(p,1),"LineWidth",LineWidth,"DisplayName","$\gamma$ = "+num2str(1))
plot(p,focalLoss(p,2),"LineWidth",LineWidth,"DisplayName","$\gamma$ = "+num2str(2))
plot(p,focalLoss(p,5),"LineWidth",LineWidth,"DisplayName","$\gamma$ = "+num2str(5))
xlabel("Probability of ground truth class")
ylabel("Loss")
legend("Interpreter","latex")