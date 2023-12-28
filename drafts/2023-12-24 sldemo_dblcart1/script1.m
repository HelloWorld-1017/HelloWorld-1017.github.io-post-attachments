clc,clear,close all

offset = 0;

% Plot the mass-spring-damper system
xy_spring = [ ...
    0.0,  0.0;
    0.4,  0.0;
    0.8,  0.65;
    1.6,  -0.65;
    2.4,  0.65;
    3.2,  -0.65;
    3.6,  0.0;
    4.0,  0.0];

xy_mass1 = [ ...
    0.0,   1.1
    0.0,   -1.1
    -2.0,  -1.1
    -2.0,  1.1
    0.0,   1.1];

xy_mass2 = [ ...
    0.0,  1.1
    2.0,  1.1
    2.0,  -1.1
    0.0,  -1.1
    0.0,  1.1];

x_spring = xy_spring(:,1);
y_spring = xy_spring(:,2);

x_mass1 = xy_mass1(:,1);
y_mass1 = xy_mass1(:,2);

x_mass2 = xy_mass2(:,1);
y_mass2 = xy_mass2(:,2);

x = [x_mass1; x_spring; x_mass2+offset];
y = [y_mass1; y_spring; y_mass2];

% Plot and then put the line into the "UserData" property
hndl = plot(x,y,"Color","r","LineWidth",3);

axis(gca,[-10 20 -7 7]);