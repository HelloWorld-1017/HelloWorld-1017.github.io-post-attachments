2023-12-08

# Initial value problem for first-order ordinary equation

An **initial value problem (IVP)** for a first-order **ordinary differential equation (ODE)** is the equation together with an initial condition on a specific interval $a\le t\le b$:
$$
\left\{
\begin{split}
&y^{\prime}=f(t,y)\\
&y(a)=y_a\\
\end{split}\right.,\quad t\in[a,b]
$$
If the right-hand side $f(t,y)$ is independent of $t$, i.e.,
$$
y^\prime = f(y)
$$
then we call the equation is **autonomous**.

**Logistic equation** is a typical IVP of a first-order ODE:

$$
\left\{
\begin{split}
&y^{\prime}=y(1-y)\\
&y(0)=y_0\\
\end{split}
\right.,\quad t\in[0,T]\label{eq1}
$$

this is a autonomous equation.


$$
\dfrac{\mathrm{d}y}{\mathrm{d}t}=y(1-y)\Rightarrow\dfrac{1}{y(1-y)}\mathrm{d}y=\mathrm{dt}
$$
Integrate the both side, and refer to the list of integrals [^3], 

> $$
> \int\dfrac{1}{x(ax+b)}\mathrm{d}x=-\dfrac1b\ln\Big\vert\dfrac{ax+b}{x}\Big\vert+C
> $$

we have:
$$
\begin{split}
&\int\dfrac{1}{y(1-y)}\mathrm{d}y=\int\mathrm{d}t\\
\Rightarrow&-\ln\Big\vert\dfrac{1-y}{y}\Big\vert=t+C_1\\
\Rightarrow&\ln\Big\vert\dfrac{1-y}{y}\Big\vert=-t+C_1\\
\Rightarrow&\exp\Big(\ln\Big\vert\dfrac{1-y}{y}\Big\vert\Big)=C_1\exp(-t)\\
\Rightarrow&\Big\vert\dfrac{1-y}{y}\Big\vert=C_1\exp(-t)\\
\Rightarrow&\dfrac{1-y}{y}=C_1\exp(-t)\\
\Rightarrow&y=\dfrac{1}{1+C_1\mathrm{e}^{-t}}
\end{split}
$$
and from $y(0)=y_0$, we could obtain that:
$$
\dfrac{1}{1+C_1\mathrm{e}^{-t}}=y_0\Rightarrow C_1 = \dfrac{1-y_0}{y_0}\ (\text{if}\ y_0\ne1)
$$
so, the closed-form solution of ODE $\eqref{eq1}$ is:
$$
y(t)=\dfrac{1}{1+\dfrac{1-y_0}{y_0}\mathrm{e}^{-t}}\label{eq2}
$$

> We could verify $\eqref{eq2}$ in the case of $y_0=0.1$ in MATLAB [^4]:
>
> ```matlab
> syms y(t)
> ode = diff(y) == y*(1-y);
> IV = y(0) == 0.1;
> dsolve(ode,IV)
> ```
>
> ```
> ans =
> exp(t)/(exp(t) + 9)
> ```

For $\eqref{eq2}$, if we use arrow to plot the slope at each point in the cases of different initial values $t_0$:

```matlab
clc,clear,close all

helperCreateGIF()

function helperCreateGIF()
animFilename = "gif.gif";
fps = 6;

for frame = 1:20
    drawframe(frame)
    fig = gcf();
    im = getframe(fig);
    [A,map] = rgb2ind(im.cdata,256);
    if frame == 1
        imwrite(A,map,animFilename,"LoopCount",Inf,"DelayTime",1/fps);
    else
        imwrite(A,map,animFilename,"WriteMode","append","DelayTime", 1/fps);
    end
end
end

function drawframe(f)
persistent colors t yt IVs
persistent fig ax yts
if f == 1
    IVs = 0:0.1:1.9;
    fig = figure("Position",[199.66,381.66,970.66,664.66],"Color","w");
    ax = axes(fig);
    axis(ax,[0,2,-0.2,2])
    ax.Toolbar.Visible = "off";
    hold(ax,"on"),grid(ax,"on"),box(ax,"on")
    colors = [
        0.325,0.525,0.545; 0.48,0.772,0.804; 0.556,0.898,0.932; 0.596,0.96,1; % CadetBlue
        0.27,0.545,0; 0.4,0.804,0; 0.464,0.932,0; 0.498,1,0; % Chartreuse
        0.43,0.484,0.545; 0.635,0.71,0.804; 0.736,0.824,0.932; 0.792,0.884,1; % LightSteelBlue
        0.545,0,0.545; 0.804,0,0.804; 0.932,0,0.932; 1,0,1; % Magenta
        0,0.545,0.545; 0,0.804,0.804; 0,0.932,0.932; 0,1,1; % Cyan
        ];

    t = 0:0.1:2;
    yt = @(t,y0) 1./(1+(1-y0)/y0*exp(-t));
    yts = nan(numel(IVs),numel(t));
    for i = 1:numel(IVs)
        yts(i,:) = yt(t,IVs(i));
        plot(t,yts(i,:),"Marker",".","HandleVisibility","off","Color",0.7*[1,1,1],"MarkerSize",10)
    end
end

qs = gobjects(numel(IVs),1);
for i = 1:numel(IVs)
    qs(i) = quiver(t(f),yts(i,f),t(f+1)-t(f),yts(i,f+1)-yts(i,f), ...
        "LineWidth",1,"AutoScaleFactor",0.9,"Color",colors(i,:),...
        "DisplayName",sprintf("y_0=%.2f",IVs(i)),"MaxHeadSize",1);
    if f ~= 1
        qs(i).HandleVisibility = "off";
    end
end
legend("Location","westoutside","Interpreter","tex","FontName","Times New Roman")
end
```

<div id="fig-1"></div>

![gif](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202312081936413.gif)

==add xlabel and ylabel==

As can be seen, ODE $y^\prime = y(1-y)$ actually has infinitely many solutions, and we could determine one of them, by specifying initial value $y_0$ in $\eqref{eq2}$. And in fact, adopting different initial value will cause different different solution $y(t)$. Furthermore, if we draw the slope at each point (like the arrow in [Fig. 1](#fig-1))  in the plane, we can get the slope field, or direction field, of the differential equation.

<br>

# Euler’s method

In fact, logistic equation $\eqref{eq1}$ is a special ODE, because it has closed-form solution $y(t)$ like $\eqref{eq2}$. However, in more general scenarios, different equations have no explicit solution formula, and one should use numerical iteration algorithm to find how variable $y$ change as $t$. And [Fig. 1](#fig-1) shows one approach of this sort: to computationally “solve” the differential equation **by following arrows**, or rather, *start at the initial condition $(t_0,y_0)$, and follow the direction specified there. After moving a short distance, re-evaluate the slope at the new point $(t_1,y_1)$, move farther according to the new slope, and repeat the process. There will be some error associated with the process, since, in between evaluations of the slope, we will not be moving along a completely accurate slope. But if the slopes change slowly, we may get a fairly good approximation to the solution of the initial value problem.* This method is called **Euler’s method**.

More formally, for ODE:
$$
\left\{
\begin{split}
&y^{\prime}=f(t,y)\\
&y(a)=y_a\\
\end{split}\right.,\quad t\in[a,b]
$$
the Euler’s method can be expressed as follows:
$$
\begin{split}
y_0 &= y_0\\
y_{i+1} &= y_i+hy' =y_i+hf(t_i,y_i)
\end{split}
$$
where $h$ is step size, $y_i$ is an approximation to the solution at $t_i$.

As mentioned above, Logistic function $\eqref{eq1}$ is autonomous, so to illustrate the Euler’s method more generally, Sauer provided another IVP:
$$
\left\{
\begin{split}
&y^\prime = ty+t^3\\
&y(0) = y_0\\
\end{split}\right.,\quad t\in[0,1]\label{eq3}
$$
When $y_0=1$, $\eqref{eq3}$ has a closed-form solution:
$$
y(t)=3\mathrm{e}^{t^2/2}-t^2-2
$$

> ```matlab
> syms y(t)
> ode = diff(y) == t*y+t^3;
> IV = y(0) == 1;
> dsolve(ode,IV)
> ```
>
> ```
> ans =
> 3*exp(t^2/2) - t^2 - 2
> ```

and Euler method for $\eqref{eq3}$ is:
$$
\begin{split}
y_0 &= y_0\\
y_{i+1} &= y_i+h(t_iy_i+t_i^3)
\end{split}
$$




==GIF h = 0.1==

and when $h$ is set to 0.05:





(1) The error is nonzero, and the error tends to grow, from zero at the initial condition to its largest value at the end of the interval, although the maximum error will not always be found at the end;

(2) Since Euler’s method takes non-infinitesimal steps, the slope changes along the step and the approximation does not lie exactly on the solution curve. 

(3) The error decreases as the step size $h$ decreases. And in fact, the error is proportional to $h$. 

## Lipschitz continuous, and errors

<br>

# The explicit trapezoid method (AKA improved Euler method or Heun method)

The **explicit trapezoid method** is expressed as follows:
$$
\begin{split}
y_0 &= y_0\\
y_{i+1} &= y_i+\dfrac{h}2\Big(f(t_i,y_i)+f\big(t_i+h,w_i+hf(t_i,w_i)\big)\Big)
\end{split}
$$
<br>

# Taylor methods

<br>

# Higher order equations







<br>

**References**

[1] page 282.

[Logistic function - Wikipedia](https://en.wikipedia.org/wiki/Logistic_function).

[8.4: The Logistic Equation - Mathematics LibreTexts](https://math.libretexts.org/Bookshelves/Calculus/Calculus_(OpenStax)/08%3A_Introduction_to_Differential_Equations/8.04%3A_The_Logistic_Equation).

[^3]: [积分表 - 维基百科](https://zh.wikipedia.org/zh-my/%E7%A7%AF%E5%88%86%E8%A1%A8).
[^4]: [Solve a System of Differential Equations - MathWorks](https://ww2.mathworks.cn/help/symbolic/solve-a-system-of-differential-equations.html).





