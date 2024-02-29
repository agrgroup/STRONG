clc
clear all
close all
%% selecting the xyz file to be functionalized
cd ..
addpath('matlab_files')
cd pore_xyz_file
d = pwd;

% storing the xyz file details in files variable
files = dir(fullfile(d, '*.xyz'));
bond_length = 1.09;
group = 'H';

%% Finding the STRONGS and sequence of rim atoms of the xyz file
for i = 1:size(files,1)
    i
    [strongs,sequence] = xyz_to_strongs(files(i).name, d);
    functionalization(files(i).name,strongs,sequence,group,bond_length,d)
    
end

%%

