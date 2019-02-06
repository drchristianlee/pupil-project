%use this script to view the average plots of the mat files in the grouped
%folders such as Gos, NoGos, FAs, Misses. This can be helpful in seeing
%if there are any outlier plots within the folder such as might be the case
%if misses were actually Gos that were not tripping the lick sensor. It is
%best to copy the .mat files to a new folder without the average file
%before running.

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
%calculate nanmean
for x = 1:count;
    avgkeeper = cell2mat(holdercells(1, x));
    average = nanmean(avgkeeper, 2);
    holdercells(2, x) = {average};
end
figure
for num = 1:count;
    plot(holdercells{2, num})
    hold on
end