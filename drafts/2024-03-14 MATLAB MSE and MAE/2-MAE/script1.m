clc,clear,close all
rng("default")

y = rand(3,7);
y_hat = rand(3,7);

disp( mae(y_hat,y) )

error = y_hat-y;
value = 0;
for i = 1:width(y)
    value = value+norm(error(:,i),1);
end
disp( value/size(y,1)/size(y,2) )

disp( sum( abs(y_hat-y),"all" )/size(y,1)/size(y,2) )