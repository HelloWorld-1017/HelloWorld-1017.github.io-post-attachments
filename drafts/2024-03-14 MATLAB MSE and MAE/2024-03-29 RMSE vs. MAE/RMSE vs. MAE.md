---
title: RMSE vs. MAE
drafted_at: 2024-03-29 15:08:22 +0800
---

From MSE, definition of **Root Mean Square Error (RMSE)** can be easily obtained:
$$
\text{RMSE} = \sqrt{\text{MSE}} = \sqrt{\dfrac1N\sum_{i=1}^N
(\boldsymbol{Y}_i-\hat{\boldsymbol{Y}}_i)^T
(\boldsymbol{Y}_i-\hat{\boldsymbol{Y}}_i)}
$$
It should be noted that[^6], **MAE is not identical to RMSE**, and "*MAE is the average absolute difference between X and Y. Furthermore, each error contributes to MAE in proportion to the absolute value of the error. This is in contrast to RMSE which involves squaring the differences, so that a few large differences will increase the RMSE to a **greater degree** than the MAE.*"

Some researchers have recommended the use of the MAE instead of the RMSE. **MAE possesses advantages in interpretability over RMSE.** MAE is the average of the absolute values of the errors. **MAE is fundamentally easier to understand than the square root of the average of squared errors.** Furthermore, each error influences MAE in direct proportion to the absolute value of the error, which is not the case for RMSE [^9][^10].

<br>

**References**

[^9]: [Root-mean-square deviation - Wikipedia](https://en.wikipedia.org/wiki/Root-mean-square_deviation).
[^10]: Pontius, Robert Gilmore, Olufunmilayo Thontteh, and Hao Chen. "Components of information for multiple resolution comparison between maps that share a real variable." *Environmental and ecological statistics* 15 (2008): 111-142, available at: [Components of information for multiple resolution comparison between maps that share a real variable - Environmental and Ecological Statistics](https://link.springer.com/article/10.1007/s10651-007-0043-y), or [Components of information for multiple resolution comparison between maps that share a real variable](https://commons.clarku.edu/cgi/viewcontent.cgi?params=/context/faculty_geography/article/1769/&path_info=GeogFacWorks_Pontius_Components_2006.pdf).