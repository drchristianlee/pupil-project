%mouse = 'Z:\DATA\thintrin1_2\';
mouse = 'Z:\DATA\textureDiscrim\H42\thintrin1_2\thin01\try\';

%%%prep for session cycling
cd(mouse); %open path in command window
folders = dir(mouse); % lists attributes about files and folders in current Matlab folder in structure
folders = folders([folders.isdir]); %removes entries which do not have isdir=1 (i.e. not a folder)
folders(strncmp({folders.name}, '.', 1)) = []; % removes first two entries of above folder; only session folders are left

timeCourse_dprime = zeros(1,size(folders,1));
timeCourse_fc = zeros(1,size(folders,1));   %fraction correct
%%%cycle through all the session subfolders in mouse 
listname=cell(size(folders,1),1);%creates empty cell with #rows=#subfolders
for k=1:size(folders,1);
    listname{k,:}=cellstr(folders(k,1).name); %fills in listname with the name of the session in each row
    session=[char(listname{k,1})];% '\']; %kth listname entry converted to a string, \ added to end
    cd([mouse session]); %opens kth session folder

    [dprime_session, fc_session] = get_dprime([mouse session]);
    timeCourse_dprime(k) = dprime_session;
    timeCourse_fc(k) = fc_session;

end

fig1=figure; 
subplot(1,2,1); plot(timeCourse_dprime,'ok-'); ylim([0.5 4]); xlim([0 size(folders,1)+1]); ylabel('dprime'); xlabel('session');
subplot(1,2,2); plot(timeCourse_fc,'ok-'); ylim([0.5 1]); xlim([0 size(folders,1)+1]); ylabel('fraction correct'); xlabel('session');

%timeline(mouse);
cd(mouse);

hgsave(fig1,'learning_curve');
save ('learning_curve', 'timeCourse_dprime', 'timeCourse_fc');


