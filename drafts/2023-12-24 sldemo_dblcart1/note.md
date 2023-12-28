---
layout: single
title: "Example \"Double Spring Mass System\" from MATLAB Simulink"
date: 2023-12-xx xx:xx:xx +0800
categories:
 - MATLAB
 - Signals and Systems
tags:
 - MATLAB Simulink
 - MATLAB Animation
 - MATLAB Graphics
 - Optimal Control
---

# Introduction

In my previous blog “Simulate Double Mass-Spring-Damper System in MATLAB” [^1], I ever 

<div id="fig-1"></div>

![image-20231209180421010](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202312091804556.png)





<br>

# Model details

This section will ...

At first, the system showing in the [Fig. 1](#fig-1) includes two subsystems, `State estimator` and `Inputs & Sensors`. However, these two subsystems are very simple, so I take out the blocks in them, and in the following context I will discuss the following model: 

![image-20231209224135719](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202312092242318.png)

On another hand, ==parameters `` described below are set in the Model Workspace.==

## Force source

The force source is applied using a `Signal Generator` block:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202312092214292.png" alt="image-20231209221429001" style="zoom:67%;" />

this block generate a square wave with amplitude equal to 15 and frequency 0.3. 

In addition, as can be seen, the actual force applied on the mass block is the force difference of generated force and a feedback related to the system state:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202312092225975.png" alt="image-20231209222553926" style="zoom:67%;" />

this point will be discussed after introducing the state estimator.

## Mass-spring-damper system with two degrees of freedom

As described in blog [^1], taking the position and velocity of two mass blocks as a state vector:
$$
\begin{bmatrix}
z_1\\
z_2\\
z_3\\
z_4\\
\end{bmatrix}=
\begin{bmatrix}
x_1\\
v_1\\
x_2\\
v_2\\
\end{bmatrix}
$$
then the state function of a mass-spring-damper system with two degrees of freedom can be expressed as follows:
$$
\begin{split}
\begin{bmatrix}
\dot{z}_1\\
\dot{z}_2\\
\dot{z}_3\\
\dot{z}_4\\
\end{bmatrix}&=
\begin{bmatrix}
0&1&0&0\\
-\dfrac{k_1+k_2}{m_1}&-\dfrac{b_1+b_2}{m_1}&\dfrac{k_2}{m_1}&\dfrac{b_2}{m_1}\\
0&0&0&1\\
\dfrac{k_2}{m_2}&\dfrac{b_2}{m_2}&-\dfrac{k_2}{m_2}&-\dfrac{b_2}{m_2}
\end{bmatrix}
\begin{bmatrix}
z_1\\
z_2\\
z_3\\
z_4\\
\end{bmatrix}+
\begin{bmatrix}
0&0\\
\dfrac1{m_1}&0\\
0&0\\
0&\dfrac1{m_2}
\end{bmatrix}
\begin{bmatrix}
F_1\\
F_2\\
\end{bmatrix}
\end{split}
$$
where $[F_1\ F_2]$ is the input vector. In this example, matrices $A$ and $B$ in `Plane` block are:
$$
\begin{split}
&A=\begin{bmatrix}
0 & 1 & 0 & 0\\
-\text{ka/m1} & 0 & \text{ka/m1} & 0\\
0 & 0 & 0 & 1\\
\text{ka/m2} & 0 & -\text{ka/m2} & 0\\
\end{bmatrix},
B=\begin{bmatrix}
0\\1\\0\\0
\end{bmatrix}
\end{split}
$$
where
$$
\text{ka}=1,\ \text{m1}=1,\ \text{m2}=1
$$
As can be seen, in this system:

(1) The damping coefficient is not took into account;

(2) Two springs have the same spring rate $\text{ka}$.

(3) The force is only applied on the left mass block, without the right one.

Besides, matrices $C$ and $D$ set in the `Plane` block are:
$$
C = \begin{bmatrix}
1 & 0 & 0 & 0\\
0 & 0 & 1 & 0\\
0 & 0 & 1 & 0\\
\end{bmatrix},\ 
D = \begin{bmatrix}
0\\0\\0\\
\end{bmatrix}
$$
which means that the `Plane` block outputs the first, third and third variables in state vector $[x_1,\ v_1,\ x_2,\ v_2]^T$, i.e., output vector:
$$
\boldsymbol{y} = \begin{bmatrix}
x_1&x_2&x_2
\end{bmatrix}^T
$$
After that, two `Selector` block [^3] are used to select one or more variables in output vector for different usage:

![image-20231209225018468](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202312092250640.png)

The first one is to extract $[x_1\ x_2]$ for creating animation, while the second one is to extract $x_2$ to calculate the feedback force.

## State estimator

As mentioned above, the actual force applied on the mass $F'$ is the difference of generating force $F$ and a feedback force $f$, i.e.,
$$
F'=F-f
$$
and in which, feedback $f$ is mainly calculated based on a state function, which is also realized by a `State Space` block named `State estimator`.

For `State estimator` block, its input vector is:
$$
\begin{bmatrix}
F_1\\
F_2
\end{bmatrix}
=\begin{bmatrix}
F'\\
x_2\\
\end{bmatrix}
$$
==what is state vector?==

and state matrix $A$ and input matrix $B$ are:
$$
A = \begin{bmatrix}
0 & 1 & -31.4507 & 0\\
-1 & 0 & 44.8537 & 0\\
0 & 0 & -46.6599 & 1\\
1 & 0 & -89.5750 & 0\\
\end{bmatrix},\ 
B = \begin{bmatrix}
0 & 31.4507 \\
1 & -43.8537\\
0 & 46.6599\\
0 & 88.5750
\end{bmatrix}
$$
N.B., $A$ and $B$ are specified in Model Workspace by variable `ae` and `be`.
{: .notice--primary}

and output matrix $C$ and $D$ are:
$$
C = \begin{bmatrix}
1 & 0 & 0 & 0\\
0 & 1 & 0 & 0\\
0 & 0 & 1 & 0\\
0 & 0 & 0 & 1\\
\end{bmatrix},\ 
D = \begin{bmatrix}
0 & 0\\
0 & 0\\
0 & 0\\
0 & 0\\
\end{bmatrix}
$$
N.B., $C$ and $D$ are specified in Model Workspace by variable `ce` and `de`.
{: .notice--primary}


$$
\dot{\boldsymbol{z}}=\begin{bmatrix}
z_2-31.4507z_3+31.4507x_2\\
-z_1+44.8537z_3+F'-43.8537x_2\\
-46.6599z_3+z_4+46.6599x_2\\
z_1-89.5750z_3+88.5750x_2
\end{bmatrix}
$$






> $$
> \dot{\boldsymbol{z}}=\begin{bmatrix}
> v_1\\
> -x_1+F'+x_2\\
> v_2\\
> x_1+x_2
> \end{bmatrix}
> $$
>





and 
$$
\boldsymbol{y}=\begin{bmatrix}
z_2-31.4507z_3+31.4507x_2\\
-z_1+44.8537z_3+F'-43.8537x_2\\
-46.6599z_3+z_4+46.6599x_2\\
z_1-89.5750z_3+88.5750x_2
\end{bmatrix}
$$

$$
K=\begin{bmatrix}
3.0819 & 2.4827 & 0.0804 & 3.1866
\end{bmatrix}
$$
`Gain` block named `Feedback Gain Using LQR Design`

Linear-quadratic regulator [^4] 

so the feedback is:
$$
\begin{split}
f=K\boldsymbol{y}=&3.0819(z_2-31.4507z_3+31.4507x_2)\\
&+2.4827(-z_1+44.8537z_3+F'-43.8537x_2)\\
&+0.0804(-46.6599z_3+z_4+46.6599x_2)\\
&+3.1866(z_1-89.5750z_3+88.5750x_2)
\end{split}
$$



> $$
> \begin{split}
> f=K\boldsymbol{y}=&3.0819v_1\\
> &+2.4827(-x_1+F'+x_2)\\
> &+0.0804v_2\\
> &+3.1866(x_1+x_2)\\
> =&3.0819v_1+0.0804v_2+0.7039x_1+5.6693x_2+2.4827F'
> \end{split}
> $$












## Animation

In this example, an animation simultaneously shows the movement of the mass-spring-damper system while simulating, like this:

![image-20231210162509603](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202312101625684.png)

this is realized by a `S-function` block [^7]:

![image-20231210162753957](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202312101627119.png)

where `crtanim2` is a user-defined function, which is defined by Ned Gulley (i.e., the author of this example):

```matlab
function [sys,x0,str,ts,simStateCompliance]=crtanim2(t,x,u,flag,ts)%#ok
%CRTANIM2 S-function for animating the motion of a mass-spring system.

%   Ned Gulley, 6-21-93
%   Copyright 1990-2010 The MathWorks, Inc.

global xSpr2 xBx12 xBx22 dblcart1

offset=4;

if flag==2
    
    shh = get(0,'ShowHiddenHandles');
    set(0,'ShowHiddenHandles','on');
    
    if any(get(0,'Children')==dblcart1)
        if strcmp(get(dblcart1,'Name'),'dblcart1 Animation')
            set(0,'currentfigure',dblcart1)
            u(2)=u(2)+offset;
            distance=u(2)-u(1);
            hndl=get(gca,'UserData');
            x=[xBx12+u(1); xSpr2/4*distance+u(1); xBx22+distance+u(1)];
            set(hndl,'XData',x);
            drawnow;
        end
    end
    
    set(0,'ShowHiddenHandles',shh);
    
    sys=[];

elseif flag == 4 % Return next sample hit
  
  % ns stores the number of samples
  ns = t/ts;

  % This is the time of the next sample hit.
  sys = (1 + floor(ns + 1e-13*(1+ns)))*ts;

elseif flag==0

  % Initialize the figure for use with this simulation
  [dblcart1 dblcartAxes] = animinit('dblcart1 Animation');
  axis(dblcartAxes,[-10 20 -7 7]);
  hold(dblcartAxes,'on');

  xySpr2=[ ...
        0.0       0.0
        0.4       0.0
        0.8       0.65
        1.6      -0.65
        2.4       0.65
        3.2      -0.65
        3.6       0.0
        4.0       0.0];
  xyBx12=[ ...
        0.0       1.1
        0.0      -1.1
       -2.0      -1.1
       -2.0       1.1
        0.0       1.1];
  xyBx22=[ ...
        0.0       1.1
        2.0       1.1
        2.0      -1.1
        0.0      -1.1
        0.0       1.1];
  xBx12=xyBx12(:,1);
  yBx12=xyBx12(:,2);
  xBx22=xyBx22(:,1);
  yBx22=xyBx22(:,2);
  xSpr2=xySpr2(:,1);
  ySpr2=xySpr2(:,2);

  x=[xBx12; xSpr2; xBx22(:,1)+offset];
  y=[yBx12; ySpr2; yBx22];

  % Draw the floor under the sliding masses
  plot(dblcartAxes,[-10 20],[-1.3 -1.3],'yellow', ...
       [-10:19;-9:20],[-2 -1.3],'yellow','LineWidth',2);
  hndl=plot(dblcartAxes,x,y,'y','LineWidth',3);
  set(dblcartAxes,'UserData',hndl);

  sys = [0 0 0 2 0 0 1];
  x0  = [];
  str = [];
  ts  = [-1, 0];
  % specify that the simState for this s-function is same as the default
  simStateCompliance = 'DefaultSimState';
end
```

`crtanim2` is used to initialize and render the animation. To learn this function, I modified the function like this: 
<div id="script-1"></div>

```matlab

```

and in the following text, I would introduce this example step by step.

### The inputs and outputs of `crtanim2` function

 The `crtanim2` function is actually a Level-1 MATLAB S-Function [^5], and whose inputs are `t`, `x`, `u`, `flag`, and `ts`, and outputs are `sys`, `x0`, `str`, `ts`, and `simStateCompliance`. According to the official documentation [^5], their meaning shows as follows.

**(1) Input variables**

The input variables of `crtanim2` function is obtained from the simulation process of the model, 

- `t`, current simulation time;

- `x`, state vector. 

  - In this example, `x` is always `[]` throughout the entire simulation process.

- `u`, input vector.

  - In this example, `u` is the position vector of two mass blocks. 

- `flag`, an integer value that indicates the task to be performed by the S-function:

  <img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202312100049118.png" alt="image-20231210004917848" style="zoom: 50%;" />

  As will showed later, `flag` is used to determine the operation branch of `crtanim2` function, either initialize, update, or just skip the animation.

- `ts`, time step. In this example, whose value is `0.1000`.

**(2) Output variables**

==what is function of outputs==

- `sys`, a generic return argument. The values returned depend on the `flag` value. 
  - ==As can be seen from script xxx==, In this example, if `flag` is `0`, `sys` is set to `sys = [0 0 0 2 0 0 1];`.
  - when `flag` is `2`, `sys` is always set to empty, i.e., `[]`.
  - when `flag` is `4`, `sys` is set to `sys = (1 + floor(ns + 1e-13*(1+ns)))*ts;`. ==However, seem not jump to this branch==

- `x0`, the initial state values (an empty vector if there are no states in the system). `x0` is ignored, except when `flag = 0`.
  - In this example, `x0` is only set if `flag` is `0`, and whose value is `[]`.

- `str`, originally intended for future use. Level-1 MATLAB S-functions must set this to the empty matrix, `[]`.
  - In this example, `str` is also set to `[]` if `flag` is `0`.

- `ts`, a two-column matrix containing the sample times and offsets of the block.
  - if we want S-function to run at every time step (continuous sample time), set `ts` to `[0 0]`;
  - if we want S-function to run at the same rate as the block to which it is connected (inherited sample time), set `ts` to `[-1 0]`. **It is the case of this example.**
  - If we want it to run every `0.25` seconds (discrete sample time) starting at `0.1` seconds after the simulation start time, set `ts` to `[0.25 0.1]`.
  - In addition, we can create S-functions that do multiple tasks, each at a different sample rate (i.e., a multirate S-function).
- `simStateCompliance`, in this example, it is specified if `flag` is `0`: `simStateCompliance = "DefaultSimState";`.

### The structure of `crtanim2` function

As can be seen from [`crtainim2` function](#script-1), apart from defining some global variables and a constant variable `offset`, it mainly has three `if-else` branches according to input variable `flag`:

```matlab
function [sys,x0,str,ts,simStateCompliance] = crtanim2(t,x,u,flag,ts)%#ok
% CRTANIM2 S-function for animating the motion of a mass-spring system.
%   Ned Gulley, 6-21-93
%   Copyright 1990-2010 The MathWorks, Inc.

global x_spring x_mass1 x_mass2 fig ax %#ok
offset = 4;

if flag == 0 % Initialize the figure for use with this simulation
	...
elseif flag == 2 % Update animation showing in the current axes
	...
elseif flag == 4 % Return next sample hit
	...
end
end
```

The first branch (`flag == 0`) is to intialize the figure showing the animation, the second one (`flag == 2`) is to update the animation, and the last one (`flag == 4`) is to return next sample hit. I will discuss them in detail as follows.

### Case `flag == 0`

If `flag == 0`, `crtanim2` function will initialize the figure showing the animation, and it 

==(add detailed codes)==

```matlab
...
if flag == 0 % Initialize the figure for use with this simulation
	...
elseif flag == 2 % Update animation showing in the current axes
...
end
```

The initialization steps include ==xxx== parts:

**(1) Initialize the figure and axes**

```matlab
% Initialize the figure and axes using user-defined function `animinit`
[fig,ax] = animinit("dblcart1 Animation");
set(fig,"Color","w")
axis(ax,[-10 20 -7 7]);
hold(ax,"on");
```

Intializing the figure and axes is realized by the `animinit` function, which is also defined by Ned Gulley. This function is used to create and set a special figure and whose axes, and furthermore, it also creates a small UI button for users to close the animation (but it won’t stop the simulation):

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202312102116482.png" alt="image-20231210211620434" style="zoom:50%;" />

**(2) Plot the mass-spring-damper system**

```matlab
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
```

In the above codes, `xy_spring`, `xy_mass1`, `xy_mass2` are the coordinates $(x,y)$ of the spring, the left mass, and the right mass block, respectively. Then, they are split into `x_spring`, `x_mass1`, and `x_mass2` (x coordinates of these three stuffs), and `y_spring`, `y_mass1`,and `y_mass2` (y coordinates for each). The masses would only slide in the x-axis direction, so as can be seen from [`crtanim2` function](#script-1), among this six variables, only `x_spring`, `x_mass1`, and `x_mass2` are set as global variables. They will be updated when `flag=2`.

Afterwards, `x_spring`, `x_mass1`, and `x_mass2` are linked into `x`, and `y_spring`, `y_mass1`,and `y_mass2` are linked into `y`, so that we could plot the entire system using one single `plot` function. Among `x`, we can find that `x_mass2` is added with an constant `offset`, which is defined before `if` statement (See [`crtanim2` function](#script-1)). `offset` is the initial distance of two masses, and also the initial length of spring. For example, if we change `offset` to `0`, the initial sate is like this:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202312102148998.png" alt="image-20231210214842949" style="zoom:50%;" />

At last, the `Line` object `hndl` created by `plot` function is put into the `"UserData"` property of the axes:

```matlab
set(ax,"UserData",hndl);
```

**(3) Plot the ground**

The animation shows the slide of mass blocks on a ground under external forces (by the way, this ground is absolutely smooth without friction), so another part of codes display this kind of ground:

```matlab
% Draw the floor under the sliding masses
plot(ax,[-10 20],[-1.3 -1.3],"Color",0.7*[1,1,1],"LineWidth",2);
plot(ax,[-10:19;-9:20],[-2 -1.3],"Color",0.7*[1,1,1],"LineWidth",2);
```

**(4) Other specification**

```matlab
% Specify output variables: sys, x0, str, ts
sys = [0 0 0 2 0 0 1];
x0  = [];
str = [];
ts  = [-1, 0];

% Specify that the simState for this s-function is same as the default
simStateCompliance = "DefaultSimState";
```

### Case `flag == 2`

If input variable `flag` equals to `2`, [`crtanim2` function](#script-1) will update the animation, and the corresponding codes show as follows:

```matlab
...
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
            drawnow;
        end
    end
    set(0,"ShowHiddenHandles",shh);
    sys = [];
elseif flag == 4 % Return next sample hit
...
```

As can be seen, at the beginning, this code gets the initial value of an object’s `"ShowHiddenHandles"` property (actually its initial value is `"off"`), and then set whose value to `"on"`, and finally reset it to original state (i.e.,  `"off"`). This object, which is obtained by `get(0)`, is a “graphics root object” [^8], and the meaning of whose `"ShowHiddenHandles"` property [^9] is:

![image-20231210175031489](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202312101750542.png)

This is my first time to encounter this sort of “graphics root object” , so I don’t know exactly what it is. I can just feel that it is the “parent” of `Figure` object, but I have no idea about why Gulley use it, and what `"ShowHiddenHandles"` property actually influences. But if we don’t change whose `"ShowHiddenHandles"` property to `"on"` at the beginning, the animation won’t be updated. 

As for updating animation, it is realized by updating `x` variable which we initialize at the case of `flag=0`:

```matlab
...
u(2) = u(2) + offset;
distance = u(2)-u(1);
hndl = get(ax,"UserData");
x = [x_mass1+u(1);
    x_spring/4*distance+u(1);
    x_mass2+distance+u(1)];
set(hndl,"XData",x);
drawnow;
...
```









### Case `flag == 4`

If `flag==4`, jump this animation function





### Some improvement



==将代码更改为能够创建GIF的代码==














$$
\begin{split}
\text{xBx1}&=\begin{bmatrix}
0 & 0 & -2 & -2 & 0
\end{bmatrix}^T\\
\text{xBx2}&=\begin{bmatrix}
0 & 2 & 2 & 0 & 0
\end{bmatrix}^T
\end{split}
$$



$$
\text{xSpr}=\begin{bmatrix}
0 & 0.4 & 0.8 & 1.6 & 2.4 & 3.2 & 3.6 & 4.0
\end{bmatrix}^T
$$




`crtanim2` function to animate the motion process, 







<br>

**References**

[^1]: [Simulate Double Mass-Spring-Damper System in MATLAB - What a starry night~](https://helloworld-1017.github.io/2023-06-20/19-40-31.html#simulating-using-state-space-function)
[^2]: [Double Spring Mass System - MathWorks](https://ww2.mathworks.cn/help/simulink/slref/double-spring-mass-system.html).
[^3]: [MATLAB Simulink `Selector` block: Select input elements from vector, matrix, or multidimensional signal - MathWorks](https://ww2.mathworks.cn/help/simulink/slref/selector.html).
[^4]: [Linear–quadratic regulator - Wikipedia](https://en.wikipedia.org/wiki/Linear%E2%80%93quadratic_regulator).
[^5]: [Maintain Level-1 MATLAB S-Functions - MathWorks](https://ww2.mathworks.cn/help/simulink/sfg/maintaining-level-1-matlab-s-functions.html).
[^6]: [MATLAB `lqr`: Linear-Quadratic Regulator (LQR) design - MathWorks](https://ww2.mathworks.cn/help/control/ref/lti.lqr.html).
[^7]: [MATLAB Simulink `S-Function` block: Include S-function in model - MathWorks](https://ww2.mathworks.cn/help/simulink/slref/sfunction.html).
[^8]: [MATLAB `groot`: Graphics root object - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/groot.html).
[^9]: [MATLAB root properties: Graphics environment and state information - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/matlab.ui.root-properties.html).

