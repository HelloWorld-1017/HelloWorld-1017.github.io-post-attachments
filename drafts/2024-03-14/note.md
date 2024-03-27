---

Calculate Mean Squared Error (MSE) and xxx(MAE) in MATLAB
draft_at: 2024-03-15 17:16:45 +0800
date:
last_modified_at0:
last_modified_at:
---

# Mean Squared Error (MSE) and Mean Absolute Error (MAE)

## MSE

As described in Wikipedia[^1], 




$$
\text{MSE}=\dfrac1N\sum_{i=1}^N(\hat{y}_i-y_i)^2
$$









### For vector

According to most common definition[^1], for $M$-dimensional vectors, Mean Squared Error (MSE) can be calculated as:
$$
\text{MSE}=\dfrac1N\sum_{i=1}^N(\hat{\boldsymbol{y}}_i-\boldsymbol{y}_i)^T(\hat{\boldsymbol{y}}_i-\boldsymbol{y}_i)\label{eq1}
$$
where

- $N$ is total number of observations, and $i$ is the sample index.
- $\boldsymbol{y}$ is the vector of true values (targets), and $\hat{\boldsymbol{y}}$ is the corresponding prediction vector. Both $\boldsymbol{y}_i$ and $\hat{\boldsymbol{y}}_i$ are $M\times1$ vectors, i.e., $M$ is the total number of responses of each observation.

Definitely, Eq. $\eqref{eq1}$ can be rewritten as the pointwise form:
$$
\text{MSE}=\dfrac1N\sum_{i=1}^N\sum_{j=1}^K(\hat{y}_{ij}-y_{ij})^2\label{eq2}
$$
where $j$ is the response index.

## MAE

For $M$-dimensional vectors, Mean Absolute Error (MAE)[^6][^7]



can be expressed in a concise form using $L_1$ norm










$$
\text{MAE}=\dfrac1N\sum_{i=1}^N\vert\vert\hat{\boldsymbol{y}}_i-\boldsymbol{y}_i\vert\vert_1
$$

$$
\text{MAE}=\dfrac1N\sum_{i=1}^N\sum_{j=1}^M\abs{\hat{y}_{ij}-y_{ij}}
$$
## Discussions

not identical (equivalent)







<br>

# Calculate MSE in MATLAB

## MSE for original-type array

In MATLAB, MSE can be calculated based on built-in function `mse`[^2]. However, `mse` function is to calculate MSE based on the formula:
$$
\text{MSE}^\prime=\dfrac1N\textcolor{blue}{\dfrac1M}\sum_{i=1}^N(\hat{\boldsymbol{y}}_i-\boldsymbol{y}_i)^T(\hat{\boldsymbol{y}}_i-\boldsymbol{y}_i)
$$
or rather:
$$
\text{MSE}^\prime=\dfrac1N\textcolor{blue}{\dfrac1M}\sum_{i=1}^N\sum_{j=1}^M(\hat{y}_{ij}-y_{ij})^2
$$
that is, $\text{MSE}^\prime$ is $1/M$ of $\text{MSE}$ that is calculated on Eq. $\eqref{eq1}$ or Eq. $\eqref{eq2}$. 

For example, we could verify this point on seven 3-dimensional vectors `y` and whose predictions `y_hat`:

<div id="script-1"></div>

```matlab
clc,clear,close all
rng("default")

y = rand(3,7);
y_hat = rand(3,7);

disp( mse(y_hat,y) )
disp( sum( (y_hat-y)'*(y_hat-y).*diag(ones(width(y),1)),"all" )/size(y,1)/size(y,2) )
disp( sum( (y_hat-y).^2,"all" )/size(y,1)/size(y,2) )
```

```
    0.2465

    0.2465

    0.2465
```

So, kind of different.

This point was also be asked by user Aditya in StackExchange[^4], but there are not very professional answers yet. To my mind, I suppose that the coefficient $1/M$ probably doesn't matter in most cases, and we should concern relative value of MSE as long as MSE are only calculated based on the same formula in the whole data analysis process.

## MSE for `dlarray`-type array

On another hand, `mse` function can be also used for calculating loss value when training (multi-targets) regression neural networks, where the input values of `mse` function, both predictions and targets, are `dlarray` data type. However, in which case, `mse` function is to calculate **half MSE**, i.e., 
$$
\text{half MSE}=\dfrac1{2N}\sum_{i=1}^n(\hat{\boldsymbol{y}}_i-\boldsymbol{y}_i)^T(\hat{\boldsymbol{y}}_i-\boldsymbol{y}_i)
$$

or
$$
\text{half MSE}=\dfrac1{2N}\sum_{i=1}^N\sum_{j=1}^M(\hat{y}_{ij}-y_{ij})^2
$$

<div id="script-2"></div>

```matlab
clc,clear,close all
rng("default")

y = rand(3,7);
y_hat = rand(3,7);

y = dlarray(y,"CB");
y_hat = dlarray(y_hat,"CB");

disp( mse(y_hat,y) )
disp( sum( stripdims((y_hat-y))'*stripdims((y_hat-y)).*diag(ones(width(y),1)),"all" )/size(y,2)/2 )
disp( sum( (y_hat-y).^2,"all" )/size(y,2)/2 )
```

```
  1×1 dlarray
    0.3697

  1×1 dlarray
    0.3697

  1(C) × 1(B) dlarray
    0.3697
```

> We could choose to specify different data format, or don't specify data format (See blog[^5]):
>
> If we specify the data format of `dlarray` as `"BC"`:
>
> ```matlab
> clc,clear,close all
> rng("default")
> 
> y = rand(3,7);
> y_hat = rand(3,7);
> 
> y = dlarray(y,"BC");
> y_hat = dlarray(y_hat,"BC");
> 
> disp( mse(y_hat,y) )
> disp( sum( stripdims((y_hat-y))'*stripdims((y_hat-y)).*diag(ones(width(y),1)),"all" )/size(y,2)/2 )
> disp( sum( (y_hat-y).^2,"all" )/size(y,2)/2 )
> ```
>
> ```
> 1×1 dlarray
>  0.8626
> 
> 1×1 dlarray
>  0.8626
> 
> 1(C) × 1(B) dlarray
>  0.8626
> ```
>
> No specifying data format:
>
> ==if is a is matrix, then we must specify batch form==

So, in this case, $\text{MSE}$ can be view as be computed based on Eq. $\eqref{eq1}$ or Eq. $\eqref{eq2}$​, and $\text{half MSE}$​, literally, is half of it.





Important: [machine learning - Why do we have to divide by 2 in the ML squared error cost function? - Data Science Stack Exchange](https://datascience.stackexchange.com/questions/52157/why-do-we-have-to-divide-by-2-in-the-ml-squared-error-cost-function).









Emmm, sort of confused ...

## Discussions

Actually, the invoked `mse` function in the above two cases, where input variables are original arrays and where those are `dlarray`s, is different. If we debug the script, we fan find that, when invoking `mse` in [Script 1](#script-1), MATLAB will step in the function:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403260952897.png" alt="image-20240326095204268" style="zoom: 80%;" />

this `mse` function corresponds to the official documentation "**`mse`: Mean squared normalized error performance function**"[^2].

While in [Script 2](#script-2), it will step in another `mse` function:

![image-20240326095314358](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403260953576.png)

and at this time, the `mse` function is described in another official documentation "**`mse`: Half mean squared error**"[^3]. 

Both `mse` functions are from MATLAB Deep Learning Toolbox, but introduced for different usages, "Function Approximation and Nonlinear Regression"[^2] and "Custom Training Loops"[^3]. In short, the latter `mse` function can be viewed as a *method overloading* for `dlarray`-class arrays.

<br>

# Calculate MAE in MATLAB

## MAE for ordinary-type array

Likewise, 



MATLAB provides an `mae` function[^8]


$$
\text{MAE}^\prime=\dfrac1N\textcolor{blue}{\dfrac1M}\sum_{i=1}^N\vert\vert\hat{\boldsymbol{y}}_i-\boldsymbol{y}_i\vert\vert_1
$$
or pointwise form:
$$
\text{MAE}^\prime=\dfrac1N\textcolor{blue}{\dfrac1M}\sum_{i=1}^N\sum_{j=1}^M\abs{\hat{y}_{ij}-y_{ij}}
$$






```matlab
clc,clear,close all
rng("default")

y = rand(3,7);
y_hat = rand(3,7);

disp( mae(y_hat,y) )

error = y_hat-y;
value = 0;
for i = 1:width(y)
    value = value+norm(error(:,i),1);
end
disp( value/size(y,1)/size(y,2) )

disp( sum( abs(y_hat-y),"all" )/size(y,1)/size(y,2) )
```

```
    0.3954

    0.3954

    0.3954
```





## MAE for `dlarray`-type array



```matlab
clc,clear,close all
rng("default")

y = rand(3,7);
y_hat = rand(3,7);

y = dlarray(y,"CB");
y_hat = dlarray(y_hat,"CB");

mae(y_hat,y)
```

MATALB will throw an error:

```
Error using find
Check for incorrect argument data type or missing argument in call to function 'find'.

Error in nnet7.performance_fcn (line 99)
  dontcare = find(isnan(perfs));

Error in mae (line 51)
  perf = nnet7.performance_fcn(mfilename,net,varargin{:}); return

Error in script2 (line 10)
mae(y_hat,y)
```

As can be seen, this `mae` function can not be applied to `dlarray`, or rather, there is not an `mae` method for `dlarray`-class array to overload `mae` function.



Seemingly there is no something like half MAE







<br>

**References**

[^1]: [Mean squared error - Wikipedia](https://en.wikipedia.org/wiki/Mean_squared_error).
[^2]: [MATLAB Deep Learning Toolbox > unction Approximation and Nonlinear Regression > `mse`: Mean squared normalized error performance function - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/mse.html).
[^3]: [MATLAB Deep Learning Toolbox > custom Training Loops > `mse`: Half mean squared error - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/dlarray.mse.html).
[^4]: [Mean Squared Error (MSE) formula for data points in higher dimensions - Cross Validated](https://stats.stackexchange.com/questions/612727/mean-squared-error-mse-formula-for-data-points-in-higher-dimensions).
[^5]: [Array Size of MATLAB `dlarray` - What a starry night~](https://helloworld-1017.github.io/2024-03-25/19-29-31.html).
[^6]: [Mean absolute error - Wikipedia](https://en.wikipedia.org/wiki/Mean_absolute_error).
[^7]: Qi, Jun, et al. "On mean absolute error for deep neural network based vector-to-vector regression." *IEEE Signal Processing Letters* 27 (2020): 1485-1489, available at: [[2008.07281] On Mean Absolute Error for Deep Neural Network Based Vector-to-Vector Regression](https://arxiv.org/abs/2008.07281).
[^8]: [MATLAB Deep Learning Toolbox `mae`: Mean absolute error performance function - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/mae.html).



[3] [Define Custom Regression Output Layer - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/define-custom-regression-output-layer.html).







