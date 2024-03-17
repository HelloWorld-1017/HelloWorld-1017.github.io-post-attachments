clc,clear,close all

colorTable = readtable("xcolors.csv");
colorStruct = table2struct(colorTable);
colors = struct();

numPerFig = 36;
vertSpace = 20;
colorBoxPositions = repmat([0,0,70,15],numPerFig,1)-[zeros(numPerFig,1),vertSpace*(1:numPerFig)',zeros(numPerFig,1),zeros(numPerFig,1)];
textxPosition_color1 = 100;
textxPosition_color2 = textxPosition_color1+170;
textxPosition_color3 = textxPosition_color2+170;
textxPosition_color4 = textxPosition_color3+170;

FontSize = 12;
FontName = "Helvetiva";
pic_idx = 0;
for idx = 1:height(colorStruct)
    i = mod(idx-1,numPerFig)+1;
    if i == 1
        figure("Color","w","Position",[682,42,902,953])
        hold(gca,"on")
        set(gca,"FontName","Times New Roman","DataAspectRatio",[1,1,1])
        pic_idx = pic_idx+1;
    end

    colorName = colorStruct(idx).color;
    RGBtuple1 = [colorStruct(idx).r,colorStruct(idx).g,colorStruct(idx).b];
    RGBtuple2 = round(RGBtuple1*255);
    RGBHEX = sprintf("%s%s","#",string(dec2hex(RGBtuple2,2))');
    colors(idx).colorName = colorName;
    colors(idx).RGBtuple1 = {RGBtuple1};
    colors(idx).RGBtuple2 = {RGBtuple2};
    colors(idx).RGBHex = {RGBHEX};

    r = rectangle("Position",colorBoxPositions(i,:), ...
        "FaceColor",RGBtuple1,"Curvature",0.5,"LineWidth",1.2);

    textyPosition = r.Position(2)+r.Position(4)/2;
    text(textxPosition_color1,textyPosition, ...
        colorName,"FontSize",FontSize,"FontName",FontName)
    text(textxPosition_color2,textyPosition, ...
        sprintf("(%.3f %.3f %.3f)",RGBtuple1), ...
        "FontSize",FontSize,"FontName",FontName)
    text(textxPosition_color3,textyPosition, ...
        sprintf("(%-3d %-3d %-3d)",RGBtuple2), ...
        "FontSize",FontSize,"FontName",FontName)
    text(textxPosition_color4,textyPosition, ...
        sprintf("%s",RGBHEX), ...
        "FontSize",FontSize,"FontName",FontName)
    xlim([-10,600])
    axis(gca,"off")

    if i == numPerFig
        exportgraphics(gca,sprintf("pic_%d.jpg",pic_idx),"Resolution",600)
    end
end

disp(struct2table(colors))
