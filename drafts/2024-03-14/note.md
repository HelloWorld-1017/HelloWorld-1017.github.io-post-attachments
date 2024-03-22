---

draft_at: 2024-03-15 17:16:45 +0800

---

# Introduction



In MATLAB, 
$$
\text{MSE}=\dfrac1n\sum_{i=1}^n(\hat{\boldsymbol{y}}_i-\boldsymbol{y}_i)^2
$$
if $\boldsymbol{y}$ is a $k$-dimensional vector, then it can be written as pointwise form:
$$
\text{MSE}=\dfrac1n\sum_{i=1}^n\sum_{j=1}^k(\hat{y}_{ij}-y_{ij})
$$
For example, we could verify this point on three 7-dimensional vectors:

<div ref="script-1"></div>

```matlab
clc,clear,close all
rng("default")

y = rand(3,7);
y_hat = rand(3,7);

disp( mse(y_hat,y) )
disp( sum( (y_hat-y).^2,"all" )/numel(y) )
```

```
0.2465
0.2465
```

However, as for loss value calculation in training regression neural networks, the input values, both predictions and targets, are `dlarray` data type. And in this case, `mse` function is to calculate **half MSE**, i.e.,
$$
\text{half MSE}=\dfrac1{2k}\sum_{i=1}^n(\hat{\boldsymbol{y}}_i-\boldsymbol{y}_i)^2
$$

```matlab
clc,clear,close all
rng("default")

y = rand(3,7);
y_hat = rand(3,7);

y = dlarray(y,"CB");
y_hat = dlarray(y_hat,"CB");

disp( mse(y_hat,y) )
disp( sum( (y_hat-y).^2,"all" )/width(y)/2 )
```



```matlab
clc,clear,close all
rng("default")

y = rand(3,7);
y_hat = rand(3,7);

y = dlarray(y,"BC");
y_hat = dlarray(y_hat,"BC");

size(y,1)

disp( mse(y_hat,y) )
disp( sum( (y_hat-y).^2,"all" )/size(y,2)/2 )
```

```
  1×1 dlarray
    0.8626
  1(C) × 1(B) dlarray
    0.8626
```









if is a is matrix, then we must specify batch form









<br>

**References**

[1] [Mean squared error - Wikipedia](https://en.wikipedia.org/wiki/Mean_squared_error).

[2] [MATLAB `mse`: Half mean squared error - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/dlarray.mse.html).

[3] [MATLAB `mse`: Mean squared normalized error performance function - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/mse.html).



[2] [MATLAB `mae`: Mean absolute error performance function - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/mae.html).





