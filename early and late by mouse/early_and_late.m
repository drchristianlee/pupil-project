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

early_trace = holdercells{1,1};
late_trace = holdercells{1, 2};

size_early_trace = size(early_trace);
frame_early = colon(1, size_early_trace(1,1)).';
mean_early = early_trace(:, 1);
sem_early = early_trace(:, 2);

figure
shadedErrorBar(frame_early(1:325, 1), mean_early(1:325, 1), sem_early(1:325, 1), 'k', 0);

hold on

size_late_trace = size(late_trace);
frame_late = colon(1, size_late_trace(1,1)).';
mean_late = late_trace(:, 1);
sem_late = late_trace(:, 2);

shadedErrorBar(frame_late(1:325, 1), mean_late(1:325, 1), sem_late(1:325, 1), 'b', 0);
% hold on
% line([199 199], get(gca, 'ylim'))
% hold on
% line([203 203], get(gca, 'ylim'))

axis([0 350 -5 25]) %this can be modified to make plot more attractive
set(gca,'TickDir','out')
set(gca, 'TickLength', [0.025 0.025]);
set(gca, 'box', 'off')
set(gca, 'XTick', [0 50 100 150 200 250 300 350]);
set(gca, 'XTickLabel', [0 1 2 3 4 5 6 7]);
set(gcf,'position',[680 558 280 210]);
set(gca,'FontSize',9);

figure
plot(mean_early(1:325), 'k')
hold on
plot(mean_late(1:325), 'b')
axis([0 350 -5 25]) %this can be modified to make plot more attractive
% hold on
% line([204 204], get(gca, 'ylim'))
% hold on
% line([197 197], get(gca, 'ylim'))
set(gca,'TickDir','out')
set(gca, 'TickLength', [0.025 0.025]);
set(gca, 'box', 'off')
set(gca, 'XTick', [0 50 100 150 200 250 300 350]);
set(gca, 'XTickLabel', [0 1 2 3 4 5 6 7]);
set(gcf,'position',[680 558 280 210]);
set(gca,'FontSize',9);
