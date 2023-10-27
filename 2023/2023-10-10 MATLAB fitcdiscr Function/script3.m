clc,clear,close all
rng(1)

load fisheriris.mat
meas = meas(:,1:3);
mdl = fitcdiscr(meas,species, ...
    'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions', ...
    struct('AcquisitionFunctionName','expected-improvement-plus'));

Sigmas = ...
[0.2650    0.0927    0.1675;
0.0927    0.1154    0.0552;
0.1675    0.0552    0.1852];

(1-mdl.Gamma)*Sigmas+mdl.Gamma*diag(Sigmas)
