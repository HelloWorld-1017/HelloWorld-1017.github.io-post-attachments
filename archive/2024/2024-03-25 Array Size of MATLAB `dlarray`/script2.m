clc,clear,close all
rng("default")

b = rand(3,3,10,7);
fprintf("size(b): %d %d %d %d\n",size(b))

b1 = dlarray(b); % Without specifying data format
fprintf("size(b1): %d %d %d %d, Dimension labels:%s\n",size(b1),dims(b1))

b2 = dlarray(b,"SSCB");
fprintf("size(b2): %d %d %d %d, Dimension labels:%s\n",size(b2),dims(b2))

b3 = dlarray(b,"SSBC");
fprintf("size(b3): %d %d %d %d, Dimension labels:%s\n",size(b3),dims(b3))
