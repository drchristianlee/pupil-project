clear;
[file , path] = uigetfile;
cd(path);
load(file);
rows = size(rastkeeper, 1);
figure
plotrows = 10; %change these depending on size
plotcols = 10;
for plotnum = 1:rows;
  subplot(plotrows, plotcols, plotnum)
  plot(rastkeeper(plotnum, :));
end