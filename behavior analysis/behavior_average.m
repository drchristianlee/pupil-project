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
sizeradius = size(radius);
radiusheight = sizeradius(1,1);
radiuslength = sizeradius(1,2);
Goskeeper = NaN(radiusheight, radiuslength);
for g = 1:numGos;
    gocolumn = Gos(1, g);
    Goskeeper (:,gocolumn) = radius(:,gocolumn);
end

Goskeeper(Goskeeper==0) = NaN;
Gosmean = nanmean(Goskeeper, 2);

Misseskeeper = NaN(radiusheight, radiuslength);
for m = 1:numMisses;
    Missescolumn = Misses(1, m);
    Misseskeeper (:,Missescolumn) = radius(:,Missescolumn);
end

Misseskeeper(Misseskeeper==0) = NaN;
Missesmean = nanmean(Misseskeeper, 2);

NoGoskeeper = NaN(radiusheight, radiuslength);
for n = 1:numNoGos;
    nogocolumn = NoGos(1, n);
    NoGoskeeper (:,nogocolumn) = radius(:,nogocolumn);
end

NoGoskeeper(NoGoskeeper==0) = NaN;
NoGosmean = nanmean(NoGoskeeper, 2);

FAskeeper = NaN(radiusheight, radiuslength);
for f = 1:numFAs;
    facolumn = FAs(1, f);
    FAskeeper (:,facolumn) = radius(:,facolumn);
end

FAskeeper(FAskeeper==0) = NaN;
FAsmean = nanmean(FAskeeper, 2);