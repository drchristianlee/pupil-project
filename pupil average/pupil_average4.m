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

%now plot each trace
% for col = 1:sizediamkeeper(1,2);
%     if isnan(nanmean(diamKeeper(:,col), 1)) == 0;
%         figure
%     plot(diamKeeper(:, col));
%     title(col)
%     else
%     end
% end

%now plot the trace desired for the figure

plot_trace = 36;
plot_keeper = diamKeeper(:, plot_trace);
normvalue = nanmean(plot_keeper(1:50, :), 1);
normvalue = repmat(normvalue, size(plot_keeper, 1), 1);
change_keeper = plot_keeper - normvalue;
percentkeeper = rdivide(change_keeper, normvalue);
percentkeeper = percentkeeper*100;
figure
plot(percentkeeper)
%axis([0 350 -10 40]) %this can be modified to make plot more attractive
set(gca,'TickDir','out')
set(gca, 'box', 'off')
hold on;

avg_plot_keeper = diamKeeper;
avg_normvalue = nanmean(avg_plot_keeper(1:50, :), 1);
avg_normvalue = repmat(avg_normvalue, size(avg_plot_keeper, 1), 1);
avg_change_keeper = avg_plot_keeper - avg_normvalue;
avg_percentkeeper = rdivide(avg_change_keeper, avg_normvalue);
avg_percentkeeper = avg_percentkeeper*100;
sizepercentkeeper = size(percentkeeper);

mean_percent_keeper = nanmean(avg_percentkeeper, 2);
plot(mean_percent_keeper, 'k');

%now plot each trace
% for col = 1:sizediamkeeper(1,2);
%     if isnan(nanmean(percentkeeper(:,col), 1)) == 0;
%         figure
%     plot(percentkeeper(:, col));
%     title(col)
%     else
%     end
% end

% avgsem(:,1) = colon(1, sizepercentkeeper(1,1)).';
% avgsem(:, 2) = mean_percent_keeper;
% 
% nanfinder = isnan(percentkeeper);
% nantrials = size(percentkeeper, 2) - sum(nanfinder, 2);
% avgsem(:, 3) = nanstd(percentkeeper, 0, 2) ./ sqrt(nantrials);
% figure
% frame = avgsem(:, 1);
% tracemean = avgsem(:, 2);
% tracesem = avgsem(:, 3);
% shadedErrorBar(frame, tracemean, tracesem, 'b', 0);



%if plotting a trial with a response use the text below
hold on;
trial_go_frame = str2num(decision_log{plot_trace + 1 , 6});
trial_go_frame = (trial_go_frame + 3.05) * 50;
hold on;
plot(trial_go_frame, 0, '^');


%now plot based on average values
% avgval = nanmean(diamKeeper(1, :) , 2); %important note, this can be modified to complete a figure using frames 400 to end, this needs to be changed back to 1 if that is not desired
% diamKeepernorm = (diamKeeper / avgval) * 100;
% sizediamkeepernorm = size(diamKeepernorm);
% avgcolnorm = sizediamkeepernorm(1, 2) + 1;
% diamKeepernormAvg = diamKeepernorm;
% for row = 1:sizediamkeepernorm(1, 1);
%     diamKeepernormAvg(row, avgcolnorm) = nanmean(diamKeepernorm(row, :), 2);
% end
% avgsem(:,1) = colon(1, length(diamKeepernorm)).';
% avgsem(:, 2) = diamKeepernormAvg(:, avgcolnorm);
% nanfinder = isnan(diamKeepernorm);
% nantrials = size(diamKeepernorm, 2) - sum(nanfinder, 2);
% avgsem(:, 3) = nanstd(diamKeepernorm, 0, 2) ./ sqrt(nantrials);
% figure
% frame = avgsem(:, 1);
% tracemean = avgsem(:, 2);
% tracesem = avgsem(:, 3);
% shadedErrorBar(frame, tracemean, tracesem, 'b', 0);

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


%now plot raw values

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
