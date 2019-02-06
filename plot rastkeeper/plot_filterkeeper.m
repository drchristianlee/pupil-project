clear;
[file , path] = uigetfile;
cd(path);
load(file);
rows = size(filterkeeper, 1);
figure
plotrows = 10; %change these depending on size
plotcols = 10;
for plotnum = 1:rows;
  subplot(plotrows, plotcols, plotnum)
  plot(filterkeeper(plotnum, 1:1250)); %change this depending on how many frames are to be plotted
end