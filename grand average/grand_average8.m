%this script calculates the grand average from the output of behavior
%analysis 3. Place the .mat files of a given response type into a folder
%named with the response type, thus Gos, NoGos etc. On 9.12.2014 CL added
%calculation for sem into column 2 of grand average based on grand
%average_js_v1_0.m. This script additionally calculates the data as
%percentage of baseline. 

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

for subject = 1:size(holdercells, 2);
    for rows = 1:size(holdercells{1, subject}(:, 4), 1)
    average_compiler(rows, subject) = holdercells{1, subject}(rows, 4);
    end
end

%now convert zeros to NaNs in average_compiler

average_compiler(average_compiler == 0) = NaN;

%now calculate average
average(:,1) = nanmean(average_compiler, 2);
nanValues = isnan(average_compiler);
nanTrials_removed = size(average_compiler, 2) - sum(nanValues, 2);
average(:, 2) = nanstd(average_compiler, 0, 2) ./ sqrt(nanTrials_removed);

%now calculate time zero and peak values
plot(average_compiler);
time_zero = mean(average_compiler(152:153, :));
max_holder = average_compiler(1:325, :);
peak = max(max_holder);

name_parse = strsplit(folder, '\');
name = name_parse{1, end};
save(char(strcat(name, '_by_subject_average')), 'average');
save(char(strcat(name, '_by_subject_time_zero')), 'time_zero');
save(char(strcat(name, '_by_subject_peak')), 'peak');