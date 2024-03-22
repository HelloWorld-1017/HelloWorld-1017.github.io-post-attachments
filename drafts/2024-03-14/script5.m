clc,clear,close all
rng("default")

b = rand(3,3,10,7);
fprintf("size(b): %d %d %d %d\n",size(b))

b1 = dlarray(b,"SSCB");
fprintf("size(b1): %d %d %d %d\n",size(b1))

b2 = dlarray(b,"SSBC");
fprintf("size(b2): %d %d %d %d\n",size(b2))