clear;
folder = uigetdir;
cd(folder);
filePattern = fullfile(folder, '*.mat');
matfiles = dir(filePattern);
count = length(matfiles);

for f = 1:count;
    B = matfiles(f, 1).name;
    currkeeper = load(B);
    name = char(fieldnames(currkeeper));
    holdercells(1, f) = {currkeeper.(name)};
end

%now enter the time point to test

test_point = 196;

start = 1;


%compile data for comparison

for mouse = 1:count/2;
    for number = 1:2;
        test_keeper(mouse, 1) = holdercells{1, start}(test_point, 4);
        test_keeper(mouse, 2) = holdercells{1 , start+ 1}(test_point, 4);
    end
    start = start + 2;
end

[h, p, ci, stats] = ttest(test_keeper(:, 1), test_keeper(:, 2))