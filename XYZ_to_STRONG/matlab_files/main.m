clc
close all
clear all

%% adding matlab_files folder on path of matlab
cd ..
addpath('matlab_files')
%% generating strongs
tic
generate_strongs()
disp('STRONGS have been generated in')
toc 



