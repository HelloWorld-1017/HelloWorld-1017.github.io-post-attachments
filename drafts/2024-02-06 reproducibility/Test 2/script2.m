clc,clear,close all

load labels.mat
for j = 1:5
    eval("labels"+num2str(j)+" = [];");
    for i = 1:2840
        eval("labels"+num2str(j)+" = [labels"+num2str(j)+",LABELS"+num2str(j)+".(""iteration""+num2str(i))];");
    end
    eval("clear LABELS"+num2str(j))
end

sum(labels1==labels2)
sum(labels2==labels3)
sum(labels3==labels5)