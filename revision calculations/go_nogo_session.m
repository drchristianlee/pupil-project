clear; 
[filename, pathname] = uigetfile('*.mat');
cd(pathname);
load(filename);
Go_texture = length(Gos) + length(Misses);
NoGo_texture = length(NoGos) + length(FAs);
total = length(FAs) + length(Gos) + length(Misses) + length(NoGos);
disp(filename)
Go_percentage = (Go_texture/total) * 100
No_Go_percentage = (NoGo_texture/total) * 100