%use this script to plot the average of a single diameter.mat file
%containing the diamKeeper variable. This can be used to plot unexpected
%reward trials. 

clear; 
[filename, pathname] = uigetfile('*.mat');
cd(pathname);
diamKeeper2 = load(filename);
name = fieldnames(diamKeeper2);
name2 = strcat('diamKeeper2.', name(1,1));
diamKeeper = eval(name2{1,1});
load('decision_log.mat')
%average_goframe = (3.05 + mean(GoTimes, 2)) * 50;
average_faframe = (3.05 + mean(FAtimes, 2)) * 50;

sizediamkeeper = size(diamKeeper);
avgcol = sizediamkeeper(1, 2) + 1;
diamKeeperAvg = diamKeeper;
for row = 1:sizediamkeeper(1, 1);
    diamKeeperAvg(row, avgcol) = nanmean(diamKeeper(row, :), 2);
end
figure
plotcols = sizediamkeeper(1, 2);
plot(diamKeeperAvg(:,1:plotcols), 'green');
hold on
plot(diamKeeperAvg(:,end))
axis tight;
%line([average_goframe average_goframe], get(gca, 'ylim'))
line([average_faframe average_faframe], get(gca, 'ylim'))
hold off

%now plot each trace in pixels
% for col = 1:sizediamkeeper(1,2);
%     if isnan(nanmean(diamKeeper(:,col), 1)) == 0;
%         figure
%     plot(diamKeeper(:, col));
%     title(col)
%     else
%     end
% end

%now plot the trace desired for the figure

plot_trace = 70; %change this value depending on which trace to plot
plot_keeper = diamKeeper(:, plot_trace);
normvalue = nanmean(plot_keeper(1:50, :), 1);
normvalue = repmat(normvalue, size(plot_keeper, 1), 1);
change_keeper = plot_keeper - normvalue;
percentkeeper = rdivide(change_keeper, normvalue);
percentkeeper = percentkeeper*100;
figure
plot(percentkeeper(1:350, :))
axis([0 350 -20 40]) %this can be modified to make plot more attractive
set(gca,'TickDir','out')
set(gca, 'TickLength', [0.025 0.025]);
set(gca, 'box', 'off')
set(gca, 'XTick', [0 50 100 150 200 250 300 350]);
set(gca, 'XTickLabel', [0 1 2 3 4 5 6 7]);
set(gcf,'position',[680 558 280 210]);
set(gca,'FontSize',9);

hold on;

%if plotting a trial with a response use the text below
hold on;
trial_go_frame = str2num(decision_log{plot_trace + 1 , 6}); %change column depending on whether a go or fa is plotted
trial_go_frame = (trial_go_frame + 3.05) * 50;
hold on;
plot(trial_go_frame, 0, '^');
hold on;
% plot(average_goframe, 0, '^' , 'color', 'k');

avg_plot_keeper = diamKeeper;
avg_normvalue = nanmean(avg_plot_keeper(1:50, :), 1);
avg_normvalue = repmat(avg_normvalue, size(avg_plot_keeper, 1), 1);
avg_change_keeper = avg_plot_keeper - avg_normvalue;
avg_percentkeeper = rdivide(avg_change_keeper, avg_normvalue);
avg_percentkeeper = avg_percentkeeper*100;

%Now calculate mean, sem, and plot
size_avg_percentkeeper = size(avg_percentkeeper);
avg_sem(:, 1) = colon(1, size_avg_percentkeeper(1,1)).';
avg_sem(:, 2) = nanmean(avg_percentkeeper, 2);
nanfinder = isnan(avg_percentkeeper);
nantrials = size(avg_percentkeeper, 2) - sum(nanfinder, 2);
avg_sem(:, 3) = nanstd(avg_percentkeeper, 0, 2) ./ sqrt(nantrials);

figure
frame = avg_sem(1:350, 1);
tracemean = avg_sem(1:350, 2);
tracesem = avg_sem(1:350, 3);
shadedErrorBar(frame, tracemean, tracesem, 'b', 0);
hold on;
average_go_frame = nanmean(GoTimes, 2); %Change to GoTimes if plotting go trials
average_go_frame = (average_go_frame + 3.05) * 50;
plot(average_go_frame, 0, '^');

axis([0 350 -20 40]) %this can be modified to make plot more attractive
set(gca,'TickDir','out')
set(gca, 'TickLength', [0.025 0.025]);
set(gca, 'box', 'off')
set(gca, 'XTick', [0 50 100 150 200 250 300 350]);
set(gca, 'XTickLabel', [0 1 2 3 4 5 6 7]);
set(gcf,'position',[680 558 280 210]);
set(gca,'FontSize',9);


