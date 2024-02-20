function func_strongs_to_xyz(func_strong, sequence, coords, element, bond_CH, bond_CO, bond_OH, bond_CN, bond_CO1, file_number)

func_strong = (char(func_strong))';
counter = 0;
func_coords = coords;
func_element = element;

N_atoms = size(coords,1);
atoms_counter = N_atoms;

coords_dummy = [];

for i = 1:size(func_strong,1)
    if (func_strong (i,1) == 'F' || func_strong (i,1) == 'Z' || func_strong (i,1) == 'A' || func_strong (i,1) == 'C')
        counter = counter + 1;
    else
        if (func_strong (i,1) == 'X') % X represnts a hydroxl functional group here, user can edit this code based on their convenience
            % adding O to the functionalized coords and functionalized elements
            if (counter == 1)
                counter_left = size(sequence,1);
                counter_right = counter + 1;
            elseif (counter == size(sequence,1))
                counter_left = counter-1;
                counter_right = 1;
            else
                counter_left = counter-1;
                counter_right= counter+1;
            end
            
            index_fun_atom = sequence (counter,1);
            index_fun_atom_left = sequence(counter_left,1);
            index_fun_atom_right = sequence(counter_right,1);
            
            slope_base = ((coords(index_fun_atom_right,2) - coords(index_fun_atom_left,2))/(coords(index_fun_atom_right,1) - coords(index_fun_atom_left,1)));
            if (slope_base~=0)
                slope_perpendicular = -1/slope_base; 
                coords_dummy = [coords_dummy;[coords(index_fun_atom,1)+(bond_CO(1,1)/sqrt(1+slope_perpendicular^2)), coords(index_fun_atom,2)+((bond_CO(1,1)*slope_perpendicular)/sqrt(1+slope_perpendicular^2)),coords(index_fun_atom,3)]];
                coords_dummy = [coords_dummy;[coords(index_fun_atom,1)-(bond_CO(1,1)/sqrt(1+slope_perpendicular^2)), coords(index_fun_atom,2)-((bond_CO(1,1)*slope_perpendicular)/sqrt(1+slope_perpendicular^2)),coords(index_fun_atom,3)]];    
            else
                coords_dummy = [coords_dummy;[coords(index_fun_atom,1), coords(index_fun_atom,2) + bond_CO(1,1),coords(index_fun_atom,3)]];
                coords_dummy = [coords_dummy;[coords(index_fun_atom,1), coords(index_fun_atom,2) - bond_CO(1,1),coords(index_fun_atom,3)]];
            end
            
            x_vector = coords(sequence(counter_left,1),1)-coords(sequence(counter,1),1);
            y_vector = coords(sequence(counter_left,1),2)-coords(sequence(counter,1),2);
                
            x_vector_1 = coords_dummy(1,1)-coords(sequence(counter,1),1);
            y_vector_1 = coords_dummy(1,2)-coords(sequence(counter,1),2);
                
            x_vector_2 = coords_dummy(2,1)-coords(sequence(counter,1),1);
            y_vector_2 = coords_dummy(2,2)-coords(sequence(counter,1),2);
                
            angle_1 = atan2d(x_vector*y_vector_1-y_vector*x_vector_1,x_vector*x_vector_1+y_vector*y_vector_1);
            angle_2 = atan2d(x_vector*y_vector_2-y_vector*x_vector_2,x_vector*x_vector_2+y_vector*y_vector_2);
            
            if (abs(angle_1)>90)
                func_coords = [func_coords;[coords_dummy(1,1),coords_dummy(1,2),coords_dummy(1,3)]];
                func_element = [func_element;'O'];
            elseif(abs(angle_2)>90)
                func_coords = [func_coords;[coords_dummy(2,1),coords_dummy(2,2),coords_dummy(2,3)]];
                func_element = [func_element;'O'];
            end
            
            atoms_counter = atoms_counter + 1;
            
            % adding H atom to make it a hydroxyl group
            coords_O_atom = [func_coords(end,1), func_coords(end,2), func_coords(end,3)];
            coords_C_atom = [coords(index_fun_atom,1), coords(index_fun_atom,2), coords(index_fun_atom,3)];
            
            vector_CO = [(coords_O_atom (1,1) - coords_C_atom(1,1)); (coords_O_atom (1,2) - coords_C_atom(1,2))];
            angle_CO_OH = 45;
            
            quadratic_a = ((vector_CO(1,1)/vector_CO(2,1))^2) + 1;
            quadratic_b = -2*((bond_CO(1,1)*bond_OH(1,1)*cos(deg2rad(angle_CO_OH)))/vector_CO(2,1))*(vector_CO(1,1)/vector_CO(2,1));
            quadratic_c = ((((bond_CO(1,1)*cos(deg2rad(angle_CO_OH)))/vector_CO(2,1))^2)-1)*bond_OH(1,1)^2;
            
            quadratic_root = roots([quadratic_a,quadratic_b,quadratic_c]);
            
            coords_H_atom = [coords_O_atom(1,1)+quadratic_root(1,1), coords_O_atom(1,2)+((bond_CO(1,1)*bond_OH(1,1)*cos(deg2rad(angle_CO_OH)))/vector_CO(2,1))-((quadratic_root(1,1))*(vector_CO(1,1)/vector_CO(2,1))), coords_O_atom(1,3);...
                             coords_O_atom(1,1)+quadratic_root(2,1), coords_O_atom(1,2)+((bond_CO(1,1)*bond_OH(1,1)*cos(deg2rad(angle_CO_OH)))/vector_CO(2,1))-((quadratic_root(2,1))*(vector_CO(1,1)/vector_CO(2,1))), coords_O_atom(1,3)];
            
            % adding H atom always to the right
            func_coords = [func_coords;[coords_H_atom(2,1),coords_H_atom(2,2),coords_H_atom(2,3)]];
            func_element = [func_element;'H'];
            
            atoms_counter = atoms_counter + 1;
            
        elseif (func_strong (i,1) == 'H')
            if (counter == 1)
                counter_left = size(sequence,1);
                counter_right = counter + 1;
            elseif (counter == size(sequence,1))
                counter_left = counter-1;
                counter_right = 1;
            else
                counter_left = counter-1;
                counter_right= counter+1;
            end
            
            index_fun_atom = sequence (counter,1);
            index_fun_atom_left = sequence(counter_left,1);
            index_fun_atom_right = sequence(counter_right,1);
            
            slope_base = ((coords(index_fun_atom_right,2) - coords(index_fun_atom_left,2))/(coords(index_fun_atom_right,1) - coords(index_fun_atom_left,1)));
            if (slope_base~=0)
                slope_perpendicular = -1/slope_base; 
                coords_dummy = [coords_dummy;[coords(index_fun_atom,1)+(bond_CH(1,1)/sqrt(1+slope_perpendicular^2)), coords(index_fun_atom,2)+((bond_CH(1,1)*slope_perpendicular)/sqrt(1+slope_perpendicular^2)),coords(index_fun_atom,3)]];
                coords_dummy = [coords_dummy;[coords(index_fun_atom,1)-(bond_CH(1,1)/sqrt(1+slope_perpendicular^2)), coords(index_fun_atom,2)-((bond_CH(1,1)*slope_perpendicular)/sqrt(1+slope_perpendicular^2)),coords(index_fun_atom,3)]];    
            else
                coords_dummy = [coords_dummy;[coords(index_fun_atom,1), coords(index_fun_atom,2) + bond_CH(1,1),coords(index_fun_atom,3)]];
                coords_dummy = [coords_dummy;[coords(index_fun_atom,1), coords(index_fun_atom,2) - bond_CH(1,1),coords(index_fun_atom,3)]];
            end
            
            x_vector = coords(sequence(counter_left,1),1)-coords(sequence(counter,1),1);
            y_vector = coords(sequence(counter_left,1),2)-coords(sequence(counter,1),2);
                
            x_vector_1 = coords_dummy(1,1)-coords(sequence(counter,1),1);
            y_vector_1 = coords_dummy(1,2)-coords(sequence(counter,1),2);
                
            x_vector_2 = coords_dummy(2,1)-coords(sequence(counter,1),1);
            y_vector_2 = coords_dummy(2,2)-coords(sequence(counter,1),2);
                
            angle_1 = atan2d(x_vector*y_vector_1-y_vector*x_vector_1,x_vector*x_vector_1+y_vector*y_vector_1);
            angle_2 = atan2d(x_vector*y_vector_2-y_vector*x_vector_2,x_vector*x_vector_2+y_vector*y_vector_2);
            
            if (abs(angle_1)>90)
                func_coords = [func_coords;[coords_dummy(1,1),coords_dummy(1,2),coords_dummy(1,3)]];
                func_element = [func_element;func_strong(i,1)];
            elseif(abs(angle_2)>90)
                func_coords = [func_coords;[coords_dummy(2,1),coords_dummy(2,2),coords_dummy(2,3)]];
                func_element = [func_element;func_strong(i,1)];
            end
            
            atoms_counter = atoms_counter + 1;  
        
        elseif (func_strong (i,1) == 'N')
            if (counter == 1)
                counter_left = size(sequence,1);
                counter_right = counter + 1;
            elseif (counter == size(sequence,1))
                counter_left = counter-1;
                counter_right = 1;
            else
                counter_left = counter-1;
                counter_right= counter+1;
            end
            
            index_fun_atom = sequence (counter,1);
            index_fun_atom_left = sequence(counter_left,1);
            index_fun_atom_right = sequence(counter_right,1);
            
            slope_base = ((coords(index_fun_atom_right,2) - coords(index_fun_atom_left,2))/(coords(index_fun_atom_right,1) - coords(index_fun_atom_left,1)));
            if (slope_base~=0)
                slope_perpendicular = -1/slope_base; 
                coords_dummy = [coords_dummy;[coords(index_fun_atom,1)+(bond_CN(1,1)/sqrt(1+slope_perpendicular^2)), coords(index_fun_atom,2)+((bond_CN(1,1)*slope_perpendicular)/sqrt(1+slope_perpendicular^2)),coords(index_fun_atom,3)]];
                coords_dummy = [coords_dummy;[coords(index_fun_atom,1)-(bond_CN(1,1)/sqrt(1+slope_perpendicular^2)), coords(index_fun_atom,2)-((bond_CN(1,1)*slope_perpendicular)/sqrt(1+slope_perpendicular^2)),coords(index_fun_atom,3)]];    
            else
                coords_dummy = [coords_dummy;[coords(index_fun_atom,1), coords(index_fun_atom,2) + bond_CN(1,1),coords(index_fun_atom,3)]];
                coords_dummy = [coords_dummy;[coords(index_fun_atom,1), coords(index_fun_atom,2) - bond_CN(1,1),coords(index_fun_atom,3)]];
            end
            
            x_vector = coords(sequence(counter_left,1),1)-coords(sequence(counter,1),1);
            y_vector = coords(sequence(counter_left,1),2)-coords(sequence(counter,1),2);
                
            x_vector_1 = coords_dummy(1,1)-coords(sequence(counter,1),1);
            y_vector_1 = coords_dummy(1,2)-coords(sequence(counter,1),2);
                
            x_vector_2 = coords_dummy(2,1)-coords(sequence(counter,1),1);
            y_vector_2 = coords_dummy(2,2)-coords(sequence(counter,1),2);
                
            angle_1 = atan2d(x_vector*y_vector_1-y_vector*x_vector_1,x_vector*x_vector_1+y_vector*y_vector_1);
            angle_2 = atan2d(x_vector*y_vector_2-y_vector*x_vector_2,x_vector*x_vector_2+y_vector*y_vector_2);
            
            if (abs(angle_1)>90)
                func_coords = [func_coords;[coords_dummy(1,1),coords_dummy(1,2),coords_dummy(1,3)]];
                func_element = [func_element;func_strong(i,1)];
            elseif(abs(angle_2)>90)
                func_coords = [func_coords;[coords_dummy(2,1),coords_dummy(2,2),coords_dummy(2,3)]];
                func_element = [func_element;func_strong(i,1)];
            end
            
            atoms_counter = atoms_counter + 1;  
        
        elseif (func_strong (i,1) == 'O')
            if (counter == 1)
                counter_left = size(sequence,1);
                counter_right = counter + 1;
            elseif (counter == size(sequence,1))
                counter_left = counter-1;
                counter_right = 1;
            else
                counter_left = counter-1;
                counter_right= counter+1;
            end
            
            index_fun_atom = sequence (counter,1);
            index_fun_atom_left = sequence(counter_left,1);
            index_fun_atom_right = sequence(counter_right,1);
            
            slope_base = ((coords(index_fun_atom_right,2) - coords(index_fun_atom_left,2))/(coords(index_fun_atom_right,1) - coords(index_fun_atom_left,1)));
            if (slope_base~=0)
                slope_perpendicular = -1/slope_base; 
                coords_dummy = [coords_dummy;[coords(index_fun_atom,1)+(bond_CO1(1,1)/sqrt(1+slope_perpendicular^2)), coords(index_fun_atom,2)+((bond_CO1(1,1)*slope_perpendicular)/sqrt(1+slope_perpendicular^2)),coords(index_fun_atom,3)]];
                coords_dummy = [coords_dummy;[coords(index_fun_atom,1)-(bond_CO1(1,1)/sqrt(1+slope_perpendicular^2)), coords(index_fun_atom,2)-((bond_CO1(1,1)*slope_perpendicular)/sqrt(1+slope_perpendicular^2)),coords(index_fun_atom,3)]];    
            else
                coords_dummy = [coords_dummy;[coords(index_fun_atom,1), coords(index_fun_atom,2) + bond_CO1(1,1),coords(index_fun_atom,3)]];
                coords_dummy = [coords_dummy;[coords(index_fun_atom,1), coords(index_fun_atom,2) - bond_CO1(1,1),coords(index_fun_atom,3)]];
            end
            
            x_vector = coords(sequence(counter_left,1),1)-coords(sequence(counter,1),1);
            y_vector = coords(sequence(counter_left,1),2)-coords(sequence(counter,1),2);
                
            x_vector_1 = coords_dummy(1,1)-coords(sequence(counter,1),1);
            y_vector_1 = coords_dummy(1,2)-coords(sequence(counter,1),2);
                
            x_vector_2 = coords_dummy(2,1)-coords(sequence(counter,1),1);
            y_vector_2 = coords_dummy(2,2)-coords(sequence(counter,1),2);
                
            angle_1 = atan2d(x_vector*y_vector_1-y_vector*x_vector_1,x_vector*x_vector_1+y_vector*y_vector_1);
            angle_2 = atan2d(x_vector*y_vector_2-y_vector*x_vector_2,x_vector*x_vector_2+y_vector*y_vector_2);
            
            if (abs(angle_1)>90)
                func_coords = [func_coords;[coords_dummy(1,1),coords_dummy(1,2),coords_dummy(1,3)]];
                func_element = [func_element;func_strong(i,1)];
            elseif(abs(angle_2)>90)
                func_coords = [func_coords;[coords_dummy(2,1),coords_dummy(2,2),coords_dummy(2,3)]];
                func_element = [func_element;func_strong(i,1)];
            end
            
            atoms_counter = atoms_counter + 1;  
        end 
    end
    coords_dummy = [];
end


%% writing the xyz file
fileID = fopen(strcat(string(file_number),'.xyz'),'w');
fprintf(fileID,'%d \n',atoms_counter);
fprintf(fileID,'%s \n',"functionalized_graphene");

for m = 1:size(func_coords,1)
    fprintf(fileID,'%s \t %.6f \t %.6f \t %.6f \n',func_element(m,1),func_coords(m,1), func_coords(m,2), func_coords(m,3));
end

fclose(fileID);








end