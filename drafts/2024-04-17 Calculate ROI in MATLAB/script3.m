clc,clear,close all

SPY = readtable("SPY-20240417.csv","VariableNamingRule","preserve");
dateSPY = flipud(datetime(cell2mat(SPY.Date),"Format","MM/dd/yyyy","TimeZone","UTC"));
dateSPY = datetime(dateSPY,"Format","yyyy-MM-dd","TimeZone","UTC");
closeSPY = flipud(SPY.("Close/Last"));
SPYY = table2timetable(table(dateSPY,closeSPY));

startDay = dateSPY(1);
endingDay = dateSPY(end);

elapesdHDays = (endingDay-startDay)/hours(24);

Dates = datetime(2014,4,17:17+elapesdHDays,"TimeZone","UTC")';
Years = Dates.Year;
Months = Dates.Month;
Days = Dates.Day;
WeekDay = weekday(Dates);

ClosePrice = nan(height(Dates),1);
for i = 1:height(Dates)
    idx = find(Dates(i) == dateSPY);
    if ~isempty(idx)
        ClosePrice(i) = closeSPY(idx);
    end
end
EverydayPrice = fillmissing(ClosePrice,"previous");
EveryDayReturn = diff(EverydayPrice)./EverydayPrice(1:end-1)*100;
EveryDayReturn = [nan;EveryDayReturn];

ALLInvestingMoney = nan(height(Dates),1);
InvestingMoney = nan(height(Dates),1);
BuyShares = nan(height(Dates),1);
HoldingShares = nan(height(Dates),1);
HoldingMoney = nan(height(Dates),1);
RateEver = nan(height(Dates),1);

SPYTable = table(Dates,Years,Months,Days,WeekDay,ClosePrice,EverydayPrice,EveryDayReturn, ...
    InvestingMoney,BuyShares,ALLInvestingMoney,HoldingShares,HoldingMoney,RateEver);
% clearvars -except SPYTable

investingDate = 23;
investingMoney = 1000;

OriginalInvestingDate = find(SPYTable.Days==investingDate);

priceOfOriginalInvestingDate = SPYTable.ClosePrice(OriginalInvestingDate);

ActualInvestingDate = helperFindAndSkip(priceOfOriginalInvestingDate,OriginalInvestingDate,SPYTable.ClosePrice);

for i = 1:height(ActualInvestingDate)
    idx = ActualInvestingDate(i);
    SPYTable.InvestingMoney(idx) = investingMoney;
    SPYTable.ALLInvestingMoney(idx) = sum(SPYTable.InvestingMoney,"omitmissing");
    SPYTable.BuyShares(idx) = 1e3/SPYTable.ClosePrice(idx);
    SPYTable.HoldingShares(idx+1) = sum(SPYTable.BuyShares,"omitmissing");
    SPYTable.HoldingMoney(idx+1) = SPYTable.HoldingShares(idx+1)*SPYTable.ClosePrice(idx);
    SPYTable.RateEver(idx+1) = (SPYTable.HoldingMoney(idx+1)-SPYTable.ALLInvestingMoney(idx))/SPYTable.ALLInvestingMoney(idx)*100;
end

SPYTable.ALLInvestingMoney = fillmissing(SPYTable.ALLInvestingMoney,"previous");
SPYTable.HoldingShares = fillmissing(SPYTable.HoldingShares,"previous");
SPYTable.HoldingMoney = SPYTable.ClosePrice.*SPYTable.HoldingShares;
SPYTable.HoldingMoney = fillmissing(SPYTable.HoldingMoney,"previous");
SPYTable.RateEver = (SPYTable.HoldingMoney-SPYTable.ALLInvestingMoney)./SPYTable.ALLInvestingMoney*100;

figure("Color","w")
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
yyaxis left
plot(SPYTable.Dates,SPYTable.ClosePrice)
yyaxis right
plot(SPYTable.Dates,SPYTable.RateEver);


function ChangedInvestingDate = ...
    helperFindAndSkip(priceOfOriginalInvestingDate,OriginalInvestingDate,ClosePrice)

ChangedInvestingDate = OriginalInvestingDate;
while sum(isnan(priceOfOriginalInvestingDate))
    sum(isnan(priceOfOriginalInvestingDate))
    idx = find(isnan(priceOfOriginalInvestingDate));
    ChangedInvestingDate(idx,1) = ChangedInvestingDate(idx)+1;
    priceOfOriginalInvestingDate = ClosePrice(ChangedInvestingDate);
end
end

