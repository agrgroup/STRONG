clc
close all
clear all

%% adding matlab_files folder on path of matlab
current_folder = pwd;
addpath(current_folder)
%% removing Ri, Re, ZZ, AC, UA  and SB atoms and generating a file
tic
folder_list = [4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22];

for i = 1:size(folder_list,1)
    new_directory = strcat(current_folder,'\pore',num2str(folder_list(i,1)));
    remove_Ri_atoms(folder_list(i,1), new_directory);
    cd (current_folder)
end
toc
%%


