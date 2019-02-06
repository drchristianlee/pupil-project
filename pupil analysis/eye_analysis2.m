myFolder = uigetdir;
cd(myFolder);
filePattern = fullfile(myFolder, '*.tif');
tiffiles = dir(filePattern);
count = length(tiffiles);
nMovies = count;
curMovie = 0;
for y = 1: count;
    B = tiffiles(y, 1).name;
    fileinfo = imfinfo(B);
    frames = numel(fileinfo);
    I = imreadtiffstack (B, frames); 
    if y == 1;
        radius = zeros(frames, 1);
    end
    for z = 1:frames;
      contrastkeeper(:,:,z) = imadjust(I(:,:,z), [0.0 0.15], []);
    end
    level = graythresh(contrastkeeper(:,:,1));
    for b = 1:frames;
        bwkeeper(:,:,b) = im2bw(contrastkeeper(:,:,b), level);
    end
    for f = 1:frames;
        edgekeeper(:,:,f) = edge(bwkeeper(:,:,f));
    end
    for x = 1:frames;
        [centersDark, radiiDark] = imfindcircles(edgekeeper(:,:,x),[80 150],'ObjectPolarity','dark', 'Sensitivity', 0.90);
        %viscircles(centersDark, radiiDark,'LineStyle','--');
        fault = isempty(radiiDark);
        if fault == 1
            [centersDark, radiiDark] = imfindcircles(edgekeeper(:,:,x),[80 180],'ObjectPolarity','dark', 'Sensitivity', 0.96);
            %radiiDark = 0;
        end
       fault = isempty(radiiDark);
       if fault == 1
            radiiDark = 0;
       end
        radius(x, y) = radiiDark;
        end
end