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
    for f = 1:frames;
        edgekeeper(:,:,f) = edge(contrastkeeper(:,:,f));
    end
    for x = 1:frames;
        [centersDark, radiiDark] = imfindcircles(edgekeeper(:,:,x),[40 70],'ObjectPolarity','dark', 'Sensitivity', 0.94);
        %viscircles(centersDark, radiiDark,'LineStyle','--');
        ans = isempty(radiiDark);
        if ans == 1
            [centersDark, radiiDark] = imfindcircles(edgekeeper(:,:,x),[40 70],'ObjectPolarity','dark', 'Sensitivity', 0.96);
            %radiiDark = 0;
        end
       ans = isempty(radiiDark);
       if ans == 1
            radiiDark = 0;
       end
        radius(x, 1) = radiiDark;
        end
end