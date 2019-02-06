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
numvectors = size(holdercells);
for x = 1:numvectors(1, 2);
    normarray = cell2mat(holdercells(1, x));
    for row = 1:(length(normarray));
        normarray(row, 2) = (normarray(row, 1)/normarray(1, 1))*100;
        holdercells(1, x) = {normarray};
    end
end
plot(holdercells{1, 1}(:,1))
hold on
plot(holdercells{1, 2}(:,1))
hold on
plot(holdercells{1, 3}(:,1))
hold on
plot(holdercells{1, 4}(:,1))
hold on
figure
plot(holdercells{1, 1}(:,2))
hold on
plot(holdercells{1, 2}(:,2))
hold on
plot(holdercells{1, 3}(:,2))
hold on
plot(holdercells{1, 4}(:,2))
hold on