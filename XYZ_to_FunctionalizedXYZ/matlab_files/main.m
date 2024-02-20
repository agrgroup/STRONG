clc 
close all 
clc


%% Selecting the xyz file to be functionalized
cd ..
addpath('matlab_files')
cd pore_xyz_file
d = pwd;

% storing the xyz file details in files variable
files = dir(fullfile(d, '*.xyz'));

%% Finding the STRONGS and sequence of rim atoms of the xyz file
[strongs,sequence,coords, element] = xyz_to_strongs(files(1).name,d);
disp('strong of the pore is generated')

%% finding the unique position to functionalize the pore
functional_groups = ["H";"X";"O"]; % user input X here denotes a 2 atom functional groups such as OH (hydroxl group);"N";"O"

[func_strongs, n_functional_groups] = xyz_to_functionalization(strongs, functional_groups);
[n_functional_groups_unique, ~, unique_occurence] = unique(n_functional_groups, 'rows');

disp('funcitonal strongs generated')
%% reducing to unique functionalized STRONGs using symmetry operations
unique_func_strongs = symmetry_operations(func_strongs, functional_groups, unique_occurence);

%% creating the xyz files after finding unique strings
% user input - bond distances (in Angstroms)
bond_CH = 1.09;
bond_CO = 1.36;
bond_OH = 0.98;
bond_CN = 1.47;
bond_CO1 = 1.26;

cd functional_xyz

for i = 1:size(unique_func_strongs,1)
    func_strongs_to_xyz(unique_func_strongs(i,1), sequence, coords, element, bond_CH, bond_CO, bond_OH, bond_CN, bond_CO1, i) 
end
%%





