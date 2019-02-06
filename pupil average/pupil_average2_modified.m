%use this script to plot the average of a single diameter.mat file
%containing the diamKeeper variable. This can be used to plot unexpected
%reward trials. 

clear; 
[filename, pathname] = uigetfile('*.mat');
cd(pathname);
load(filename);

sizediamkeeper = size(diamKeeper);
avgcol = sizediamkeeper(1, 2) + 1;
diamKeeperAvg = diamKeeper;
for row = 1:sizediamkeeper(1, 1);
    diamKeeperAvg(row, avgcol) = nanmean(diamKeeper(row, :), 2);
end
figure
plotcols = sizediamkeeper(1, 2);
plot(diamKeeperAvg(:,1:plotcols), 'yellow');
hold on
plot(diamKeeperAvg(:,end))
axis tight;
hold off

%now plot frames 400 to end based on average values, be sure to change if
%plotting different frames or using different frames as a baseline

plotkeeper = diamKeeper(400:end , :);
normvalue = nanmean(plotkeeper(1:50, :), 1);
normvalue = repmat(normvalue, size(plotkeeper, 1), 1);
change_keeper = plotkeeper - normvalue;
percentkeeper = rdivide(change_keeper, normvalue);
percentkeeper = percentkeeper*100;
sizepercentkeeper = size(percentkeeper);

mean_percent_keeper = nanmean(percentkeeper, 2);

avgsem(:, 1) = colon(1, sizepercentkeeper(1,1)).';
avgsem(:, 2) = mean_percent_keeper;

nanfinder = isnan(percentkeeper);
nantrials = size(percentkeeper, 2) - sum(nanfinder, 2);
avgsem(:, 3) = nanstd(percentkeeper, 0, 2) ./ sqrt(nantrials);
figure
frame = avgsem(:, 1);
tracemean = avgsem(:, 2);
tracesem = avgsem(:, 3);
shadedErrorBar(frame, tracemean, tracesem, 'b', 0);
axis([0 450 -10 25])

hold on
line([145 145], get(gca, 'ylim'))
set(gca,'TickDir','out')
set(gca, 'TickLength', [0.025 0.025]);
set(gca, 'box', 'off')
set(gca, 'XTick', [0 50 100 150 200 250 300 350 400 450]);
set(gca, 'XTickLabel', [0 1 2 3 4 5 6 7 8 9]);
set(gcf,'position',[680 558 280 210]);
set(gca,'FontSize', 9);

%axis([400 850 80 130]) %this can be modified to make plot more attractive

%now plot just rows 400 to 850, this is useful because grouping in
%illustrator is difficult the other way

% tracemeanshort = tracemean(400:end, 1);
% tracesemshort = tracesem(400:end, 1);
% frameshort = colon(1, length(tracemeanshort)).';
% figure
% shadedErrorBar(frameshort, tracemeanshort, tracesemshort, 'b', 0);
% axis([0 450 80 130]) %this can be modified to make plot more attractive
% set(gca,'TickDir','out')
% set(gca, 'box', 'off')
% figure
% plotcols = sizediamkeepernorm(1, 2);
% plot(diamKeepernormAvg(:,1:plotcols), 'yellow');
% hold on
% plot(diamKeepernormAvg(:,end))
% axis tight;
% hold off
% 
% 
% %now plot raw values
% 
% avgsemraw(:, 1) = colon(1, length(diamKeeper)).';
% avgsemraw(:, 2) = diamKeeperAvg(:, avgcol);
% rawnanfinder = isnan(diamKeeper);
% rawnantrials = size(diamKeeper, 2) - sum(rawnanfinder, 2);
% avgsemraw(:, 3) = nanstd(diamKeeper, 0, 2) ./ sqrt(rawnantrials);
% rawframe = avgsemraw(:, 1);
% rawtracemean = avgsemraw(:, 2);
% rawtracesem = avgsemraw(:, 3);
% figure
% shadedErrorBar(rawframe, rawtracemean, rawtracesem, 'b', 0);
