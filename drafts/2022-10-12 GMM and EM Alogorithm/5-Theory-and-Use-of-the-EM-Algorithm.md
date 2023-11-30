---
title: Theory and Use of the EM Algorithm
date: 2023-11-29 15:53:07 +0800
---

p254

... but sometimes it fails by approaching singularities of the log-likelihood function, especially when the number of observations $n$ is not large relative to the number of Gaussian components $k$. This is an inherent problem with applying maximum likelihood estimation to GMMs due to the fact that the log-likelihood function $\mathscr{l}(\theta)$ is not bounded above. ..., then the above lower bound of $\mathscr{l}(\theta)$ diverges to infinity, and thus $l(\theta)\rightarrow\infty$. So for a GMM, **maximizing the likelihood is actually an ill-posed problem**.

This problem most often arises in practice with EM when the number of components $k$ is too large compared to the number of observations $n$, but it can also occur if one sample is relatively far from the bulk of the other samples. In both cases, **a single Gaussian model becomes predominantly associated with one observation, and as the iterations progress, that Gaussian model shrinks its variance around that one single observation**. More generally, this problem can arise if the samples predominantly assigned to a component Gaussian do not span the space, so that the estimated covariance of that Gaussian is not of full rank.

<br>

**References**

[1] Gupta, Maya R., and Yihua Chen. "Theory and use of the EM algorithm." *Foundations and Trends in Signal Processing* 4.3 (2011): 223-296, available: [Theory and Use of the EM Algorithm](https://web.archive.org/web/20111206134802id_/http://www.ee.washington.edu/research/guptalab/publications/EMbookChenGupta2010.pdf).
