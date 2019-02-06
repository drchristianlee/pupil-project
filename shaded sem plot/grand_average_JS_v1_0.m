%this script calculates the grand average from the output of behavior
%analysis 3. Place the .mat files of a given response type into a folder
%named with the response type, thus Gos, NoGos etc.

%shadedErrorBar function from http://www.mathworks.com/matlabcentral/fileexchange/26311-shadederrorbar
%by Rob Campbell

clear;
%Constants
TIME_TRACE_LENGTH = 824;

currentFolder = pwd;
folder = uigetdir;
cd(folder);
matfiles = dir('*.mat');
numOfTrials = length(matfiles);
offsetTrials = 0;

%Offset calculations
for f = 1:numOfTrials
    currentFile = load(matfiles(f, 1).name);
    currentDiameterData = currentFile.diamKeeper;
    find(currentDiameterData == NaN)
    offsetSize = size(currentDiameterData, 2);
    if (offsetSize > 1)
        offsetTrials = offsetSize - 1;
    end
end

numOfTrialsAppended = numOfTrials + offsetTrials;
dataMatrix = zeros(TIME_TRACE_LENGTH, numOfTrialsAppended);

%Loading data into data matrix
for f = 1:numOfTrials;
    currentFile = load(matfiles(f, 1).name);
    currentDiameterData = currentFile.diamKeeper;
    offsetSize = size(currentDiameterData, 2);
    if (offsetSize > 1)
        dataMatrix(:,f:f+offsetTrials) = currentDiameterData;
    else
        dataMatrix(:, f) = currentDiameterData;
    end
end

cd(currentFolder);

avgTrace = nanmean(dataMatrix, 2);
nanValues = isnan(dataMatrix);
nanTrials = size(dataMatrix, 2) - sum(nanValues, 2);

sem = nanstd(dataMatrix, 0, 2) ./ sqrt(nanTrials);

figure;
hold on;
time = (1:TIME_TRACE_LENGTH)';
H(1) = shadedErrorBar(time, avgTrace, sem, 'b', 0);
hold off;

%plot(time, avgTrace, 'r', time, avgTrace+sem, 'b', time, avgTrace-sem, 'b');

% for matrices = 1:(length(holdercells));
%     currmatrix = cell2mat(holdercells(1, matrices));
%     numcols = size(currmatrix);
%     for cols = 1:numcols(1,2);
%         decisioncol = currmatrix(:, cols);
%         if isnan(nanmean(decisioncol, 1))==0
%             for rows = 1:(length(currmatrix));
%                 %done this way to avoid having to pad data to account for
%                 %different file lengths.
%                 averagekeeper(rows,keepercol) = currmatrix(rows, cols);
%             end
%             keepercol = keepercol + 1;
%         end
%     end
% end
% %now convert zeros in averagekeeper to NaNs
% averagekeeper(averagekeeper==0) = NaN;
% 
% %now calculate the average
% grandaverage = nanmean(averagekeeper, 2);
% 
% %now plot the grand average data
% plot(grandaverage);
% 
% %now save the average data
% save(char(strcat(name, '_average')), 'grandaverage');