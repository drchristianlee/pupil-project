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

% test_point = 196;

start = 1;


%compile data for comparison

for mouse = 1:count/2;
    for number = 1:2;
        test_keeper(mouse, 1) = holdercells{1, start};
        test_keeper(mouse, 2) = holdercells{1 , start+ 1};
    end
    start = start + 2;
end

[h, p, ci, stats] = ttest(test_keeper(:, 1), test_keeper(:, 2))

barkeeper(1,1) = mean(test_keeper(:,1));
barkeeper(1,2) = mean(test_keeper(:, 2));
barkeeper(2,1) = std(test_keeper(:, 1))/(sqrt(size(test_keeper, 1)));
barkeeper(2,2) = std(test_keeper(:,2))/(sqrt(size(test_keeper, 1)));

figure
bar(barkeeper(1,:), 'b');
hold on;
errorbar(barkeeper(1,:), barkeeper(2,:), '.', 'color', 'k', 'marker', 'none');
hold on;

for points = 1:size(test_keeper, 1);
    plot(test_keeper(points, 1:2) , '-o', 'color' , 'green', 'MarkerFaceColor', 'green')
    hold on
end

%  axis([0 3 0 25])
 set(gca,'TickDir','out')
 set(gca, 'box', 'off')
 set(gcf,'position',[680 558 230 420])