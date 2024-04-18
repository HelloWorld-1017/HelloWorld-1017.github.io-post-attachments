---
layout: single
categories:
tags:
drafted_at: 2024-04-09 10:32:49 +0800
date: 
last_modified_at0: 
last_modified_at: 
---















```
Error using ClassificationSVM.prepareData
Use fitcecoc to train a linear model with more than 2 classes.

Error in classreg.learning.FitTemplate/fit (line 246)
                    this.PrepareData(X,Y,this.BaseFitObjectArgs{:});

Error in ClassificationSVM.fit (line 243)
            this = fit(temp,X,Y);

Error in fitcsvm (line 342)
    obj = ClassificationSVM.fit(X,Y,RemainingArgs{:});

Error in script1 (line 15)
fitcsvm(XTrain,YTrain)
```







<br>

# References

[MATLAB `fitcsvm`: Train support vector machine (SVM) classifier for one-class and binary classification: Find Multiple Class Boundaries Using Binary SVM - MathWorks](https://ww2.mathworks.cn/help/stats/fitcsvm.html#bt9ce5p-1).

[MATLAB fitcecoc: Fit multiclass models for support vector machines or other classifiers -  - MathWorks China](https://ww2.mathworks.cn/help/stats/fitcecoc.html#bugo0kq-1).

