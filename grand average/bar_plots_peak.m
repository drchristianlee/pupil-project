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
barkeeper(1,5) = mean(average_compiler(5, :));
barkeeper(1,6) = mean(average_compiler(6, :));
barkeeper(1,7) = mean(average_compiler(7, :));
barkeeper(1,8) = mean(average_compiler(8, :));
barkeeper(2,1) = std(average_compiler(1, :))/(sqrt(size(average_compiler, 2)));
barkeeper(2,2) = std(average_compiler(2, :))/(sqrt(size(average_compiler, 2)));
barkeeper(2,3) = std(average_compiler(3, :))/(sqrt(size(average_compiler, 2)));
barkeeper(2,4) = std(average_compiler(4, :))/(sqrt(size(average_compiler, 2)));
barkeeper(2,5) = std(average_compiler(5, :))/(sqrt(size(average_compiler, 2)));
barkeeper(2,6) = std(average_compiler(6, :))/(sqrt(size(average_compiler, 2)));
barkeeper(2,7) = std(average_compiler(7, :))/(sqrt(size(average_compiler, 2)));
barkeeper(2,8) = std(average_compiler(8, :))/(sqrt(size(average_compiler, 2)));

figure
bar([barkeeper(1,1:2); barkeeper(1, 3:4); barkeeper(1, 5:6); barkeeper(1, 7:8)], 'b', 'BaseValue', 0);
hold all
errorbar(0.855, barkeeper(1,1), barkeeper(2,1), '.', 'color', 'k', 'marker', 'none');
hold all
errorbar(1.145, barkeeper(1,2), barkeeper(2,2), '.', 'color', 'k', 'marker', 'none');
hold all
errorbar(1.855, barkeeper(1,3), barkeeper(2,3), '.', 'color', 'k', 'marker', 'none');
hold all
errorbar(2.145, barkeeper(1,4), barkeeper(2,4), '.', 'color', 'k', 'marker', 'none');
hold all
errorbar(2.855, barkeeper(1,5), barkeeper(2,5), '.', 'color', 'k', 'marker', 'none');
hold all
errorbar(3.145, barkeeper(1,6), barkeeper(2,6), '.', 'color', 'k', 'marker', 'none');
hold all
errorbar(3.855, barkeeper(1,7), barkeeper(2,7), '.', 'color', 'k', 'marker', 'none');
hold all
errorbar(4.145, barkeeper(1,8), barkeeper(2,8), '.', 'color', 'k', 'marker', 'none');

x = 0.145
for points = 1:size(average_compiler, 1);
     
    if mod(points, 2) == 1;
        x = x + 0.71;
        x2 = [x x+0.29]
        plot(x2, average_compiler(points:points+1, 1:6), '-o' ,'color' , 'green', 'MarkerFaceColor', 'green')
        hold all
        x = x + 0.29;
       
    else
        
    end
    
end

 axis([0 5 0 35])
 set(gca,'TickDir','out')
 set(gca, 'box', 'off')
 set(gcf,'position',[680 558 400 210])
 set(gca, 'TickLength', [0.025 0.025]);
 set(gca,'FontSize',9);
 
 statistics_keeper = average_compiler';