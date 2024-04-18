clc,clear,close all

SPY = readtable("SPY-20240417.csv","VariableNamingRule","preserve");
dateSPY = flipud(datetime(cell2mat(SPY.Date),"Format","MM/dd/yyyy"));
dateSPY = datetime(dateSPY,"Format","yyyy-MM-dd");
closeSPY = flipud(SPY.("Close/Last"));
SPYY = table2timetable(table(dateSPY,closeSPY));


maxdrawdown(closeSPY)


QQQ = readtable("QQQ-20240417.csv","VariableNamingRule","preserve");
dateQQQ = flipud(datetime(cell2mat(QQQ.Date),"Format","MM/dd/yyyy"));
dateQQQ = datetime(dateQQQ,"Format","yyyy-MM-dd");
closeQQQ = flipud(QQQ.("Close/Last"));

maxdrawdown(closeQQQ)



% 
% clear QQQ
% 
% 
% datedate = datetime(2014,4:124,23)';
% dateWeek = weekday(datedate);
% idx = datenum(datedate)>datenum(dateQQQ(end));
% datedate(idx) = [];
% dateWeek(idx) = [];
% 
% idx = dateWeek == 6;
% sum(idx)
% 
% idx = dateWeek == 7;
% sum(idx)
% 
% for i = 1:1
%     dateInvesting = datedate(i);
%     idx = find(dateInvesting==dateQQQ);
% end
% 
% 
% 
% 
% 
% 
% % 
% % startDay = "2014-04-23";
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % idx = find(dateQQQ==startDay);
% % holdings = 1000/closeQQQ(idx);
% 
% % for i =1:4
% %     investingDay = dateQQQ(idx)+calmonths(1);
% %     idx = find(investingDay==dateQQQ)
% %     while ~isempty(idx)
% %         a = 2
% %     end
%     % if ~isempty(idx)
%     %     holdings = holdings+1000/closeQQQ(idx);
%     % else
%     %     w
%     % end
% % end
% 
% 
% 
% 
% 
% 
% 
% % 
% 
% 
% 
% 
% 
