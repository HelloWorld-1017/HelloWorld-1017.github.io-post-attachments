clc,clear,close all

f = waitbar(0,'Please wait...');

epochs = 2e3;
for i = 1:epochs
    info = sprintf("(%s/%s) %.2f%%",num2str(i),num2str(epochs),i/epochs*100);
    waitbar(i/epochs,f, info)
    pause(0.1)
end
