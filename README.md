# STRONG

### Machine Learnable and Rapidly Interpretable Language for Nanopores Enables Strucutre-Property Relationships in Nanoporous 2D Materials
> Piyush Sharma, Sneha Thomas, Mahika Nair, and Ananth GovindRajan

## Contents
This repository contains the necessary MATLAB/Python scripts for the following tasks:

## Generating STRONGs for an XYZ file
Input- xyz files (XYZ_to_STRONG/xyz_file/*.xyz) <br>
Output- STRONGS (XYZ_to_STRONG/text_files/STRONGS.txt)

All the xyz files need to be kept in the xyz_file folder in the XYZ_to_STRONG sub-directory. main.m (XYZ_to_STRONG/matlab_files/main.m) MATLAB script is used to convert XYZ files present in the directory "XYZ_to_STRONG/xyz_file" to STRONGs. Output is stored in the txt format present in "XYZ_to_STRONG/text_files" directory.
Note that, the complete dataset generated for N=4 to N=22 using the kMC code developed by Sheshnarayan and GovindRajan () can be found at .

## Comparing Nanopores
Input- xyz files (Comparing_Nanopores/xyz_file/*.xyz) <br>
Output- STRONGS (Comparing_Nanopores/text_files/unique_pore_subset.txt)

The xyz files to be compared are kept in the xyz_file folder in the Comparing_Nanopores sub-directory. main.m (Comparing_Nanopores/matlab_files/main.m) MATLAB script is used to compare nanopores (xyz files) present in the directory "Comparing_Nanopores/xyz_file". The information regaridng the unique number of xyz files is stored in the txt format present in "Comparing_Nanopores/text_files" directory.

## Converting STRONGs to Canonical STRONGs
Input- STRONGs (STRONG_to_Canonical_STRONG/STRONGS.txt) <br>
Output- Canonical STRONGS (STRONG_to_Canonical_STRONG/canonical_strongs.txt)

The STRONGs is converted to canonical STRONGs which is used as an feature for machine learning (ML) model using the main.m (STRONG_to_Canonical_STRONG/main.m) MATLAB script. The STRONGs to be canonicalized are kept as a text file in the STRONG_to_Canonical_STRONG directory. Canonicalized STRONGs i.e., an output of the MATLAB script is present as an text file in STRONG_to_Canonical_STRONG directory. 

## Machine Learning for strucutre-property relationship
Input- csv files (Machine_Learning/input/*.csv) <br>
Output- parity plots (Machine_Learning/figures/formation_time/parity_plot.png, Machine_Learning/figures/formation_energy/parity_plot.png, Machine_Learning/figures/CO2_barrier_1/parity_plot.png)




