# STRONG

### Machine Learnable and Rapidly Interpretable Language for Nanopores Enables Strucutre-Property Relationships in Nanoporous 2D Materials
> Piyush Sharma, Sneha Thomas, Mahika Nair, and Ananth GovindRajan

## Contents
This repository contains the necessary MATLAB/Python scripts for the following tasks:

## Generating STRONGs for an XYZ file
Input- xyz files (XYZ_to_STRONG/xyz_file/*.xyz) <br>
Output- STRONGS (XYZ_to_STRONG/text_files/STRONGS.txt)

All the xyz files must be kept in the xyz_file folder in the XYZ_to_STRONG sub-directory. main.m (XYZ_to_STRONG/matlab_files/main.m) MATLAB script converts XYZ files present in the directory "XYZ_to_STRONG/xyz_file" to STRONGs. Output is stored in the txt format present in the "XYZ_to_STRONG/text_files" directory.
Note that, the complete dataset generated by removing N=4 to N=22 atoms from the lattice of graphene nanopores using the kMC code developed by Sheshanarayana and GovindRajan (https://doi.org/10.1063/5.0089469) can be found at .

## Comparing Nanopores
Input- xyz files (Comparing_Nanopores/xyz_file/*.xyz) <br>
Output- STRONGS (Comparing_Nanopores/text_files/unique_pore_subset.txt)

The xyz files to be compared are kept in the xyz_file folder in the Comparing_Nanopores sub-directory. main.m (Comparing_Nanopores/matlab_files/main.m) MATLAB script is used to compare nanopores (xyz files) present in the directory "Comparing_Nanopores/xyz_file". The information regarding the unique number of xyz files is stored in the txt format present in the "Comparing_Nanopores/text_files" directory.

## Converting STRONGs to Canonical STRONGs
Input- STRONGs (STRONG_to_Canonical_STRONG/STRONGS.txt) <br>
Output- Canonical STRONGS (STRONG_to_Canonical_STRONG/canonical_strongs.txt)

The STRONGs is converted to canonical STRONGs which is used as a feature in machine learning (ML) model using the main.m (STRONG_to_Canonical_STRONG/main.m) MATLAB script. The STRONGs to be canonicalized are kept as a text file in the STRONG_to_Canonical_STRONG directory. Canonicalized STRONGs i.e., an output of the MATLAB script is present as an text file in STRONG_to_Canonical_STRONG directory. 

## Machine Learning for strucutre-property relationship
Input- csv files (Machine_Learning/input/*.csv) <br>
Output- parity plots (Machine_Learning/figures/formation_time/parity_plot.png, Machine_Learning/figures/formation_energy/parity_plot.png, Machine_Learning/figures/CO2_barrier_1/parity_plot.png)

Jupyter notebooks for formation time (Machine_Learning/ft_canonical_STRONGs.ipynb), formation energy (Machine_Learning/fe_canonical_STRONGs.ipynb), and CO2 gas permeation barrier (Machine_Learning/barrier_CO2_canonical_STRONGs_radius_feature_1.ipynb) are run to obtain the ML performance matrix and parity plot present in the figures sub-directory for each structure-property.  

## Enumerating stable nanopores
Input- "N" number of atoms to be removed from the graphene nanopore lattice (STRONG_Enumeration/stable_nanopores.m) <br>
Output- enumerated STRONGs and time of enumeration (STRONG_Enumeration/enumerated_strongs.txt, STRONG_Enumeration/enumerated_strongs_time.txt)

The user need to input "N" number of atoms removed from the grahene lattice in the stable_nanopores.m (STRONG_Enumeration/stable_nanopores.m) MATLAB script before executing the script file. The enumerated STRONGs are stored in enumerated_strongs.txt file and the time of enumeration is stored in enumerated_strongs_time.txt file. 

## Converting STRONGs to XYZ
Input- STRONGs (STRONG_to_XYZ/strongs.txt) <br>
Output- XYZ files (STRONG_to_XYZ/*.xyz)

STRONGs to be converted to XYZ files are strored in a text file (STRONG_to_XYZ/strongs.txt). Run the strong_to_xyz.m (STRONG_to_XYZ/strong_to_xyz.m) MATLAB script to generate all the XZY files corrsponding to each STRONG. 

## XYZ to functionalized STRONG
Input- XYZ file (XYZ_to_FunctionalizedXYZ/pore_xyz_file/*.xyz) <br>
Output- XYZ files (STRONG_to_XYZ/functional_xyz/*.xyz)

A input XYZ file for which the all the possible functionalized XYZ files to be generated is placed in the pore_xyz_file sub-directory (XYZ_to_FunctionalizedXYZ/pore_xyz_file/*.xyz). The main.m (XYZ_to_FunctionalizedXYZ/matlab_files/main.m) MATLAB script is executed to generate all the functionlized XYZ files stored in the functional_xyz (XYZ_to_FunctionalizedXYZ/functional_xyz) sub-directory generated after the execution of the MATLAB script.  




