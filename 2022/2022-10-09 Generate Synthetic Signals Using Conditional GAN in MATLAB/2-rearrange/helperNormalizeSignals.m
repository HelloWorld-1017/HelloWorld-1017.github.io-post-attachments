function [flowNormalized,meanFlow,stdFlow] = helperNormalizeSignals(flow)
meanFlow = mean(flow,2);
flowNormalized = flow-meanFlow;
stdFlow = std(flowNormalized(:));
flowNormalized = flowNormalized/stdFlow;
end