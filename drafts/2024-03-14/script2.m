clc,clear,close all
rng("default")

y = rand(3,7);
y_hat = rand(3,7);

y = dlarray(y,"CB");
y_hat = dlarray(y_hat,"CB");

size(y,1)

disp( mse(y_hat,y) )
disp( sum( (y_hat-y).^2,"all" )/size(y,1)/2 )

