clc
close all
clear all

%% adding matlab_files folder on path of matlab
cd ..
addpath('matlab_files')
%% generating strongs
tic
generate_strongs()
disp('STRONGS have been generated in ')
toc 
%% implementing symmetry operations to obtain unique xyz files
%tic
%unique_strongs()
%disp('unique files generated')
%toc

%% implementing symmetry operation to obtain rotational and reflectional file combinations
% tic
% symmetric_cases()
% disp('symmetric cases completed')
% toc
%%


