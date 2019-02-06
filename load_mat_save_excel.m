clear; 
[filename, pathname] = uigetfile('*.mat');
cd(pathname);
load(filename);
excelfilename = filename(1:end-4);
xlswrite(excelfilename, decision_log);