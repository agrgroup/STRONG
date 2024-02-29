function [strong,sequence] = xyz_to_strongs(porexyzfilename,d)
%% variables defined by user

% C-C bond length cutoff
C_C_bl = 1.5;

%% opening and reading the xyz file to get element and coordinates of each atom

%opening the xyz file and reading the first line
cd (d)
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

% dimension of the box
L_x_max = max(coords(:,1)) - 2*C_C_bl;
L_y_max = max(coords(:,2)) - 2*C_C_bl;
L_x_min = min(coords(:,1)) + 2*C_C_bl;
L_y_min = min(coords(:,2)) + 2*C_C_bl;

%% counting number of neighbors for each atom 
count = 0;
neigh_counts =  zeros(size(element,1),1);
for i = 1:size(element,1)
    for j = 1:size(element,1)
        if (j~=i)
            dist = sqrt((coords(i,1) - coords(j,1))^2 + (coords(i,2) - coords(j,2))^2);
            if (dist <C_C_bl)
                count = count + 1;
            end
        end
    end
    neigh_counts (i,1) = count;
    count = 0;
end

%% finding double bonded (db) and single bonded (sb) atoms and excluding the boundary atoms
% finding index of db atoms
index_db = find (neigh_counts == 2);

% finding index of db atoms near to boundary
index_db_boundary = [];
if (isempty(index_db) == 0)
    for i = 1:size(index_db,1)
        if (coords(index_db(i,1),1) < L_x_min || coords(index_db(i,1),2) < L_y_min || coords(index_db(i,1),1) > L_x_max || coords(index_db(i,1),2) > L_y_max)
            index_db_boundary = [index_db_boundary;i];
        end
    end
end

% removing the index of db atoms near bondary to get db atoms of pore 
if (isempty(index_db_boundary) == 0)
    index_db (index_db_boundary,:) = [];
end

% finding index of sb atoms 
index_sb = find(neigh_counts == 1);

% finding index of sb atoms near to boundary
index_sb_boundary = [];
if (isempty(index_sb) == 0)
    for i = 1:size(index_sb,1)
        if (coords(index_sb(i,1),1) < L_x_min || coords(index_sb(i,1),2) < L_y_min || coords(index_sb(i,1),1) > L_x_max || coords(index_sb(i,1),2) > L_y_max)
            index_sb_boundary = [index_sb_boundary;i];
        end
    end
end

% removing the index of sb atoms near boundary to get sb atoms of pore
if (isempty(index_sb_boundary) == 0)
    index_sb (index_sb_boundary,:) = [];
end

%% finding index of double bonded neighbors
neigh_db = [];

if (isempty(index_db) == 0)
    for i = 1:size(index_db,1)
        for j = 1:size(element,1)
            if (j~=index_db(i,1))
                dist = sqrt((coords(index_db(i,1),1) - coords(j,1))^2 + (coords(index_db(i,1),2) - coords(j,2))^2);
                if (dist<C_C_bl)
                    neigh_db = [neigh_db; j];
                end
            end
        end
    end
end

%% finding index of single bonded neighbors
neigh_sb = [];

if (isempty(index_sb) == 0)
    for i = 1:size(index_sb,1)
        for j = 1:size(element,1)
            if (j~=index_sb(i,1))
                dist = sqrt((coords(index_sb(i,1),1) - coords(j,1))^2 + (coords(index_sb(i,1),2) - coords(j,2))^2);
                if (dist<C_C_bl)
                    neigh_sb = [neigh_sb; j];
                end
            end
        end
    end
end

%% combining the index of atoms in the pore

if (isempty (index_db) == 0 || isempty (index_sb) == 0) 
    index_pore_atoms = [index_db;index_sb;neigh_db;neigh_sb];
end

if (isempty(index_pore_atoms) == 0)
    index_pore_atoms = unique(index_pore_atoms);
end

% The pore is still not complete as fb atom covered by fb atoms are not included here

%% classifying each atom as fb, db and sb
classification = [];
index_fb = [];
if (isempty(index_pore_atoms) == 0)
    for i = 1: size(index_pore_atoms)
        if (sum(index_pore_atoms(i,1) == index_db) ~=0)
            classification = [classification;'d'];
        elseif (sum(index_pore_atoms(i,1) == index_sb) ~=0)
            classification = [classification;'s'];
        else
            classification = [classification;'f'];
            index_fb = [index_fb;index_pore_atoms(i,1)];
        end
    end   
end

%% finding the common fb atom b/w two fb atoms
% finding the neighbors of fb atoms in the rim identified above, the neighbors will include db, sb and fb atoms 
neigh_fb = [];

if (isempty(index_fb) == 0)
    for i = 1:size(index_fb,1)
        for j = 1:size(element,1)
            if (j~=index_fb(i,1))
                dist = sqrt((coords(index_fb(i,1),1) - coords(j,1))^2 + (coords(index_fb(i,1),2) - coords(j,2))^2);
                if(dist<C_C_bl)
                    neigh_fb = [neigh_fb;j];
                end
            end
        end
    end
end

% checking occurence of each neigh_fb atom, greater than 1 the it could be potential rim (missing) atom  
if (isempty(neigh_fb) == 0)
    unique_neigh_fb = unique(neigh_fb);
    unique_neigh_fb_index = [];
    for i = 1:size(unique_neigh_fb,1)
        if(sum(unique_neigh_fb(i,1) == neigh_fb) > 1)
            unique_neigh_fb_index = [unique_neigh_fb_index;i];
        end
        
    end
    % storing the potetial rim atom index 
    potential_atom_index = [];
    if (isempty(unique_neigh_fb_index) == 0)
        for i = 1:size(unique_neigh_fb_index,1)
            potential_atom_index = [potential_atom_index;unique_neigh_fb(unique_neigh_fb_index(i,1))];
        end 
    end
end

% finding the index and removing repeated atom index of db,sb and fb atom from potential rim atoms to avoid repetition
index_repeated = [];

if (isempty(potential_atom_index) == 0)
    for i = 1:size(potential_atom_index,1)
        if (sum(potential_atom_index (i,1) == index_db)~=0 || sum(potential_atom_index (i,1) == index_sb) ~=0 || sum(potential_atom_index (i,1) == index_fb) ~=0)
            index_repeated = [index_repeated;i];
        end
    end
end

if (isempty(index_repeated) == 0)
    potential_atom_index(index_repeated,:) = [];
end

% post verification, potential atom is confirmed to be a rim atom and hence index of atom is added to index of fb atoms 
if (isempty(index_fb) == 0)
    if (isempty(potential_atom_index) == 0)
        for i = 1:size(potential_atom_index,1)
            index_fb = [index_fb;potential_atom_index(i,1)];
        end
    end
end

%% Final Pore Atom Index
% combining fb,db and sb atom index of rim atoms and getting unique index  
pore_index = [];
if (isempty(index_fb) == 0 || isempty(index_db) == 0 || isempty(index_sb) == 0)
    pore_index = [pore_index;[index_fb;index_db; index_sb]];
end

pore_index = unique(pore_index);

%% classifying atoms as F (fully bonded), A (ArmChair), Z(Zig-Zag), C(Corner) and S(Single)
type = [];
count = 0;
if (isempty(pore_index) == 0)
    for i = 1:size(pore_index,1)
        if (sum(pore_index(i,1) == unique(index_fb)) == 1)
            type = [type;'F'];
        elseif (sum(pore_index(i,1) == unique(index_sb)) == 1)
            type = [type;'S'];
        elseif (sum(pore_index(i,1) == unique(index_db)) == 1)
            for j = 1:size(pore_index,1)
                if (pore_index(j,1)~=pore_index(i,1))
                    dist = sqrt((coords(pore_index(i,1),1) - coords(pore_index(j,1),1))^2 + (coords(pore_index(i,1),2) - coords(pore_index(j,1),2))^2);
                    if (dist<C_C_bl)
                        if (sum(pore_index(j,1) == unique(index_fb)) == 1)
                            count = count + 1;
                        end
                    end
                end
            end
            
            if (count == 2)
                type = [type;'Z'];
            elseif (count == 1)
                type = [type;'A'];
            elseif (count == 0)
                type = [type;'C'];
            end
            count = 0;
        end
    end 
end

%% Removing extra atom opposite to corner atom

index_removed_atom = [];
if (isempty(potential_atom_index) == 0)
    for j = 1:size(pore_index,1)
        if (type(j,1) == 'C')
            for k = 1:size(potential_atom_index,1)
                dist = sqrt((coords(pore_index(j,1),1) - coords(potential_atom_index(k,1),1))^2 + (coords(pore_index(j,1),2) - coords(potential_atom_index(k,1),2))^2);
                if (dist > 2.80 && dist < 2.90)
                    index_removed_atom = [index_removed_atom;potential_atom_index(k,1)];
                end
            end
        end
    end
end

index_neigh_removed_atoms =[];
if (isempty(index_removed_atom) == 0)
    for i = 1:size(index_removed_atom,1)
        for j = 1:size(potential_atom_index,1)
            if (index_removed_atom(i,1) ~= potential_atom_index(j,1))
                dist = sqrt((coords(index_removed_atom(i,1),1) - coords(potential_atom_index(j,1),1))^2 + (coords(index_removed_atom(i,1),2) - coords(potential_atom_index(j,1),2))^2);
                if (dist < C_C_bl)
                    index_neigh_removed_atoms =[index_neigh_removed_atoms;potential_atom_index(j,1)];
                end
            end
        end
    end
end

index_removed_atom = [index_removed_atom;index_neigh_removed_atoms]; 

if (isempty(index_removed_atom) == 0)
    index_removed_atom = unique(index_removed_atom);
    for j = 1:size(index_removed_atom,1)
        row = find(index_removed_atom(j,1) == pore_index);
        pore_index(row,:) = [];
        type(row,:) = [];
    end
end

%% Removing F atom from the horse-shoe pore structure

% index_removed_atom = [];
% if (isempty(potential_atom_index) == 0)
%     for j = 1:size(pore_index,1)
%         if (type(j,1) == 'C')
%             for k = 1:size(potential_atom_index)
%                 dist = sqrt((coords(pore_index(j,1),1) - coords(potential_atom_index(k,1),1))^2 + (coords(pore_index(j,1),2) - coords(potential_atom_index(k,1),2))^2);
%                 if (dist > 5.10 && dist < 5.20)
%                     index_removed_atom = [index_removed_atom;potential_atom_index(k,1)];
%                 end
%             end
%         end
%     end
% end
% 
% if (isempty(index_removed_atom) == 0)
%     for j = 1:size(index_removed_atom,1)
%         row = find(index_removed_atom(j,1) == pore_index);
%         pore_index(row,:) = [];
%         type(row,:) = [];
%     end
% end

%% finding the neighbor of 1,2 and 3 bonded atoms

count = 0;
neigh_dummy = [];
neigh_1_bonded_atom = [];
neigh_2_bonded_atom = [];
neigh_3_bonded_atom = [];

% incase of 2 neighbors and 1 neighbor, one and two 0's are added to make the dimesion equal to 3 neighbor system for matrix consistency
for i = 1:size(pore_index,1)
    for j = 1:size(pore_index,1)
        if (pore_index(j,1)~= pore_index(i,1))
            dist = sqrt((coords(pore_index(i,1),1) - coords(pore_index(j,1),1))^2 + (coords(pore_index(i,1),2) - coords(pore_index(j,1),2))^2);
            if (dist<C_C_bl)
                count = count + 1;
                neigh_dummy = [neigh_dummy,pore_index(j,1)];
            end
        end
    end
    
    if (count == 3)
        neigh_3_bonded_atom = [neigh_3_bonded_atom;[pore_index(i,1),neigh_dummy]];
    elseif (count == 2)
        neigh_2_bonded_atom = [neigh_2_bonded_atom;[pore_index(i,1),neigh_dummy,0]];
    elseif (count == 1)
        neigh_1_bonded_atom = [neigh_1_bonded_atom;[pore_index(i,1),neigh_dummy,[0,0]]];
    end
    
    count = 0;
    neigh_dummy = []; 
end

% combining 2 bonded, 3 bonded and 1 bonded atoms 
neigh_combined = [neigh_2_bonded_atom;neigh_3_bonded_atom;neigh_1_bonded_atom];

%% sequencing the pore atoms
sequence = [];
sequence = [sequence; [0;1]];
count = 0;
next_neighbour_count = 0;
% run the loop until sequence vector covers each rim atom
while (sequence(end,1) ~= sequence(1,1))
    count = count + 1;
    % first atom case
    if (count == 1)
        if (sum(neigh_combined(count,1) == neigh_2_bonded_atom(:,1)) == 1)
            sequence (count,1) = neigh_combined(count,2);
            sequence(count+1,1) = neigh_combined(count,1);
            sequence(count+2,1) = neigh_combined(count,3);
            
            if(isempty(neigh_3_bonded_atom) == 0)
                if (sum(sequence(count,1) == neigh_3_bonded_atom(:,1))==1)
                    sequence (count,1) = neigh_combined(count,3);
                    sequence(count+2,1) = neigh_combined(count,2);
                end
            end
            
            count = count + 2;
        end
    % any atom number other than 1
    else
        % checking whether atom is double bonded
        if (sum(sequence(count-1,1) == neigh_2_bonded_atom(:,1)) == 1)
            % finding the row of atom whose neighbor to place next in sequence vector
            row = find (sequence(count-1,1) == neigh_combined(:,1));
            column = [];
            % checking whether neighbors covered in the sequence vector
            for i = 2:3
                for j = 1:count-1
                    if (sequence(j,1) == neigh_combined(row,i))
                        column = [column,i];
                    end
                end
            end
            
            % neighbor atom not covered in sequence will be placed next
            for i = 2:3
                if (isempty(column) == 0)
                    if (sum(i==column) == 0)
                        sequence(count,1) = neigh_combined(row,i);
                    else 
                        next_neighbour_count = next_neighbour_count + 1; 
                    end
                end
            end
            
            if (next_neighbour_count == 2)
                sequence(count,1) = sequence(1,1);
            end
            
            next_neighbour_count = 0;
        % checking whether atom is triple bonded
        elseif (sum(sequence(count-1,1) == neigh_3_bonded_atom(:,1)) == 1)
            % finding the row of atom whose neighbor to place next in sequence vector
            row = find (sequence(count-1,1) == neigh_combined(:,1));
            column = [];
            % checking whether neighbors covered in the sequence vector; column vector provides which neighbor is already covered. 
            for i = 2:4
                for j = 1:count-1
                    if (sequence(j,1) == neigh_combined(row,i))
                        column = [column,i];
                    end
                end
            end
            
            % if all the three neighbors are covered then the rim is completely traversed
            if (isempty(column) == 0)
                if (size(column,2) == 3)
                    sequence(count,1) = sequence(1,1);
                else
                    % We have two atoms (neighbours) to go to, we are finding the type of neighbor and index of it in "neigh_combined" table 
                    neigh_type = [];
                    neigh_column = [];
                    for i = 2:4
                        if (isempty(column) == 0 && sum(i == column)==0)
                            neigh_type = [neigh_type;type(find(neigh_combined(row,i) == pore_index),1)];
                            neigh_column = [neigh_column;i];
                        end
                    end

                    % neighbor atom not covered can be 2 or 1 in count respectively, if it is 2 then always move toward armchair atom else move toward which is not covered
                    if (size(neigh_type,1) == 1)
                        sequence(count,1) = neigh_combined(row,neigh_column(1,1));
                    elseif(size(neigh_type,1) == 2)
                        if (sum(neigh_type == 'S') ~= 0)
                            j = find (neigh_type(:,1) == 'S');
                            sequence(count,1) = neigh_combined(row,neigh_column(j,1));
                        else
                            if (sum(neigh_type == 'A') ~= 0)
                                k = find (neigh_type(:,1) == 'A');
                                sequence(count,1) = neigh_combined(row,neigh_column(k(1,1),1));
                            else
                                if (sum(neigh_type == 'Z') ~= 0)
                                    k = find (neigh_type(:,1) == 'Z');
                                    sequence(count,1) = neigh_combined(row,neigh_column(k(1,1),1));
                                else
                                    if (sum(neigh_type == 'F') ~= 0)
                                        k = find (neigh_type(:,1) == 'F');
                                        if (sum(neigh_combined(row,neigh_column(k(1,1),1)) == potential_atom_index) == 0)%sum(neigh_combined(row,neigh_column(k(1,1),1)) == potential_atom_index)
                                            sequence(count,1) = neigh_combined(row,neigh_column(k(1,1),1));
                                        elseif(sum(neigh_combined(row,neigh_column(k(2,1),1)) == potential_atom_index) == 0)%sum(neigh_combined(row,neigh_column(k(2,1),1)) == potential_atom_index)
                                            sequence(count,1) = neigh_combined(row,neigh_column(k(2,1),1));
                                        else
                                            row_neighbour_1 = find (neigh_combined(row,neigh_column(k(1,1),1)) == neigh_combined(:,1));
                                            neighbour_1 = (neigh_combined(row_neighbour_1,[2:4]))';
                                            neighbour_1(neighbour_1 == 0) = [];

                                            row_neighbour_2 = find (neigh_combined(row,neigh_column(k(2,1),1)) == neigh_combined(:,1));
                                            neighbour_2 = (neigh_combined(row_neighbour_2,[2:4]))';
                                            neighbour_2(neighbour_2 == 0) = [];

                                            sum1 = 0;
                                            for j = 1:size(neighbour_1,1)
                                                sum1 = sum1 + sum(neighbour_1(j,1) == sequence);
                                            end

                                            sum2=0;
                                            for j = 1:size(neighbour_2,1)
                                                sum2 = sum2 + sum(neighbour_2(j,1) == sequence);
                                            end

                                            if ((size(neighbour_1,1) - sum1) > (size(neighbour_2,1) - sum2))
                                                sequence(count,1) = neigh_combined(row,neigh_column(k(1,1),1));
                                            else
                                                sequence(count,1) = neigh_combined(row,neigh_column(k(2,1),1));
                                            end
                                        end
                                    end
                                end
                            end 
                        end 
                    end  
                end
            end
            
        % checking whether atom is single bonded
        elseif (sum(sequence(count-1,1) == neigh_1_bonded_atom(:,1)) == 1)
            % finding the last 3 bonded atom and finding the row 
            for i = count-2:-1:1
                if (sum(sequence(i,1) == neigh_3_bonded_atom(:,1)) == 1)
                    row = find (sequence(i,1) == neigh_combined(:,1));
                    break 
                end 
            end
            
            % checking which neighbors are already covered in sequence vector
            column = [];
            for i = 2:4
                for j = 1:count-1
                    if (sequence(j,1) == neigh_combined(row,i))
                        column = [column,i];
                    end
                end
            end
            
            % if all the three neighbors are covered then the rim is completely traversed
            if (isempty(column) == 0)
                if (size(column,2) == 3)
                    sequence(count,1) = sequence(1,1);
                end
            end
            
            % finding the neighbor type incase two paths are available to a 3 bonded atom
            neigh_type = [];
            neigh_column = [];
            for i = 2:4
                if (isempty(column) == 0)
                    if (size(column,2) == 1)
                        neigh_type = [neigh_type;type(find(neigh_combined(row,i) == pore_index),1)];
                        neigh_column = [neigh_column;i];
                    end
                end
            end
            
            
            % neighbor atom not covered can be 2 or 1 in count respectively, if it is 2 then always move toward armchair atom else move toward which is not covered
            for i = 2:4
                if (isempty(column) == 0)
                    if (size(column,2) == 1)
                        if (sum(i == column)==0) 
                            if (sum(neigh_type == 'S') == 1)
                                j = find (neigh_type(:,1) == 'S');
                                sequence(count,1) = neigh_combined(row,neigh_column(j,1));
                            else
                                if (type(find(neigh_combined(row,i) == pore_index),1) == 'A')
                                    sequence(count,1) = neigh_combined(row,i);
                                end
                            end
                        end
                    else
                        if (sum(i== column) == 0)
                            sequence(count,1) = neigh_combined(row,i);
                        end
                    end
                end
            end
        end 
    end
end
sequence(end,:) = [];

% atoms are arranged in a sequence which can be used to get the STRONGS
%% Generating STRONGS
string = [];

if (isempty(sequence) == 0)
    for i = 1:size(sequence,1)
        string = [string,type(find(sequence(i,1) == pore_index),1)];
    end
end

strong = convertCharsToStrings(string);


%%

end