clear;
myFolder = uigetdir;
cd(myFolder);
filePattern = fullfile(myFolder, '*.mat');
tiffiles = dir(filePattern);
count = length(tiffiles);
for files = 1:count;
    loading_file = tiffiles(files,1).name;
    load(loading_file);
    files = files + 1;
end

%first create keepers without NaN trials

fa_plot_keeper_col = 1;
size_FAskeeper = size(FAskeeper);
fa_plot_keeper = NaN(size_FAskeeper(1,1) , size_FAskeeper(1,2));
for fa_col = 1: size(FAskeeper, 2);
    if isnan(nanmean(FAskeeper(:, fa_col), 1)) == 0;
        fa_plot_keeper(:, fa_plot_keeper_col) = FAskeeper(:, fa_col);
        fa_plot_keeper_col = fa_plot_keeper_col + 1;
    else
    end
end

go_plot_keeper_col = 1;
size_Goskeeper = size(Goskeeper);
go_plot_keeper = NaN(size_Goskeeper(1,1) , size_Goskeeper(1,2));
for go_col = 1: size(Goskeeper, 2);
    if isnan(nanmean(Goskeeper(:, go_col), 1)) == 0;
        go_plot_keeper(:, go_plot_keeper_col) = Goskeeper(:, go_col);
        go_plot_keeper_col = go_plot_keeper_col + 1;
    else
    end
end

cr_plot_keeper_col = 1;
size_NoGoskeeper = size(NoGoskeeper);
cr_plot_keeper = NaN(size_NoGoskeeper(1,1) , size_NoGoskeeper(1,2));
for cr_col = 1: size(NoGoskeeper, 2);
    if isnan(nanmean(NoGoskeeper(:, cr_col), 1)) == 0;
        cr_plot_keeper(:, cr_plot_keeper_col) = NoGoskeeper(:, cr_col);
        cr_plot_keeper_col = cr_plot_keeper_col + 1;
    else
    end
end

%now calculate as percent of baseline

fa_normvalue = nanmean(fa_plot_keeper(1:50, :), 1);
fa_normvalue = repmat(fa_normvalue, size(fa_plot_keeper, 1), 1);
fa_change_keeper = fa_plot_keeper - fa_normvalue;
fa_percentkeeper = rdivide(fa_change_keeper, fa_normvalue);
fa_percentkeeper = fa_percentkeeper*100;

go_normvalue = nanmean(go_plot_keeper(1:50, :), 1);
go_normvalue = repmat(go_normvalue, size(go_plot_keeper, 1), 1);
go_change_keeper = go_plot_keeper - go_normvalue;
go_percentkeeper = rdivide(go_change_keeper, go_normvalue);
go_percentkeeper = go_percentkeeper*100;

cr_normvalue = nanmean(cr_plot_keeper(1:50, :), 1);
cr_normvalue = repmat(cr_normvalue, size(cr_plot_keeper, 1), 1);
cr_change_keeper = cr_plot_keeper - cr_normvalue;
cr_percentkeeper = rdivide(cr_change_keeper, cr_normvalue);
cr_percentkeeper = cr_percentkeeper*100;

figure;
plot(fa_percentkeeper);
figure;
plot(go_percentkeeper);
figure;
plot(cr_percentkeeper);

figure;
imagesc(fa_percentkeeper.');
caxis([-30 70])
axis([0 350 0.5 57]) %this can be modified to make plot more attractive
set(gca,'TickDir','out')
set(gca, 'box', 'off')
set(gcf,'position',[680 558 230 210])
set(gca,'FontSize',9);
set(gca, 'TickLength', [0.025 0.025]);
colorbar

figure;
imagesc(go_percentkeeper.');
caxis([-30 70])
axis([0 350 0.5 57]) %this can be modified to make plot more attractive
set(gca,'TickDir','out')
set(gca, 'box', 'off')
set(gcf,'position',[680 558 230 210])
set(gca,'FontSize',9);
set(gca, 'TickLength', [0.025 0.025]);
colorbar

figure;
imagesc(cr_percentkeeper.');
caxis([-30 70])
axis([0 350 0.5 57]) %this can be modified to make plot more attractive
set(gca,'TickDir','out')
set(gca, 'box', 'off')
set(gcf,'position',[680 558 230 210])
set(gca,'FontSize',9);
set(gca, 'TickLength', [0.025 0.025]);
colorbar

for cols1 = 1: size(fa_percentkeeper, 2);
    if isnan(nanmean(fa_percentkeeper(:, cols1))) == 1;
        break
    end
    stopcol1 = cols1 + 3;
end

fa_percentkeeper_holder = fa_percentkeeper(:, 1:stopcol1);

for cols2 = 1: size(go_percentkeeper, 2);
    if isnan(nanmean(go_percentkeeper(:, cols2))) == 1;
        break
    end
    stopcol2 = cols2 + 3;
end

go_percentkeeper_holder = go_percentkeeper(:, 1:stopcol2);

for cols3 = 1: size(cr_percentkeeper, 2);
    if isnan(nanmean(cr_percentkeeper(:, cols3))) == 1;
        break
    end
    stopcol3 = cols3 + 3;
end

cr_percentkeeper_holder = cr_percentkeeper(:, 1:stopcol3);

total_percentkeeper = horzcat(fa_percentkeeper_holder, go_percentkeeper_holder, cr_percentkeeper_holder);


figure;
imagesc(total_percentkeeper.');
caxis([-30 70])
axis([0 350 0.5 size(total_percentkeeper, 2)]) %this can be modified to make plot more attractive
set(gca,'TickDir','out')
set(gca, 'box', 'off')
set(gcf,'position',[680 558 230 210])
set(gca,'FontSize',9);
set(gca, 'TickLength', [0.025 0.025]);
colorbar