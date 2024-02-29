clc
clear all
close all

%%
cd ..
addpath('matlab_files')
path_fold = pwd;
cd pore_xyz_file
d = pwd;

% storing the xyz file details in files variable
files = dir(fullfile(d, '*.xyz'));

file_size = 15000;

%%

folder_number = 1;

for i=1:size(files,1)
    i
    if (rem(i,file_size) == 0)
        folder_number = folder_number + 1;
    end
    
    source = strcat(d,'\', string(i),'.xyz');
    destination = strcat(path_fold,'\', 'folder_', string(folder_number));
    copyfile (source,destination)
    
end