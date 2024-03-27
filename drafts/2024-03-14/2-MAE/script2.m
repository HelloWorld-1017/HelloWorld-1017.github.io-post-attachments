clc,clear,close all
rng("default")

y = rand(3,7);
y_hat = rand(3,7);

y = dlarray(y,"CB");
y_hat = dlarray(y_hat,"CB");

mae(y_hat,y)

% disp( sum( abs(y_hat-y),"all" )/size(y,1)/size(y,2) )