% This script performs multiple t tests compring each time point specified vs a
% control time point as defined in controlrow. The results are then
% bonferroni corrected to protect against erroneous findings of
% significance. To use this script, select the *_whole.mat file
% corresponding to the response type when prompted. The corrected results
% will be printed in column 4. 
clear;

folder = uigetdir;
cd(folder);
filePattern = fullfile(folder, '*.mat');
matfiles = dir(filePattern);
count = length(matfiles);
keepercol = 1;
for f = 1:count;
    B = matfiles(f, 1).name;
    currkeeper = load(B);
    name = char(fieldnames(currkeeper));
    holdercells(1, f) = {currkeeper.(name)};
end

start = 1;
test_holder = NaN(500, 6);
for holder_num = 1: (size(holdercells, 2) - 1);
test_holder(1:size(holdercells{1, start}, 1), holder_num) = holdercells{1, start}(:, 4);
start = start + 1;
end

%start t tests
%define the control value below
control = test_holder(51, :);


row = 52;

p = 1;

for test = 1:400;
    if p > 0.01/test
        test_row = test_holder(row, :);
        [h, p, ci, stats] = ttest(control, test_row);
        row = row + 1;
    else disp(row-1);
        break
    end
end



