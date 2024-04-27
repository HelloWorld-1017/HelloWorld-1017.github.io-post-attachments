clc,clear,close all

observations = ["dog","fish","cat","dog","cat","bird"];
subClasses = ["bird";"cat";"dog"]; % Note the order
encodedObservations = onehotencode(observations,1,"ClassNames",subClasses);

