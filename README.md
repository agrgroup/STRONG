# STRONG: STring Representation of Nanopore Geometry

### Machine Learnable and Rapidly Interpretable Language for Nanopores Enables Structure-Property Relationships in Nanoporous 2D Materials
> Piyush Sharma, Sneha Thomas, Mahika Nair, and Ananth Govind Rajan

## Contents
This repository contains the necessary MATLAB/Python scripts for storing, manipulating, and comparing nanopores in graphene using a new language framework called STring Representations of Nanopore Geometry (STRONGs). These scripts enable the following tasks:

## Generating the STRONG for an XYZ file
Input: XYZ files (XYZ_to_STRONG/xyz_file/*.xyz) <br>
Output: STRONGs (XYZ_to_STRONG/text_files/STRONGS.txt)

All the XYZ files must be kept in the xyz_file folder in the XYZ_to_STRONG sub-directory. The main.m (XYZ_to_STRONG/matlab_files/main.m) MATLAB script converts the XYZ files in the directory "XYZ_to_STRONG/xyz_file" to STRONGs. The output is written in TXT format in the "XYZ_to_STRONG/text_files" directory.
Note that the unique dataset of nanopores generated by removing N=4 to N=22 atoms from the lattice of graphene nanopores using the KMC code developed by Sheshanarayana and Govind Rajan (https://doi.org/10.1063/5.0089469) can be found at https://indianinstituteofscience-my.sharepoint.com/:f:/g/personal/ananthgr_iisc_ac_in/EsyPYelDqENIsCDRVqW-OrYB7MFkOm7Vwm4X6gwKJpqZnw?e=tKfvL3.

## Comparing Nanopores
Input: xyz files (Comparing_Nanopores/xyz_file/*.xyz) <br>
Output: Unique STRONGs (Comparing_Nanopores/text_files/unique_pore_subset.txt)

The XYZ files to be compared are kept in the xyz_file folder in the Comparing_Nanopores sub-directory. The main.m (Comparing_Nanopores/matlab_files/main.m) MATLAB script is used to compare nanopores (xyz files) present in the directory "Comparing_Nanopores/xyz_file". The information regarding the unique number of XYZ files is stored in the TXT format in the "Comparing_Nanopores/text_files" directory.

## Converting STRONGs to Canonical STRONGs
Input: STRONGs (STRONG_to_Canonical_STRONG/STRONGS.txt) <br>
Output: Canonical STRONGs (STRONG_to_Canonical_STRONG/canonical_strongs.txt)

The STRONGs are converted to canonical STRONGs, used as a feature in the machine learning (ML) model using the main.m (STRONG_to_Canonical_STRONG/main.m) MATLAB script. The STRONGs to be canonicalized are kept as a text file in the STRONG_to_Canonical_STRONG directory. Canonicalized STRONGs i.e., an output of the MATLAB script, is present as a text file in STRONG_to_Canonical_STRONG directory. 

## Machine Learning for Structure-Property Relationships
Input: CSV files (Machine_Learning/input/*.csv) <br>
Output: Parity plots (Machine_Learning/figures/formation_time/parity_plot.png, Machine_Learning/figures/formation_energy/parity_plot.png, Machine_Learning/figures/CO2_barrier_1/parity_plot.png)

Jupyter notebooks for formation time (Machine_Learning/ft_canonical_STRONGs.ipynb), formation energy (Machine_Learning/fe_canonical_STRONGs.ipynb), and CO2 gas permeation barrier (Machine_Learning/barrier_CO2_canonical_STRONGs_radius_feature_1.ipynb) are run to obtain the ML performance matrix and the parity plot present in the figures sub-directory for each structure-property.  

## Enumerating Stable Nanopores
Input: "N" number of atoms to be removed from the graphene nanopore lattice (STRONG_Enumeration/stable_nanopores.m) <br>
Output: enumerated STRONGs and time of enumeration (STRONG_Enumeration/enumerated_strongs.txt, STRONG_Enumeration/enumerated_strongs_time.txt)

The user needs to input "N", i.e., the number of atoms removed from the graphene lattice in the stable_nanopores.m (STRONG_Enumeration/stable_nanopores.m) MATLAB script before executing the script file. The enumerated STRONGs are stored in the enumerated_strongs.txt file, and the time of enumeration is stored in enumerated_strongs_time.txt file. 

## Converting STRONGs to XYZ
Input: STRONGs (STRONG_to_XYZ/strongs.txt) <br>
Output: XYZ files (STRONG_to_XYZ/*.xyz)

The STRONGs to be converted to XYZ files are stored in a text file (STRONG_to_XYZ/strongs.txt). The strong_to_xyz.m (STRONG_to_XYZ/strong_to_xyz.m) MATLAB script can be run to generate all the XYZ files corresponding to each STRONG. 

## XYZ to functionalized STRONG
Input: XYZ file (XYZ_to_FunctionalizedXYZ/pore_xyz_file/*.xyz) <br>
Output: XYZ files (STRONG_to_XYZ/functional_xyz/*.xyz)

An input XYZ file for which all the possible functionalized XYZ files are to be generated is placed in the pore_xyz_file sub-directory (XYZ_to_FunctionalizedXYZ/pore_xyz_file/*.xyz). The main.m (XYZ_to_FunctionalizedXYZ/matlab_files/main.m) MATLAB script is executed to generate all the functionalized XYZ files stored in the functional_xyz (XYZ_to_FunctionalizedXYZ/functional_xyz) sub-directory generated after the execution of the MATLAB script.
