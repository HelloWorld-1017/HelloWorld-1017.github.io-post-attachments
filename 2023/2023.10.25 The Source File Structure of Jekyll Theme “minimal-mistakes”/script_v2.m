clc,clear,close all

for i = ["_data", "_includes", "_layouts", "_pages", "_sass", "assets"]
    rootPath = fullfile(pwd,i);
    helperMain(rootPath)
end

function helperMain(rootPath)
files = string;
folders = string;

% Collect file name and corresponding folder name
helperFind(rootPath);

% Post-process for `folders` and `files` 
folders(1)  = [];
files(1) = [];

folders = replace(folders,pwd,".");

folderNames = sort(unique(folders),"ascend");
subFolders = struct();

for jj = 1:numel(folderNames)
    foldername = folderNames(jj,1);
    subfolders = string(regexp(foldername,"\","split"));
    subFolders.("s"+num2str(jj)) = subfolders;
end

% Print file tree
for jj = 1:numel(folderNames)
    idx = folders == folderNames(jj,1);
    subfolders = subFolders.("s"+num2str(jj));
    numLevel = numel(subfolders);
    if numLevel == 2
        fprintf("%s\n",folderNames(jj,1))
        arrayfun(@(x) fprintf("%8s%s\n","",x),files(idx));
    else
        if jj == 1
            fprintf(".\\%s\n",subfolders(2))
        end
        eval(strcat('fprintf("%',num2str(4*(numLevel-1)),'s%s%s\n","",filesep,subfolders(end))'));
        eval(strcat('arrayfun(@(x) fprintf("%',num2str(4*numLevel),'s%s\n","",x), files(idx));'))
    end
end

% Find files recursively
    function helperFind(PATH)
        roots = dir(PATH);
        for i = 3:numel(roots)
            if roots(i).isdir
                helperFind(fullfile(roots(i).folder,roots(i).name));
            else
                folders(end+1,1) = roots(i).folder; %#ok
                files(end+1,1) = roots(i).name; %#ok
            end
        end
    end
end