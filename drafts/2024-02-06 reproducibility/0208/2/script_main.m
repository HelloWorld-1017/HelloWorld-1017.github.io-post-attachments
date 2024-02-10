clc,clear,close all

LABELS1 = helperLoop(1,"default");
LABELS2 = helperLoop(2,"default");
LABELS3 = helperLoop(3,"default");
LABELS4 = helperLoop(4,"default");
LABELS5 = helperLoop(5,"default");

save("labels.mat","LABELS1","LABELS2","LABELS3","LABELS4","LABELS5")
