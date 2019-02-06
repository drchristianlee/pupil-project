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

percent_gos = (Gos / total) * 100;
percent_nogos = (NoGos / total) * 100;
percent_FAs = (FAs / total) * 100;
percent_misses = (Misses / total) * 100;
figure;
piedata2 = [percent_gos percent_nogos percent_FAs percent_misses];
pie(piedata2);
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
allresponse = vertcat(GoTime, FAtime);
allresponseAvg = nanmean(allresponse);

%now calculate d prime

trials_all = total;
fc_all = correct / total;

pHit = Gos/(Gos + Misses);
pFA_all = FAs/(NoGos + FAs);
        
zHit = norminv(pHit, 0, 1) ; %-- Convert to Z scores

zFA_all = norminv(pFA_all, 0, 1);

DP_all = zHit-zFA_all;

%now calculate the SEM for Go and FA times

GoTime_nanfinder = isnan(GoTime);
GoTrials = size(GoTime, 1) - sum(GoTime_nanfinder, 1);
GoTime_SEM = nanstd(GoTime, 0, 1) / sqrt(GoTrials);

FAtime_nanfinder = isnan(FAtime);
FAtrials = size(FAtime, 1) - sum(FAtime_nanfinder, 1);
FAtime_SEM = nanstd(FAtime, 0, 1) / sqrt(FAtrials);

name_parse = strsplit(folder, '\');
name1 = name_parse{1, end};
name2 = name_parse{1, end-1};
save(char(strcat(name1,'_', name2, '_Go_time_average')), 'GoTimeAvg');
save(char(strcat(name1, '_', name2, '_FA_time_average')), 'FAtimeAvg');
save(char(strcat(name1, '_', name2, '_percent_go')), 'percent_gos');
save(char(strcat(name1,'_', name2, '_percent_nogo')), 'percent_nogos');
save(char(strcat(name1,'_', name2, '_percent_FA')), 'percent_FAs');
save(char(strcat(name1,'_', name2, '_percent_miss')), 'percent_misses');
save(char(strcat(name1,'_', name2, '_percent_correct')), 'percentcorrect');
save(char(strcat(name1,'_', name2, '_percent_incorrect')), 'percentincorrect');

%display([num2str(DP_all) ' d prime for session ' session ' (' num2str(fc_all) ' fr cor) ' num2str(trials_all) ': ' num2str(length(Gos)) ' Go, ' num2str(length(NoGos)) ' NoGo, ' num2str(length(Misses)) ' Miss, ' num2str(length(FAs)) ' FA']);



% wholeGos = [];
% wholeNoGos = [];
% wholeMisses = [];
% wholeFAs = [];
% for trial = 2:length(accumcell);
%     if str2num(accumcell{trial, 7}) == 1;
%         wholeGos(1, (length(wholeGos) + 1)) = trial-1;
%     else if str2num(accumcell{trial, 8}) == 1;
%             wholeNoGos(1, (length(wholeNoGos) + 1)) = trial-1;
%         elseif str2num(accumcell{trial, 9}) == 1;
%             wholeMisses(1, (length(wholeMisses) + 1)) = trial-1;
%         elseif str2num(accumcell{trial, 10}) == 1;
%             wholeFAs(1, (length(wholeFAs) + 1)) = trial-1;
%         end
%     end
% end