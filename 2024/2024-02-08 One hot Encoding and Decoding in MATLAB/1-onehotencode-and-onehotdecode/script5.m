clc,clear,close all

% Create a table of observations of several types of categorical data.
color = categorical(["blue";"red";"blue";"green";"yellow";"red"]);
pets = categorical(["dog";"fish";"cat";"dog";"cat";"bird"]);
location = categorical(["USA";"CAN";"CAN";"USA";"AUS";"USA"]);
data = table(color,pets,location);
encData = table();

% Use a for-loop to one-hot encode each table variable 
% and append it to a new table containing the encoded data.
for i=1:width(data)
    encData = [encData,onehotencode(data(:,i))]; %#ok
end