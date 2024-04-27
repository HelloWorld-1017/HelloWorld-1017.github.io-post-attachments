% Define model loss function
function [loss,gradients,state] = modelLoss(net,X,T1,T2)
[Y1,Y2,state] = forward(net,X,Outputs=["softmax" "fc_2"]);

lossLabels = crossentropy(Y1,T1);
lossAngles = mse(Y2,T2);

loss = lossLabels + 0.1*lossAngles;
gradients = dlgradient(loss,net.Learnables);
end