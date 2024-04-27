script3_tSNE
script4_ambiguity

f = figure("Color","w","Position",[302,201,951,674]);
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
gscatter(softmaxtsne(:,1),softmaxtsne(:,2),valImds.Labels,colors,'.',20);
title("Softmax activations")
l = legend("Location","bestoutside","Interpreter","none");

scatter(softmaxtsne(v,1),softmaxtsne(v,2), ...
    "black","LineWidth",2,"DisplayName","prediction for 95th: "+string(YPred(v)));