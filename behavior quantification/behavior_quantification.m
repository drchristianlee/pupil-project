%use this file to calculate the percentage correct, and average response
%times. To run this script, place the decision_log mat files into a single
%folder for early or late sessions. This will require manually renaming the
%decision_log mat files since they all have the same name given by the
%behavior_average3 script. Then run this script by choosing the directory
%that is to be analyzed. 

clear;
folder = uigetdir;
cd(folder);
filePattern = fullfile(folder, '*.mat');
matfiles = dir(filePattern);
count = length(matfiles);
for f = 1:count;
    B = matfiles(f, 1).name;
    currkeeper = load(B);
    %
    %these steps are to calculate the individual session percent correct
    %and incorrect. I'm unsure if this is correct because it yields a
    %different percentage than the overall percentage correct and
    %incorrect. This should be checked. 
%     sessionGos = length(cell2mat(currkeeper.decision_log(2:end, 7)));
%     sessionNoGos = length(cell2mat(currkeeper.decision_log(2:end, 8)));
%     sessionMisses = length(cell2mat(currkeeper.decision_log(2:end, 9)));
%     sessionFAs = length(cell2mat(currkeeper.decision_log(2:end, 10)));
%     sessioncorrect = sessionGos + sessionNoGos;
%     sessionincorrect = sessionMisses + sessionFAs;
%     sessiontotal = sessionGos + sessionNoGos + sessionMisses + sessionFAs;
%     sessionpercent(f, 1) = (sessioncorrect/sessiontotal) * 100;
%     sessionpercent(f, 2) = (sessionincorrect/sessiontotal) * 100;
    %
    if f == 1;
        accumcell = currkeeper.decision_log;
    else
        accumcell = [accumcell; currkeeper.decision_log(2:end, :)];
    end
end
Gos = length(cell2mat(accumcell(2:end, 7)));
NoGos = length(cell2mat(accumcell(2:end, 8)));
Misses = length(cell2mat(accumcell(2:end, 9)));
FAs = length(cell2mat(accumcell(2:end, 10)));
correct = Gos + NoGos;
incorrect = Misses + FAs;
total = Gos + NoGos + Misses + FAs;
percentcorrect = (correct/total) * 100;
percentincorrect = (incorrect/total) * 100;
piedata = [percentcorrect percentincorrect];
figure;
pie(piedata);

%now calculate mean and standard error of session data
% sessioncorrectmean = mean(sessionpercent(:, 1));
% sessioncorrectsem = std(sessionpercent(:, 1))/sqrt(length(sessionpercent));
% sessionincorrectmean = mean(sessionpercent(:, 2));
% sessionincorrectsem = std(sessionpercent(:, 2))/sqrt(length(sessionpercent));


%now create vectors and calculate mean response times
GoTime(1:(length(accumcell)), 1) = NaN;
FAtime(1:(length(accumcell)), 1) = NaN;
for cell = 2:(length(accumcell));
    if length(accumcell{cell, 6}) > 0;
    GoTime(cell, 1) = str2num(accumcell{cell, 6});
    else
    end
    if length(accumcell{cell, 11}) > 0
    FAtime(cell, 1) = str2num(accumcell{cell, 11});
    else
    end
end
% now calculate mean
GoTimeAvg = nanmean(GoTime);
FAtimeAvg = nanmean(FAtime);