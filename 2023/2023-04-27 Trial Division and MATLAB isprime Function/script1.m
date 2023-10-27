clc,clear,close all

folderInfo = dir(pwd);
pat = digitsPattern(4)+"."+digitsPattern(2)+"."+digitsPattern(2);

for i = 3:numel(folderInfo)
    oldDate = extract(folderInfo(i).name,pat);
    if ~isempty(oldDate)
        oldDate = oldDate{1};
        newName = replace(folderInfo(i).name,oldDate,sprintf("%s-%s-%s",oldDate(1:4),oldDate(6:7),oldDate(9:10)));
        eval(['!rename', ' "', folderInfo(i).name, '" "', newName, '"']);
    end
end

