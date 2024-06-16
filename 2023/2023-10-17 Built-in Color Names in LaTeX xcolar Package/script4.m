% 2024-06-15 23:18:27 +0800
% Export color names and HEX values in CSS setting form
clc,clear,close all

colorTable = readtable("xcolors.csv");
colorStruct = table2struct(colorTable);
colors = "";

for idx = 1:height(colorStruct)
    colorName = colorStruct(idx).color;
    RGBtuple1 = [colorStruct(idx).r,colorStruct(idx).g,colorStruct(idx).b];
    RGBtuple2 = round(RGBtuple1*255);
    RGBHEX = sprintf("%s%s","#",string(dec2hex(RGBtuple2,2))');
    colors = colors+sprintf("$%s: %s;\n",colorName,RGBHEX);
end

fileID = fopen("xcolor.txt","w");
fprintf(fileID,colors);
fclose(fileID);