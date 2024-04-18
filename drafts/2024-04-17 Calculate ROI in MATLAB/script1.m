clc,clear,close all

QQQ = readtable("QQQ-20240417.csv","VariableNamingRule","preserve");
SPY = readtable("SPY-20240417.csv","VariableNamingRule","preserve");

dateSPY = flipud(datetime(cell2mat(SPY.Date),"Format","MM/dd/yyyy"));
dateQQQ = flipud(datetime(cell2mat(QQQ.Date),"Format","MM/dd/yyyy"));
closeSPY = flipud(SPY.("Close/Last"));
closeQQQ = flipud(QQQ.("Close/Last"));

clear QQQ SPY

figure("Color","w")
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
yyaxis left
plot(dateQQQ,closeQQQ)
yyaxis right
plot(dateSPY,closeSPY)
xtickformat("yyyy")