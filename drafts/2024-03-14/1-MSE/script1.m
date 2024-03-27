clc,clear,close all
rng("default")

y = rand(3,7);
y_hat = rand(3,7);

mse(y_hat,y)

disp( mse(y_hat,y) )
disp( sum( (y_hat-y)'*(y_hat-y).*diag(ones(width(y),1)),"all" )/size(y,1)/size(y,2) )
disp( sum( (y_hat-y).^2,"all" )/size(y,1)/size(y,2) )