clc,clear,close all

for i = ["_data" "_includes" "_layouts" "_pages" "_sass" "assets"]
    rootPath = fullfile(pwd,i);
    fprintf("=======%s=======\n",i)
    helperMain(rootPath)
end

function helperMain(rootPath)
files = string; %#ok
folders = string;
allFolders = string;

% Collect file name and corresponding folder name
helperFind(rootPath);

% Post-process for `folders` and `files`
folders(1)  = [];
files(1) = [];
allFolders(1) = [];

folders = replace(folders,pwd,".");
allFolders = replace(allFolders,pwd,".");

folderNames = sort(unique(folders),"ascend");
allFolderNames = sort(unique(allFolders),"ascend");

onlyHaveSubFolders = allFolderNames(~arrayfun(@(x) sum(x==folderNames),allFolderNames));

sizeFolderNames = arrayfun(@(x) numel(string(regexp(x,"\","split"))), folderNames);

for jj = 1:height(sizeFolderNames)
    subFolders(jj,1:sizeFolderNames(jj)) = string(regexp(folderNames(jj,1),"\","split")); %#ok
end

% Print file tree
for jj = 1:numel(folderNames)
    idx = folders == folderNames(jj,1); %#ok
    subfolders = rmmissing(subFolders(jj,:));
    numLevel = numel(subfolders)-2;
    if sum(string(strjoin(subfolders(1:end-1),"\")) == onlyHaveSubFolders)
        eval(strcat('fprintf("%',num2str(8*(numLevel-1)),'s%s%s\n","",filesep,subfolders(end-1))'));
        onlyHaveSubFolders(onlyHaveSubFolders == string(strjoin(subfolders(1:end-1),"\"))) = [];
    end
    eval(strcat('fprintf("%',num2str(8*(numLevel)),'s%s%s\n","",filesep,subfolders(end))'));
    eval(strcat('arrayfun(@(x) fprintf("%',num2str(8*(numLevel+1)),'s%s\n","",x), files(idx));'))
end

% Find files recursively
    function helperFind(PATH)
        roots = dir(PATH);
        for i = 3:numel(roots)
            if roots(i).isdir
                allFolders(end+1,1) = roots(i).folder; %#ok
                helperFind(fullfile(roots(i).folder,roots(i).name));
            else
                allFolders(end+1,1) = roots(i).folder; %#ok
                folders(end+1,1) = roots(i).folder; %#ok
                files(end+1,1) = roots(i).name; %#ok
            end
        end
    end
end