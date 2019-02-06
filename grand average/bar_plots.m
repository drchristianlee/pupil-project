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
    if subject == 1;
        average_compiler = holdercells{1,1};
    else
        average_compiler = vertcat(average_compiler, holdercells{1, subject});
    end
end

barkeeper(1,1) = mean(average_compiler(1, :));
barkeeper(1,2) = mean(average_compiler(2, :));
barkeeper(1,3) = mean(average_compiler(3, :));
barkeeper(1,4) = mean(average_compiler(4, :));
barkeeper(2,1) = std(average_compiler(1, :))/(sqrt(size(average_compiler, 2)));
barkeeper(2,2) = std(average_compiler(2, :))/(sqrt(size(average_compiler, 2)));
barkeeper(2,3) = std(average_compiler(3, :))/(sqrt(size(average_compiler, 2)));
barkeeper(2,4) = std(average_compiler(4, :))/(sqrt(size(average_compiler, 2)));

figure
bar(barkeeper(1,:), 'b', 'BaseValue', 0);
hold on;
errorbar(barkeeper(1,:), barkeeper(2,:), '.', 'color', 'k', 'marker', 'none');
hold on;

for points = 1:size(average_compiler, 1);
    plot(points, average_compiler(points, 1:6), 'o' ,'color' , 'green', 'MarkerFaceColor', 'green')
    hold on
end

 axis([0 5 0 35])
 set(gca,'TickDir','out')
 set(gca, 'box', 'off')
 set(gcf,'position',[680 558 320 210])
 set(gca, 'TickLength', [0.025 0.025]);
 set(gca,'FontSize',9);
 
 statistics_keeper = average_compiler';