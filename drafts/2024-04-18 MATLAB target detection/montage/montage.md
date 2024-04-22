---
layout: single
title: 
categories:
 - MATLAB
tags:
 - MATLAB Image Processing and Computer Vision
 - MATLAB Image Processing Toolbox
 - MATLAB Data Import and Analysis
 - Medical Imaging Toolbox
drafted_at: 2024-04-19 01:34:06 +0800
date:
last_modified_at0:
last_modified_at:
---

# MATLAB `montage` function



<br>

## Create montage from multi-frame image (3-D array)

```matlab
clc,clear,close all

% Load an MRI dataset
load mristack

% Display the dataset
% `montage` treats the data as a multiframe image and displays each slice
figure("Color","w")
img = montage(mristack);
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404190137578.png" alt="image-20240419013707480" style="zoom:50%;" />

Code `load mristack` is used to load an MRI (Magnetic Resonance Imaging) dataset, which only includes a 3-D `uint8`-class array `mristack` storing the pixel data of 21 gray images:

```
>> whos mristack
  Name            Size                  Bytes  Class    Attributes
  mristack      256x256x21            1376256  uint8              
```

and `img` is a `Image`-class variable:

```
>> whos img
  Name      Size            Bytes  Class                              Attributes
  img       1x1                 8  matlab.graphics.primitive.Image            
```

We can specify the number of images to be displayed, like showing the first seven images:

```matlab
clc,clear,close all

% Load an MRI dataset
load mristack

% Display the first seven images
figure("Color","w")
img = montage(mristack,"Indices",1:7);
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404190151991.png" alt="image-20240419015107679" style="zoom: 50%;" />

## Create Montage Containing Images of Different Types and Sizes





<div id="script-1"></div>

```matlab
clc,clear,close all

% Read several images of different types and sizes into the workspace.
imRGB = imread("peppers.png");
imGray = imread("coins.png");

% Display a montage containing all of the images
figure("Color","w")
img = montage({imRGB,imGray,"cameraman.tif"});
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404190203172.png" alt="image-20240419020307894" style="zoom:50%;" />

where

```
>> whos
  Name          Size                Bytes  Class                              Attributes
  imGray      246x300               73800  uint8                                     
  imRGB       384x512x3            589824  uint8                                     
  img           1x1                     8  matlab.graphics.primitive.Image           
```

As can be seen, `imGray` is a 2-D array representing a gray image, while `imRGB` is a 3-D array representing an RGB image. And if we read `"cameraman.tif"` into the workspace, we could find it is also a gray array, but whose size is different from `"coins.png"`:

```
>> imGray2 = imread("cameraman.tif");
>> whos imGray2
  Name           Size             Bytes  Class    Attributes
  imGray2      256x256            65536  uint8              
```

In this case, we can have a look at what do properties `"BackgroundColor"` (default value is `"black"`) and `"BorderSize"` (default value is `[0 0]`) determine:

```matlab
clc,clear,close all

% Read several images of different types and sizes into the workspace.
imRGB = imread("peppers.png");
imGray = imread("coins.png");

% Display a montage containing all of the images
figure("Color","w")
img = montage({imRGB,imGray,"cameraman.tif"}, ...
    "BackgroundColor","b","BorderSize",[200,100]);
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404190248584.png" alt="image-20240419024811391" style="zoom:50%;" />

## Create montage from several image files

Actually, all of three images in [Script 1](#script-1), `peppers.png`, `coins.png`, and `cameraman.tif`, are in the MATLAB default searching path, so it's okay if we use `montage` in the following way:

```matlab
clc,clear,close all

% Display a montage containing all of the images
figure("Color","w")
img = montage({'peppers.png','coins.png','cameraman.tif'});
```

At this point, it is also an example showing how to create montage from image files. 

The official documentation provides a more detailed example to show this way. Besides, it also show the function of `"Size"` property and `"DisplayRange"` property:

```matlab
clc,clear,close all

% Create a string array containing a series of file names
fileFolder = fullfile(matlabroot,"toolbox","images","imdata");
dirOutput = dir(fullfile(fileFolder,"AT3_1m4_*.tif"));
fileNames = string({dirOutput.name});

% Display the images as a rectangular montage
% Specify the shape of the montage as a 2-by-5 rectangle.
fig1 = figure("Color","w");
montage(fileNames,"Size",[2,5]);
title("Specify the shape of the montage as a 2-by-5 rectangle")

% Adjust the contrast of the images in the montage (ONLY functional for gray images)
fig2 = figure("Color","w");
montage(fileNames,"Size",[2,5],"DisplayRange",[75,200]);
title("Adjust the contrast of the images in the montage")
```

The first montage is:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404190314079.png" alt="image-20240419031443577" style="zoom:50%;" />

and the second one is:

![image-20240419031504971](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404190315260.png)

And `fileNames` is a `1×10 string array`:

```
>> fileNames
fileNames = 
  1×10 string array
    "AT3_1m4_01.tif"    "AT3_1m4_02.tif"    "AT3_1m4_03.tif"    "AT3_1m4_04.tif"    "AT3_1m4_05.tif"    "AT3_1m4_06.tif"    "AT3_1m4_07.tif"    "AT3_1m4_08.tif"    "AT3_1m4_09.tif"    "AT3_1m4_10.tif"
```

NOTE that, as described in the official documentation, `"DisplayRange"` is to "*Display range of grayscale images in array `I`, specified as 1-by-2 vector of the form `[low high]`. All pixel values less than or equal to `low` display as black. All pixel values greater than or equal to `high` display as white. If you specify an empty matrix (`[]`), then `montage` uses the minimum and maximum pixel values of the images.*" So, this property is ONLY functional when showing gray images. If some images in the montage is colorful, the software will throw a waring, "Warning: Montage image is a color image. DisplayRange parameter will be ignored. ".

## Create montage from image datastore

`mongtage` function is also available for `ImageDatastore` object, for example:

```matlab
clc,clear,close all

% Create an ImageDatastore object containing a series of ten images from 
% the Image Processing Toolbox™ sample image folder.
fileFolder = fullfile(matlabroot,"toolbox","images","imdata");
imds = imageDatastore(fullfile(fileFolder,"AT3*"));

% Display the contents of the datastore as a montage
figure("Color","w")
montage(imds)
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404190348761.png" alt="image-20240419034823309" style="zoom:50%;" />

where

```
>> whos
  Name            Size            Bytes  Class                                 Attributes
  fileFolder      1x1               246  string                                       
  imds            1x1                 8  matlab.io.datastore.ImageDatastore           
```

`imageDatastore` function is listed in the "MATLAB Data Import and Analysis" part, and used to "manage a collection of image files, where each individual image fits in memory, but the entire collection of images does not necessarily fit."[^2] 

It frequently appears in the workflow of MATLAB deep learning related to images. Therefore, this feature of `imageDatastore` function makes it convenient to show the images managed by `imageDatastore` object, like in the target detection example "Object Detection Using YOLO v3 Deep Learning"[^3].

<br>

# Something else ......

Previously, in my mind, the word "montage" is something just about art, so when I first saw this function in MATLAB, I felt its name is vivid and may be a little romantic. But today I look up the on-line Longman dictionary[^4], and find that it’s probably not an exclusive noun for art, and may resemble the word "collection" or "set", but "montage" highlights that the elements (pictures, film, or music) are combined (or rather, organized) in an interesting and unusual way:

![image-20240419044633720](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404190446866.png)

Not so serious. Having said that, I still watch some on-line contents, which introduce montage from the point of view of art, like the video, "Top 10 Best Montages of All Time", from YouTube channel "CineFix - IGN Movies and TV"[^5]: 

<iframe width="560" height="315" src="https://www.youtube.com/embed/DhQHlCaSR_w?si=XeM-Yeh4JTQGQbgy" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

 <br>

As a comparison, a long dialog scenes in “Before Sunset” 



[Are the long takes in 'Before Sunset' mostly green screen? : r/movies](https://www.reddit.com/r/movies/comments/asjlap/are_the_long_takes_in_before_sunset_mostly_green/)

[Richard Linklater's Before Sunset- Filmmaker Magazine - Spring 2004](https://filmmakermagazine.com/archives/issues/spring2004/features/paris_day.php)



<br>

# References

[^1]: [MATLAB `montage`: Display multiple image frames as rectangular montage - MathWorks](https://ww2.mathworks.cn/help/images/ref/montage.html).
[^2]: [MATLAB `imageDatastore`: Datastore for image data - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/matlab.io.datastore.imagedatastore.html).
[^3]: [Object Detection Using YOLO v3 Deep Learning - MathWorks](https://ww2.mathworks.cn/help/vision/ug/object-detection-using-yolo-v3-deep-learning.html).
[^4]: [montage \| meaning of montage in Longman Dictionary of Contemporary English \| LDOCE](https://www.ldoceonline.com/dictionary/montage).

[^5]: [Top 10 Best Montages of All Time - YouTube](https://www.youtube.com/watch?v=DhQHlCaSR_w).







































