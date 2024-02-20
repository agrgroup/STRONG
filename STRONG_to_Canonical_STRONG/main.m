clc
clear
close all 

%% Reading the text file containing STRONGs 

fileID = fopen('STRONGS.txt','r');
tline = fgets(fileID);
tline = fgets(fileID);
strongs = [];

while ischar(tline)
    data = (strtrim(tline));
    strongs = [strongs;convertCharsToStrings(data)];
    tline = fgets(fileID);
end
fclose(fileID);
%% looping to generate the canonical forms of each strong

canonical_strong = [];

for i = 1:size(strongs,1)
    i
    A = generate_canonical_strong(string(strongs(i,1)));
    canonical_strong = [canonical_strong;A];    
end

%% writing canonical STRONGs in a text file

fileID = fopen('canonical_strongs.txt','w');
fprintf(fileID,'%s \n','canonical strongs');

for i = 1:size(canonical_strong,1)
    fprintf(fileID,'%s \n',canonical_strong(i,1));
end

%%