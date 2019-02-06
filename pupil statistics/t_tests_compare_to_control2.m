% This script performs multiple t tests compring each time point specified vs a
% control time point as defined in controlrow. The results are then
% bonferroni corrected to protect against erroneous findings of
% significance. To use this script, select the *_whole.mat file
% corresponding to the response type when prompted. The corrected results
% will be printed in column 4. 

clear
[FileName,PathName] = uigetfile('.mat');
cd(PathName);
load(FileName);

%start t tests
%define the control value below
control = nanmean(percentkeeper(1:50, :), 1);
startrow = 51;

p = 1

for test = 1:400;
    if p > 0.05/test
        [h, p, ci, stats] = ttest(control, percentkeeper(startrow, :));
        startrow = startrow + 1;
    else disp(startrow-1);
        break
    end
end