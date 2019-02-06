%this script is used after creating average mat files. Copy and paste each average
%mat file into the same folder and then run this script to plot them on the
%same set of axes. 

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
plot (holdercells{1, 1});
hold on
plot(holdercells{1, 2});
hold on
plot(holdercells{1, 3});
hold on
plot(holdercells{1, 4});
hold on
