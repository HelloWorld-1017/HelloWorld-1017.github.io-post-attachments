clc,clear,close all

f = waitbar(0,'1','Name','Approximating pi...',...
    'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');

setappdata(f,'canceling',0);

epochs = 2e3;
for i = 1:epochs
    % Check for clicked Cancel button
    if getappdata(f,'canceling')
        break
    end

    info = sprintf("%s ( %s/%s, %.2f%%)","Please wait...",num2str(i),num2str(epochs),i/epochs*100);
    waitbar(i/epochs,f, info)
    pause(0.1)
end
delete(f)
