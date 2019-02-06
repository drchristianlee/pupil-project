clear;
folder = uigetdir;
cd(folder);
filePattern = fullfile(folder, '*.mat');
matfiles = dir(filePattern);
count = length(matfiles);
for f = 1:count;
    B = matfiles(f, 1).name;
    load(B);
end
sizeGos = size(Gos);
numGos = sizeGos(1,2);
sizeMisses = size(Misses);
numMisses = sizeMisses(1,2);
sizeNoGos = size(NoGos);
numNoGos = sizeNoGos(1,2);
sizeFAs = size(FAs);
numFAs = sizeFAs(1,2);
sizeradius = size(diamKeeper);
radiusheight = sizeradius(1,1);
radiuslength = sizeradius(1,2);
Goskeeper = NaN(radiusheight, radiuslength);
for g = 1:numGos;
    gocolumn = Gos(1, g);
    Goskeeper (:,gocolumn) = diamKeeper(:,gocolumn);
end

Goskeeper(Goskeeper==0) = NaN;
Gosmean = nanmean(Goskeeper, 2);

Misseskeeper = NaN(radiusheight, radiuslength);
for m = 1:numMisses;
    Missescolumn = Misses(1, m);
    Misseskeeper (:,Missescolumn) = diamKeeper(:,Missescolumn);
end

Misseskeeper(Misseskeeper==0) = NaN;
Missesmean = nanmean(Misseskeeper, 2);

NoGoskeeper = NaN(radiusheight, radiuslength);
for n = 1:numNoGos;
    nogocolumn = NoGos(1, n);
    NoGoskeeper (:,nogocolumn) = diamKeeper(:,nogocolumn);
end

NoGoskeeper(NoGoskeeper==0) = NaN;
NoGosmean = nanmean(NoGoskeeper, 2);

FAskeeper = NaN(radiusheight, radiuslength);
for f = 1:numFAs;
    facolumn = FAs(1, f);
    FAskeeper (:,facolumn) = diamKeeper(:,facolumn);
end

FAskeeper(FAskeeper==0) = NaN;
FAsmean = nanmean(FAskeeper, 2);
figure;
plot(Gosmean)
hold all;
plot(NoGosmean);
hold all;
plot(FAsmean);
hold all;
plot(Missesmean);
hold all;
legend('Gosmean', 'Nogosmean', 'FAsmean', 'Missesmean');