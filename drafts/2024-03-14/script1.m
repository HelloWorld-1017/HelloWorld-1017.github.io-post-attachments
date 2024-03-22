clc,clear,close all
rng("default")

y = rand(3,7);
y_hat = rand(3,7);

disp( mse(y_hat,y) )
disp( sum( (y_hat-y).^2,"all" )/numel(y) )