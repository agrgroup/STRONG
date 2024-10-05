# STRONG: STring Representation of Nanopore Geometry

### Machine Learnable Language for the Chemical Space of Nanopores Enables Structure-Property Relationships in Nanoporous 2D Materials
> Piyush Sharma, Sneha Thomas, Mahika Nair, and Ananth Govind Rajan

## Contents
This repository contains the necessary MATLAB/Python scripts for developing structure-property relationships, enumerating stable graphene nanopores, and for storing, manipulating, and comparing nanopores in graphene using a new language framework called STring Representations of Nanopore Geometry (STRONGs). These scripts enable the following tasks:

## Generating the STRONG for an XYZ file
Input: XYZ files (XYZ_to_STRONG/xyz_file/*.xyz) <br>
Output: STRONGs (XYZ_to_STRONG/text_files/STRONGS.txt)

All the XYZ files must be kept in the xyz_file folder in the XYZ_to_STRONG sub-directory. The main.m (XYZ_to_STRONG/matlab_files/main.m) MATLAB script generates the STRONGs corresponding to the XYZ files in the directory "XYZ_to_STRONG/xyz_file." The output is written in TXT format in the "XYZ_to_STRONG/text_files" directory. We have provided an example set of 100 XYZ files in the "XYZ_to_STRONG/xyz_file" directory. 
Note that the unique dataset of nanopores (# of unique nanopores = 20812) was generated by removing N=4 to N=22 atoms from the lattice of graphene nanopores using the KMC code developed by Sheshanarayana and Govind Rajan [1] used to create the dataset for formation time and energy can be provided to the user on a reasonable request. The XYZ files of stable nanopores (# of stable nanopores = 24884) used to generate the dataset for the gas permeation barrier can be provided to the user at a reasonable request. 

## Comparing Nanopores
Input: xyz files (Comparing_Nanopores/xyz_file/*.xyz) <br>
Output: Unique STRONGs (Comparing_Nanopores/text_files/unique_pore_subset.txt)

The XYZ files to be compared are kept in the xyz_file folder in the Comparing_Nanopores sub-directory. The main.m (Comparing_Nanopores/matlab_files/main.m) MATLAB script is used to compare nanopores (xyz files) present in the directory "Comparing_Nanopores/xyz_file." The information regarding the unique number of XYZ files is stored in the TXT format in the "Comparing_Nanopores/text_files" directory. For example, 50 xyz files (or nanopore structures) exist in the xyz_file directory. Three unique nanopore structures (1, 10, and 14) are shown in the unique_pore_subset.txt. Any other structure is either a rotational or reflectional image of these unique structures. 
Note that the graphene nanopores (# of nanopores for each N = 10000) generated using the KMC code (developed by Sheshanarayana and Govind Rajan [1]) by removing N=4 to N=22 atoms from the lattice of graphene nanopores can be provided to the user on a reasonable request. 

## Converting STRONGs to Canonical STRONGs
Input: STRONGs (STRONG_to_Canonical_STRONG/STRONGS.txt) <br>
Output: Canonical STRONGs (STRONG_to_Canonical_STRONG/canonical_strongs.txt)

The STRONGs are converted to canonical STRONGs, which are used as a feature in the machine learning (ML) model using the main.m (STRONG_to_Canonical_STRONG/main.m) MATLAB script. The STRONGs to be canonicalized are kept as a text file in the “STRONG_to_Canonical_STRONG” directory. Canonicalized STRONGs, i.e., an output of the MATLAB script, is present as a text file in the “STRONG_to_Canonical_STRONG” directory. 

## Machine Learning for Structure-Property Relationships
Input: CSV files (Machine_Learning/input/*.csv) <br>
Output: Trained model for formation time, formation energy, and gas diffusion barriers for CO2, O2, and N2 (Machine_Learning/output/)

Jupyter notebooks for formation time (Machine_Learning/ft_canonical_STRONGs.ipynb, Machine_Learning/ft_canonicalstrongs_timeconstraint.ipynb, Machine_Learning/ft_stable_canonicalstrongs.ipynb), formation energy (Machine_Learning/fe_canonical_STRONGs.ipynb, Machine_Learning/fe_stable_canonicalstrongs.ipynb, Machine_Learning/fe_energyconstraint.ipynb), and gas diffusion barrier for CO2 (Machine_Learning/barrier_CO2_StableSTRONGs_finaldata2.ipynb), N2 (Machine_Learning/barrier_N2_StableSTRONGs_finaldata2.ipynb), and O2 (Machine_Learning/barrier_O2_StableSTRONGs_finaldata2.ipynb) are run to obtain the ML performance matrix and the parity plots. All the trained models are saved and can be accessed in the "Machine_Learning/output" directory.  

## Enumerating Stable Nanopores
Input: "N" number of atoms to be removed from the graphene nanopore lattice (STRONG_Enumeration/stable_nanopores.m) <br>
Output: enumerated STRONGs and time of enumeration (STRONG_Enumeration/enumerated_strongs.txt, STRONG_Enumeration/enumerated_strongs_time.txt)

The user must input "N," i.e., the number of atoms removed from the graphene lattice in the stable_nanopores.m (STRONG_Enumeration/stable_nanopores.m) MATLAB script before executing the script file. The enumerated STRONGs are stored in the enumerated_strongs.txt file, and the time of enumeration is stored in the “enumerated_strongs_time.txt” file. 

## Converting STRONGs to XYZ
Input: STRONGs (STRONG_to_XYZ/strongs.txt) <br>
Output: XYZ files (STRONG_to_XYZ/*.xyz)

The STRONGs to be converted to XYZ files are stored in a text file (STRONG_to_XYZ/strongs.txt). The strong_to_xyz.m (STRONG_to_XYZ/strong_to_xyz.m) MATLAB script can generate all the XYZ files corresponding to each STRONG. 

## XYZ to functionalized XYZ
Input: XYZ file (XYZ_to_FunctionalizedXYZ/pore_xyz_file/*.xyz) <br>
Output: XYZ files (STRONG_to_XYZ/functional_xyz/*.xyz)

An input XYZ file for which all the possible functionalized XYZ files are to be generated is placed in the pore_xyz_file sub-directory (XYZ_to_FunctionalizedXYZ/pore_xyz_file/*.xyz). The main.m (XYZ_to_FunctionalizedXYZ/matlab_files/main.m) MATLAB script is executed to generate all the functionalized XYZ files stored in the functional_xyz (XYZ_to_FunctionalizedXYZ/functional_xyz) sub-directory generated after the execution of the MATLAB script. 

## XYZ to H functionalized XYZ
Input: XYZ file (H_func_xyz_file/pore_xyz_file/*.xyz) <br>
Output: XYZ files (H_func_xyz_file/pore_xyz_file/H_fun_xyz_file/pore_H_*.xyz)

All the XYZ files must be kept in the pore_xyz_file folder in the H_func_xyz_file/pore_xyz_file directory. The main.m (H_func_xyz_file/matlab_files/main.m) MATLAB script generates the H functionalized XYZ files in the directory "H_func_xyz_file/pore_xyz_file/H_fun_xyz_file" after the execution of the MATLAB script.

## References
[1] Sheshanarayana, R.; Govind Rajan, A. Tailoring Nanoporous Graphene via Machine Learning: Predicting Probabilities and Formation Times of Arbitrary Nanopore Shapes. J. Chem. Phys. 2022, 156 (20), 204703. https://doi.org/10.1063/5.0089469.
Source Code:  https://github.com/agrgroup/MLforNanopores.
