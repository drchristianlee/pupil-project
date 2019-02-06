%this script calculates the grand average from the output of behavior
%analysis 3. Place the .mat files of a given response type into a folder
%named with the response type, thus Gos, NoGos etc.

clear;
folder = uigetdir;
cd(folder);
filePattern = fullfile(folder, '*.mat');
matfiles = dir(filePattern);
count = length(matfiles);
keepercol = 1;
for f = 1:count;
    B = matfiles(f, 1).name;
    currkeeper = load(B);
    name = char(fieldnames(currkeeper));
    holdercells(1, f) = {currkeeper.(name)};
end
for matrices = 1:(length(holdercells));
    currmatrix = cell2mat(holdercells(1, matrices));
    numcols = size(currmatrix);
    for cols = 1:numcols(1,2);
        decisioncol = currmatrix(:, cols);
        if isnan(nanmean(decisioncol, 1))==0
            for rows = 1:(length(currmatrix));
                %done this way to avoid having to pad data to account for
                %different file lengths.
                averagekeeper(rows,keepercol) = currmatrix(rows, cols);
            end
            keepercol = keepercol + 1;
        end
    end
end
%now convert zeros in averagekeeper to NaNs
averagekeeper(averagekeeper==0) = NaN;

%now calculate the average
grandaverage = nanmean(averagekeeper, 2);

%now plot the grand average data
plot(grandaverage);

%now save the average data
save(char(strcat(name, '_average')), 'grandaverage');