clc,clear,close all

elapsedTime = duration(0,0,3677*52,"Format","hh:mm:ss");

currentTime1 = datetime("now","format","dd/MM/yyyy hh:mm:ss");
ETA1 = currentTime1+elapsedTime;

currentTime2 = datetime("now","format","dd/MM/yyyy HH:mm:ss");
ETA2 = currentTime2+elapsedTime;

disp(elapsedTime)
disp(currentTime1)
disp(ETA1)

disp(currentTime2)
disp(ETA2)