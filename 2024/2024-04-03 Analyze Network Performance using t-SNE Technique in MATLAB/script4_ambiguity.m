% Calculate the ambiguity of output of the final softmax layer
[R,RI] = maxk(softmaxActivations,2,2);
ambiguity = R(:,2)./R(:,1);

% Find the most ambiguous images
[ambiguity,ambiguityIdx] = sort(ambiguity,"descend");

% View the most probable classes of the ambiguous images and the true classes.
classList = unique(valImds.Labels);
top10Idx = ambiguityIdx(1:10);
top10Ambiguity = ambiguity(1:10);
mostLikely = classList(RI(ambiguityIdx,1));
secondLikely = classList(RI(ambiguityIdx,2));
table(top10Idx,top10Ambiguity,mostLikely(1:10),secondLikely(1:10),valImds.Labels(ambiguityIdx(1:10)),...
    'VariableNames',["Image #","Ambiguity","Likeliest","Second","True Class"])

v = top10Idx(1);
figure("Color","w","Position",[745,410,517,424])
imshow(valImds.Files{v});
title(sprintf("Observation: %i, Actual: %s. Predicted: %s", ...
    v,string(valImds.Labels(v)),string(YPred(v))),"Interpreter","none")