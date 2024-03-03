% Define mini-batch preprocessing function
function [X,T1,T2] = preprocessData(dataX,dataT1,dataT2)
% Extract image data from cell and concatenate
X = cat(4,dataX{:});

% Extract label data from cell and concatenate
T1 = cat(2,dataT1{:});

% Extract angle data from cell and concatenate
T2 = cat(2,dataT2{:});

% One-hot encode labels
T1 = onehotencode(T1,1);

% size(X),size(T1),size(T2)
% ans =
%     28    28     1   128
% ans =
%     10   128
% ans =
%      1   128
end