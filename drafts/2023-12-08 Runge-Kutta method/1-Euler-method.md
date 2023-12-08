



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

## Logistic problem


$$
\left\{
\begin{split}
&y^{\prime}=y(1-y)\\
&y(0)=y_0\\
\end{split}
\right.,\quad t\in[0,T]\label{eq1}
$$

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

t = 0:0.1:2;

yt = @(t,y0) 1./(1+(1-y0)/y0*exp(-t));

colors = [0.325,0.525,0.545;
    0.48,0.772,0.804;
    0.556,0.898,0.932;
    0.596,0.96,1; % CadetBlue
    0.27,0.545,0;
    0.4,0.804,0;
    0.464,0.932,0;
    0.498,1,0; % Chartreuse
    0.43,0.484,0.545;
    0.635,0.71,0.804;
    0.736,0.824,0.932;
    0.792,0.884,1; % LightSteelBlue
    0.545,0,0.545;
    0.804,0,0.804;
    0.932,0,0.932;
    1,0,1; % Magenta
    0,0.545,0.545
    0,0.804,0.804;
    0,0.932,0.932;
    0,1,1; % Cyan 
    ];

figure("Position",[199.66,381.66,970.66,664.66])
hold(gca,"on"),grid(gca,"on"),box(gca,"on")
IVs = 0:0.1:1.9;
for i = 1:numel(IVs)
    yts = yt(t,IVs(i));
    quiver(t(1:end-1),yts(1:end-1),t(2:end)-t(1:end-1),yts(2:end)-yts(1:end-1), ...
        "LineWidth",1.2,"AutoScaleFactor",0.2,"Color",colors(i,:),...
        "DisplayName",sprintf("y_0=%.2f",IVs(i)))
    scatter(t,yts,20,"Marker",".","MarkerEdgeColor","k","HandleVisibility","off")
end
legend("Location","westoutside","Interpreter","tex","FontName","Times New Roman")
ylim([-0.2,2])
```

![image-20231208175233438](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202312081753424.png)

As can be seen, 









inspires the Euler’s method.

## Euler’s method

常微分方程有无穷多组解，More generally, 







<br>

**References**

[1] page 282.

[Logistic function - Wikipedia](https://en.wikipedia.org/wiki/Logistic_function).

[8.4: The Logistic Equation - Mathematics LibreTexts](https://math.libretexts.org/Bookshelves/Calculus/Calculus_(OpenStax)/08%3A_Introduction_to_Differential_Equations/8.04%3A_The_Logistic_Equation).

[^3]: [积分表 - 维基百科](https://zh.wikipedia.org/zh-my/%E7%A7%AF%E5%88%86%E8%A1%A8).
[^4]: [Solve a System of Differential Equations - MathWorks](https://ww2.mathworks.cn/help/symbolic/solve-a-system-of-differential-equations.html).





