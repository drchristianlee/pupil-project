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
 