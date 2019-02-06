%uncomment line 13 if folder contains both whisker and pupil sequences
clear;
myFolder = uigetdir;
cd(myFolder);
filePattern = fullfile(myFolder, '*.tif');
tiffiles = dir(filePattern);
count = length(tiffiles);
nMovies = count;
curMovie = 0;
w = 1;
for y = 1: count;
    %if mod(y, 2) ==1;
    B = tiffiles(y, 1).name;
    fileinfo = imfinfo(B);
    frames = numel(fileinfo);
    I = imreadtiffstack (B, frames); 
    if y == 1;
        radius = zeros(frames, 1);
    end
    for z = 1:frames;
      contrastkeeper(:,:,z) = imadjust(I(:,:,z), [0.0 0.06], []);
    end
    level = graythresh(contrastkeeper(:,:,1));
    for b = 1:frames;
        bwkeeper(:,:,b) = im2bw(contrastkeeper(:,:,b), level);
    end
    for f = 1:frames;
        edgekeeper(:,:,f) = edge(bwkeeper(:,:,f));
    end
    for x = 1:frames;
        [centersDark, radiiDark] = imfindcircles(edgekeeper(:,:,x),[70 130],'ObjectPolarity','dark', 'Sensitivity', 0.90);
        %viscircles(centersDark, radiiDark,'LineStyle','--');
        fault = isempty(radiiDark);
        if fault == 1
            [centersDark, radiiDark] = imfindcircles(edgekeeper(:,:,x),[70 130],'ObjectPolarity','dark', 'Sensitivity', 0.93);
            %radiiDark = 0;
        end
       fault = isempty(radiiDark);
       if fault == 1
            [centersDark, radiiDark] = imfindcircles(edgekeeper(:,:,x),[70 140],'ObjectPolarity','dark', 'Sensitivity', 0.96);
            %radiiDark = 0;
        end
       fault = isempty(radiiDark);
       if fault == 1
            radiiDark = 0;
       end
       sradiiDark = size(radiiDark);
            if sradiiDark(1,1) > 1
                radiiDark = NaN;
            end
        radius(x, w) = radiiDark;
    end
    w = w + 1;
    end
    
%end
save('radius.mat', 'radius');