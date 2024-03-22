clc,clear,close all
rng("default")

a = rand(3,7);
b = rand(3,7);

mse(a,b)

disp( sum((a-b).^2,"all")/numel(a) )

disp("=======")

a = dlarray(a,"CB");
b = dlarray(b,"CB");

mse(a,b)
sum((a-b).^2,"all")/size(a,2)/2 

mae(a,b)