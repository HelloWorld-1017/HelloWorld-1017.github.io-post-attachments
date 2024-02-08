clc,clear,close all

rng("default")

% Create a set of 10 random probability vectors. 
% The vectors express the probability that an observation belongs to one of five classes.
classes = ["Red","Yellow","Green","Blue","Purple"];
prob = rand(10,numel(classes));
prob = prob./sum(prob,2);

% Decode the probabilities into the most probable classes. 
labels = onehotdecode(prob,classes,2,"string");
