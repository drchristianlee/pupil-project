function [DP_all, fc_all] = get_dprime(in)
session = in;%'thin01-6';
cd(session)

load decision_log

trials_all = length(Gos) + length(NoGos) + length(FAs) + length(Misses);
fc_all = (length(Gos) + length(NoGos)) / trials_all;

pHit = length(Gos)/(length(Gos)+length(Misses));
pFA_all = length(FAs)/(length(NoGos)+length(FAs));
        
zHit = norminv(pHit, 0, 1) ; %-- Convert to Z scores

zFA_all = norminv(pFA_all, 0, 1);

DP_all = zHit-zFA_all;

display([num2str(DP_all) ' d prime for session ' session ' (' num2str(fc_all) ' fr cor) ' num2str(trials_all) ': ' num2str(length(Gos)) ' Go, ' num2str(length(NoGos)) ' NoGo, ' num2str(length(Misses)) ' Miss, ' num2str(length(FAs)) ' FA']);


cd ..