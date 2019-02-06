%use this script to normalize pupil data 

clear; 
[filename, pathname] = uigetfile('*.mat');
cd(pathname);
load(filename);



plotkeeper = diamKeeper;
normvalue = nanmean(plotkeeper(1:50, :), 1);
normvalue = repmat(normvalue, size(plotkeeper, 1), 1);
change_keeper = plotkeeper - normvalue;
percentkeeper = rdivide(change_keeper, normvalue);
percentkeeper = percentkeeper*100;


for plot_num = 1:size(percentkeeper, 2)
    figure
    plot(percentkeeper(:, plot_num));
end

