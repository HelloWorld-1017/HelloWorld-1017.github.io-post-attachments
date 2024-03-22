clc,clear,close all
rng("default")

a = randn(3,10);
fprintf("size(a): %d %d\n",size(a))

a1 = dlarray(a,"CB");
fprintf("size(a1): %d %d\n",size(a1))

a2 = dlarray(a,"BC");
fprintf("size(a2): %d %d\n",size(a2))