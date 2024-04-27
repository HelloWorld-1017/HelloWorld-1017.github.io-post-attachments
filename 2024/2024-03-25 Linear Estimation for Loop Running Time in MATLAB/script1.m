clc,clear,close all

numEpochs = 100;

start = tic;
for epoch = 1:numEpochs
    A = rand(12000,4400);
    B = rand(12000,4400);

    if ~mod(epoch,10)
        elapsedTime = duration(0,0,toc(start),"Format","hh:mm:ss");
        estimatedRemainingTime = (numEpochs/epoch-1)*elapsedTime; % Linear estimation
        currentTime = datetime("now","format","dd/MM/yyyy HH:mm:ss"); % Attention here: "dd/MM/yyyy HH:mm:ss", not "dd/MM/yyyy hh:mm:ss"
        ETA = currentTime+estimatedRemainingTime;

        fprintf("%s/%s (%.2f%%), Elapsed time: %s, Estimated remaining time: %s, Current time: %s, ETA: %s\n", ...
            num2str(epoch),num2str(numEpochs),epoch/numEpochs*100, ...
            elapsedTime,estimatedRemainingTime, ...
            currentTime,ETA);
    end
end