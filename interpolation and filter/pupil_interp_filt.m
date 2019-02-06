function filt = pupil_interp_filt(diamKeeper)
% diamKeeper is column vector of extracted pupil traces

framerate = 100; %was 100
Hz_filter = 8;
[b, a] = butter(2, Hz_filter/(framerate*0.5),'low');

diamKeeper_interp = diamKeeper;
diamKeeper_filt = diamKeeper;
for i = 1:size(diamKeeper,2)
    diamKeeper_interp(:,i) = spline(1:size(diamKeeper,1),diamKeeper_interp(:,i),1:size(diamKeeper,1));
    diamKeeper_filt(:,i) = filtfilt(b, a, diamKeeper_interp(:,i));
end

filt = diamKeeper_filt;

end

% % plot test for nans
% plot(nanmean(diamKeeper')); hold all
% plot(nanmean(diamKeeper_interp'));
% 
% dd=zeros(1,size(diamKeeper,2));
% nn=dd;
% for i = 1:16;%size(diamKeeper,2)
%     %dd(i)=dot(diamKeeper_interp(:,i),diamKeeper_filt(:,i));
%     %dd(i)=sum(diamKeeper_interp(:,i)-diamKeeper_filt(:,i));
%     nn(i)=sum(isnan(diamKeeper(:,i)));
%     dd(i)=nansum(abs(diamKeeper(:,i)-diamKeeper_filt(:,i))) / mean(diamKeeper_filt(:,i));
%     subplot(4,4,i);
%     plot(diamKeeper(:,i)); hold all; plot(diamKeeper_filt(:,i));
%     title(num2str(nn(i))); %dd(i)
% %     if dd(i)<5
% %         display([num2str(i) '  ' num2str(dd(i))]);
% %     end
% end


% old
%
% diamKeeper_filt = diamKeeper_interp;
% for i = 1:size(diamKeeper,2)
%     diamKeeper_filt(:,i) = filtfilt(b, a, diamKeeper_filt(:,i));
% end