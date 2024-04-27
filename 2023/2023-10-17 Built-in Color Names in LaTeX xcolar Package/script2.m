clc,clear,close all

colorTable = readtable("xcolors.csv");
colorStruct = table2struct(colorTable);
colors = struct();

for i = 1:height(colorStruct)
    colors(i).colorName = colorStruct(i).color;
    RGBtuple1 = [colorStruct(i).r,colorStruct(i).g,colorStruct(i).b];
    RGBtuple2 = round(RGBtuple1*255);
    RGBHEX = sprintf("%s%s","#",string(dec2hex(RGBtuple2,2))');
    colors(i).RGBtuple1 = {RGBtuple1};
    colors(i).RGBtuple2 = {RGBtuple2};
    colors(i).RGBHex = {RGBHEX};
end
disp(struct2table(colors))
