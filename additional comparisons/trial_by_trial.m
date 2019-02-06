clear;
folder = uigetdir;
cd(folder);
filePattern = fullfile(folder, '*.mat');
matfiles = dir(filePattern);
count = length(matfiles);

for f = 1:count;
    B = matfiles(f, 1).name;
    load(B)
end

num_trial_type = 1;

normkeeper = ((bsxfun(@rdivide, Goskeeper, Goskeeper(1, :))) * 100) - 100;
resultkeeper_row = 1;

for trial = 1:size(normkeeper, 2);
    if isnan(nanmean(normkeeper(:, trial))) == 0;
        response_time = 3.05 + GoTimes(1, num_trial_type);
        response_frame = round(response_time * 50);
        resultkeeper(resultkeeper_row, 1) = GoTimes(1, num_trial_type);
        resultkeeper(resultkeeper_row, 2) = normkeeper(response_frame, trial);
        num_trial_type = num_trial_type + 1;
        resultkeeper_row = resultkeeper_row + 1;
    else
    end
end

scatter(resultkeeper(:, 1), resultkeeper(:, 2));
axis([0 2 -10 60])
set(gca,'TickDir','out')
set(gca, 'box', 'off')
%set(gcf,'position',[680 558 230 420])