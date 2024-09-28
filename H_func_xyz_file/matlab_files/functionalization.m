function functionalization(porexyzfilename,strongs,sequence,group,bond_length,d)

%% Reading the xyz files to get element and coords

%opening the xyz file and reading the first line
fid = fopen(porexyzfilename,'r');
tline = fgets(fid);
% variable to count
count=0;
% matrix to store coordinates of each atoms ('C' and 'Q' for this case)
coords = [];
% vector to store the type of atoms corresponding the the coordinates
element = [];

% reading the coordinates and elements respectively for each atom
while ischar(tline)
    % keeping the count of lines
    count=count+1;
    % reads from line 3 in the xyz file 
    if (count>2)
       data = strtrim(strsplit(strtrim(tline),'\t'));
       element = [element;cell2mat(data(1))];
       coords = [coords; str2double(cell2mat(data(2))), str2double(cell2mat(data(3))), str2double(cell2mat(data(4)))];
    end
    tline = fgets(fid);
end
fclose(fid);

element = string(element);

%% updating the name of the rim atoms as CR and and H functionalized C as CH
str = (convertStringsToChars(strongs))';
for i = 1:size(str,1)
    if (str(i,1) == 'Z' || str(i,1) == 'A' || str(i,1) == 'C' || str(i,1) == 'S')
        rim_index = sequence (i,1);
        element(rim_index,1) = "CH";
    else
        rim_index = sequence (i,1);
        element(rim_index,1) = "CR";
    end
end

%% Adding the Functionalized Group and writing a POSCAR file 
functionalized_coords = coords;
functionalized_element = element;

coords_dummy = [];

for i = 1:size(str,1)
    if (str(i,1) == 'Z' || str(i,1) == 'A' || str(i,1) == 'C' || str(i,1) == 'S')
        index_fun_atom = sequence(i,1);
        if (i == 1)
            index_fun_atom_left = sequence(size(sequence,1),1);
            index_fun_atom_right = sequence(i+1,1);
            row_left = size(sequence,1);
            row_right = i+1;
        elseif (i == size(sequence,1))
            index_fun_atom_left = sequence(i-1,1);
            index_fun_atom_right = sequence(1,1);
            row_left = i-1;
            row_right = 1;
        else
            index_fun_atom_left = sequence(i-1,1);
            index_fun_atom_right = sequence(i+1,1);
            row_left = i-1;
            row_right = i+1;
        end
        
        slope_base = ((coords(index_fun_atom_right,2) - coords(index_fun_atom_left,2))/(coords(index_fun_atom_right,1) - coords(index_fun_atom_left,1)));
        
        if (slope_base~=0)
            slope_perpendicular = -1/slope_base; 
            coords_dummy = [coords_dummy;[coords(index_fun_atom,1)+(bond_length(1,1)/sqrt(1+slope_perpendicular^2)), coords(index_fun_atom,2)+((bond_length(1,1)*slope_perpendicular)/sqrt(1+slope_perpendicular^2)),coords(index_fun_atom,3)]];
            coords_dummy = [coords_dummy;[coords(index_fun_atom,1)-(bond_length(1,1)/sqrt(1+slope_perpendicular^2)), coords(index_fun_atom,2)-((bond_length(1,1)*slope_perpendicular)/sqrt(1+slope_perpendicular^2)),coords(index_fun_atom,3)]];    
        else
            coords_dummy = [coords_dummy;[coords(index_fun_atom,1), coords(index_fun_atom,2) + bond_length(1,1),coords(index_fun_atom,3)]];
            coords_dummy = [coords_dummy;[coords(index_fun_atom,1), coords(index_fun_atom,2) - bond_length(1,1),coords(index_fun_atom,3)]];
        end
        
        row = i;
        
        x_vector = coords(sequence(row_left,1),1)-coords(sequence(row,1),1);
        y_vector = coords(sequence(row_left,1),2)-coords(sequence(row,1),2);
                
        x_vector_1 = coords_dummy(1,1)-coords(sequence(row,1),1);
        y_vector_1 = coords_dummy(1,2)-coords(sequence(row,1),2);
                
        x_vector_2 = coords_dummy(2,1)-coords(sequence(row,1),1);
        y_vector_2 = coords_dummy(2,2)-coords(sequence(row,1),2);
                
        angle_1 = atan2d(x_vector*y_vector_1-y_vector*x_vector_1,x_vector*x_vector_1+y_vector*y_vector_1);
        angle_2 = atan2d(x_vector*y_vector_2-y_vector*x_vector_2,x_vector*x_vector_2+y_vector*y_vector_2);
        
        if (abs(angle_1)>90)
            functionalized_coords = [functionalized_coords;[coords_dummy(1,1),coords_dummy(1,2),coords_dummy(1,3)]];
            functionalized_element = [functionalized_element;group(1,1)];
        elseif(abs(angle_2)>90)
            functionalized_coords = [functionalized_coords;[coords_dummy(2,1),coords_dummy(2,2),coords_dummy(2,3)]];
            functionalized_element = [functionalized_element;group(1,1)];
        end
    end
    coords_dummy = [];
end

%% writing a xyz file
    
new_folder = strcat(d,'\','H_fun_xyz_file');
cd (new_folder)

H_pore_filename = porexyzfilename;
%H_pore_filename(:,[1:4]) = [];
%H_pore_filename(:,[end-3:end]) = [];

% writing xyz file
fileID = fopen(strcat('pore_H_',string(H_pore_filename)),'w');%,'.xyz'
fprintf(fileID,'%d \n',size(functionalized_element,1));
str_head = sprintf('H_Functionalization');
fprintf(fileID,'%s \n',str_head);

for m = 1:size(functionalized_coords,1)
    fprintf(fileID,'%s \t %.6f \t %.6f \t %.6f \n',functionalized_element(m,1),functionalized_coords(m,1), functionalized_coords(m,2), functionalized_coords(m,3));
end

fclose(fileID);
cd (d)
end