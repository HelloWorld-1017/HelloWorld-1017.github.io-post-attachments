function [sys,x0,str,ts,simStateCompliance] = crtanim2(t,x,u,flag,ts)%#ok
% CRTANIM2 S-function for animating the motion of a mass-spring system.
%   Ned Gulley, 6-21-93
%   Copyright 1990-2010 The MathWorks, Inc.

global x_spring x_mass1 x_mass2 fig ax%#ok
offset = 4;

if flag == 0 % Initialize the figure for use with this simulation
    % Initialize the figure and axes using user-defined function `animinit`
    [fig,ax] = animinit("dblcart1 Animation");
    set(fig,"Color","w")
    axis(ax,[-10 20 -7 7]);
    hold(ax,"on");

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
    hndl = plot(ax,x,y,"Color","r","LineWidth",3);
    set(ax,"UserData",hndl);

    % Draw the floor under the sliding masses
    plot(ax,[-10 20],[-1.3 -1.3],"Color",0.7*[1,1,1],"LineWidth",2);
    plot(ax,[-10:19;-9:20],[-2 -1.3],"Color",0.7*[1,1,1],"LineWidth",2);

    % Specify output variables: sys, x0, str, ts
    sys = [0 0 0 2 0 0 1];
    x0  = [];
    str = [];
    ts  = [-1, 0];

    % Specify that the simState for this s-function is same as the default
    simStateCompliance = "DefaultSimState";

elseif flag == 2 % Update animation showing in the current axes
    shh = get(0,"ShowHiddenHandles");
    set(0,"ShowHiddenHandles","on");

    if any(get(0,"Children")==fig)
        if strcmp(get(fig,"Name"),"dblcart1 Animation")
            set(0,"currentfigure",fig)
            u(2) = u(2) + offset;
            distance = u(2)-u(1);
            hndl = get(ax,"UserData");
            x = [x_mass1+u(1);
                x_spring/4*distance+u(1);
                x_mass2+distance+u(1)];
            set(hndl,"XData",x);
            drawnow
        end
    end
    set(0,"ShowHiddenHandles",shh);
    sys = [];

elseif flag == 4 % Return next sample hit
    % ns stores the number of samples
    ns = t/ts;

    % This is the time of the next sample hit.
    sys = (1+floor(ns+1e-13*(1+ns)))*ts;
end
end


