clc,clear,close all
rng("default")

load fisheriris
X = meas(:,3:4);
Y = species;
classes = unique(Y);
clear meas species

cv = cvpartition(Y,"HoldOut",0.3);
XTrain = X(cv.training,:);
YTrain = Y(cv.training);
XTest = X(cv.test,:);
YTest = Y(cv.test);

t = templateSVM("Standardize",true,"KernelFunction","gaussian");
mdl = fitcecoc(X,Y,"Learners",t,"FitPosterior",true,...
    "ClassNames",{'setosa','versicolor','virginica'},...
    "Verbose",2);

predictions4Test = predict(mdl,XTest);

interval = 0.02;
[x1Grid,x2Grid] = meshgrid(min(X(:,1)):interval:max(X(:,1)),...
    min(X(:,2)):interval:max(X(:,2)));
[predictions4Grid,~,~,PosteriorRegion] = predict(mdl,[x1Grid(:),x2Grid(:)]);

figure("color","w")
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
sz = 10;

gscatter(x1Grid(:),x2Grid(:),predictions4Grid);

gscatter(XTrain(:,1),XTrain(:,2), ...
    YTrain+repmat(" (train)",height(YTrain),1), ...
    [1,0,0;0,1,0;0,0,1]);

gs_test = gscatter(XTest(:,1),XTest(:,2), ...
    YTest+repmat(" (test)",height(YTest),1), ...
    [1,0,0;0,1,0;0,0,1]);

gs_prediction = gscatter(XTest(:,1),XTest(:,2), ...
    predictions4Test+repmat(" (predictions for test)",height(predictions4Test),1), ...
    [1,0,0;0,1,0;0,0,1]);
gs_prediction(1).Marker = "pentagram";
gs_prediction(2).Marker = "pentagram";
gs_prediction(3).Marker = "pentagram";

xlim([min(X(:,1)),max(X(:,1))])
ylim([min(X(:,2)),max(X(:,2))])
xlabel("Petal Length (cm)")
ylabel("Petal Width (cm)")
legend("Location","eastoutside")


% nexttile
% hold(gca,"on"),box(gca,"on"),grid(gca,"on")
% gscatter(XTrain(:,1),XTrain(:,2),YTrain,[1,0,0;0,1,0;0,0,1])
% uistack(gs1)
% uistack(gs1)
% uistack(gs1)
% contourf(x1Grid,x2Grid,...
%     reshape(max(PosteriorRegion,[],2),size(x1Grid,1),size(x2Grid,2)));