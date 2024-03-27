clc,clear,close all
rng("default")

y = rand(3,7);
y_hat = rand(3,7);

y = dlarray(y,"CB");
y_hat = dlarray(y_hat,"CB");

mse(y_hat,y)

disp( mse(y_hat,y) )
disp( sum( stripdims((y_hat-y))'*stripdims((y_hat-y)).*diag(ones(width(y),1)),"all" )/size(y,2)/2 )
disp( sum( (y_hat-y).^2,"all" )/size(y,2)/2 )