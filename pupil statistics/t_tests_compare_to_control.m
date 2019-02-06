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
endrow = 300;
number = (endrow - startrow)+1;

for row = 1:number;
    test_result(row, 1) = startrow;
    [test_result(row , 2) , test_result(row , 3)] = ttest(control , percentkeeper(startrow, :));
    startrow = startrow + 1;
end

%now apply bonferroni corection
criterion = 0.01 / number;

for result_number = 1:number;
    if test_result(result_number, 3) < criterion;
        test_result(result_number, 4) = 1;
    else  test_result(result_number, 4) = 0;
    end
end
    