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

keeper_early = holdercells{1, 1};
keeper_late = holdercells{1, 2};


[h, p, ci, stats] = ttest(keeper_early, keeper_late)

barkeeper(1,1) = mean(keeper_early(1, :));
barkeeper(1,2) = mean(keeper_late(1, :));
barkeeper(2,1) = std(keeper_early(1, :))/(sqrt(size(keeper_early(1, :), 2)));
barkeeper(2,2) = std(keeper_late(1, :))/(sqrt(size(keeper_late(1, :), 2)));

figure
bar(barkeeper(1,:), 'b');
hold on;
errorbar(barkeeper(1,:), barkeeper(2,:), '.', 'color', 'k', 'marker', 'none');
hold on;

plot_keeper = vertcat(keeper_early, keeper_late)';

for points = 1:size(plot_keeper, 1);
    plot(plot_keeper(points, 1:2) , '-o', 'color' , 'green', 'MarkerFaceColor', 'green')
    hold on
end

 axis([0 3 0 35])
 set(gca,'TickDir','out')
 set(gca, 'box', 'off')
 set(gcf,'position',[680 558 160 210])
 
 
 set(gca, 'TickLength', [0.025 0.025]);
 
 
 
 set(gca,'FontSize',9);
 
