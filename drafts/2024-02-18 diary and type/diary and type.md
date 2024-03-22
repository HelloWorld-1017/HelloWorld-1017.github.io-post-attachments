---
layout: single
title: Write Command Window Text to File and Read it in MATLAB
categories:
 - MATLAB
tags:
 - MATLAB Language Fundamentals
 - MATLAB Deep Learning Toolbox
date: 2024-02-xx xx:xx:xx +0800
last_modified_at0: 
last_modified_at:
---

# Introduction

In MATLAB, `diary` function can be used to log command window text to specified file [^1], and `type` function could display the recorded text in this file to the command window again. 

So, recording command window text, any contents including ==user commands, display information output by `disp` and `fprintf` functions==, and warning and error messages, in the file is very convenient in MATLAB. However, I didn’t use these two functions ever before, because I didn’t meet any scenario where they are necessary. 

But, recently there is a need to use them when I am trying to monitor training process of a neural network. In the following text, I will take an official example, “Resume Training from Checkpoint Network” [^3], to illustrate this kind of situation. 

In the example mentioned above [^3], a CNN is trained for a digits  multi-class classification task:

```matlab
clc,clear,close all

% Prepare training and test dataset
[XTrain,YTrain] = digitTrain4DArrayData;
[XTest,YTest] = digitTest4DArrayData;

% Define newtwork architecture
layers = [
    imageInputLayer([28,28,1])
    
    convolution2dLayer(3,8,"Padding","same")
    batchNormalizationLayer
    reluLayer    
    maxPooling2dLayer(2,"Stride",2) 
    
    convolution2dLayer(3,16,"Padding","same")
    batchNormalizationLayer
    reluLayer    
    maxPooling2dLayer(2,"Stride",2)
    
    convolution2dLayer(3,32,"Padding","same")
    batchNormalizationLayer
    reluLayer   
    averagePooling2dLayer(7)  
    
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];

% Specify training options
options = trainingOptions("sgdm", ...
    "InitialLearnRate",0.1, ...
    "MaxEpochs",20, ...
    "Verbose",false, ...
    "Plots","training-progress", ...
    "Shuffle","once", ...
    "ExecutionEnvironment","auto");

% Train the network
[net,info] = trainNetwork(XTrain,YTrain,layers,options);
```

In the above code, we use `trainingOptions` function to specify training options and then use `trainNetwork` to train the network. Because we set the property `"Plots"` of `trainingOptions` to `"training-progress"`, MATLAB will plot the training progress in real-time while training, and the final figure is like:

![image-20240218181325534](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202402181813110.png)

Definitely, this setting could help us to monitor how the training progresses graphically. However, it also:

- occupies more memory, may causing “out of memory” error if the training time is rather long,
- and slows the training progress, increasing training time==(as showed below)==.

I ever verified these two point in a long neural network training progress.
{: .notice--primary}

To solve these two problems, we could print training text message to the command window by specifying property `"Verbose"` to `"true"`, instead of plotting training curves (that is setting property `"Plots"` to `"none"`:

```matlab
...

...
```



虽然没有图像那么明显，但还是可以大致看出训练的变化趋势。



测试训练时间（指明这种方式是不太科学的，应该多次测试取平均值）



> `verboseFrequency`



```
> In nnet.internal.cnn/Trainer/train (line 92)
In nnet.internal.cnn.trainNetwork.doTrainNetwork (line 113)
In trainNetwork (line 182)
In script3_LSTM1 (line 46) 
Error using trainNetwork
Unexpected error calling cuDNN: CUDNN_STATUS_EXECUTION_FAILED.

Error in script3_LSTM1 (line 46)
[net,info] = trainNetwork(XTrain,labels,layers,options);
```



Besides, in order to see whether logging is on, type `get(0,'Diary')`. MATLAB returns either `'on'` or `'off'`. For example, after running Script 1, xxx







<br>

**References**

[^1]: [MATLAB `diary`: Log Command Window text to file - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/diary.html).
[^2]: [MATLAB `type`: Display contents of file - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/type.html).
[^3]: [Resume Training from Checkpoint Network - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/resume-training-from-a-checkpoint-network.html).





