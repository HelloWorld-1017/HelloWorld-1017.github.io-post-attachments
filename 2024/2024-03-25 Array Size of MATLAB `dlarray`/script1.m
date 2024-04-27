clc,clear,close all
rng("default")

a = randn(3,10);
fprintf("size(a): %d %d\n",size(a))

a1 = dlarray(a); % Without specifying data format
fprintf("size(a1): %d %d, Dimension labels:%s\n",size(a1),dims(a1))

a2 = dlarray(a,"CB");
fprintf("size(a2): %d %d, Dimension labels:%s\n",size(a2),dims(a2))

a3 = dlarray(a,"BC");
fprintf("size(a3): %d %d, Dimension labels:%s\n",size(a3),dims(a3))