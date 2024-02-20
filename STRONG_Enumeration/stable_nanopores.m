function [atoms_removed, stable_strongs,time,count_atoms] = stable_nanopores()
starting_strong = "FFFZFFFZFFFZ";
n = 1; % atoms removed for starting strong 
N = 15; % atoms upto which stable STRONGs to be generated
time = [];
count_atoms = [];
atoms_removed = [];
stable_strongs = [];
strongs = [];
strong_AA = [];
strong_ACA = [];
strong_ACCA = [];
atoms_removed = [atoms_removed;n];
stable_strongs = [stable_strongs; starting_strong];

for i = 2:N
    tStart = tic;
    tic
    % finding the index of stable strongs for a given n which is i-1
    row_index = find(atoms_removed(:,1) == i-1);
    % removing Z atoms to increase the pore size and generate the stable nanopores
    for j = 1:size(row_index,1)
        updated_strong = remove_Z_atom(stable_strongs(row_index(j,1),1));
        strongs = [strongs;updated_strong];
    end
    toc
    % AA combination removal
    if (i-2>0)
        row_index_AA = find(atoms_removed(:,1) == i-2);
        for q = 1:size(row_index_AA,1)
            if (contains(stable_strongs(row_index_AA(q,1),1), "A") == 1)
                strong_AA = [strong_AA;stable_strongs(row_index_AA(q,1),1)];
            end
        end
        
        if (isempty(strong_AA) == 0)
            
            for k = 1:size(strong_AA,1)
                updated_strong_AA = remove_AA_atom(strong_AA(k,1));
                strongs = [strongs;updated_strong_AA];
            end
        end
    end
    
    % ACA combination removal
    if (i-3>0)
        row_index_ACA = find(atoms_removed(:,1) == i-3);
        for m = 1:size(row_index_ACA,1)
            if (contains(stable_strongs(row_index_ACA(m,1),1), "C") == 1)
                strong_ACA = [strong_ACA;stable_strongs(row_index_ACA(m,1),1)];
            end
        end
        
        if (isempty(strong_ACA) == 0)
            for n = 1:size(strong_ACA,1)
                updated_strong_ACA = remove_ACA_atom(strong_ACA(n,1));
                strongs = [strongs;updated_strong_ACA];
            end
        end
    end
    
    % ACCA combination removal
    if (i-4>0)
        row_index_ACCA = find(atoms_removed(:,1) == i-4);
        for m = 1:size(row_index_ACCA,1)
            if (contains(stable_strongs(row_index_ACCA(m,1),1), "C") == 1)
                strong_ACCA = [strong_ACCA;stable_strongs(row_index_ACCA(m,1),1)];
            end
        end
        
        if (isempty(strong_ACCA) == 0)
            for n = 1:size(strong_ACCA,1)
                updated_strong_ACCA = remove_ACCA_atom(strong_ACCA(n,1));
                strongs = [strongs;updated_strong_ACCA];
            end
        end
    end
    
    % appying symmetry operations on set of strongs to obtain unique strongs
    unique_strongs = symmetry_operations(strongs);
    
    % removing strongs with dangling moieties
    unique_strongs = remove_ACCAZ_strong(unique_strongs);
   
    [stable_strongs,size_n] = unique_stable_symmetry(unique_strongs, stable_strongs);
    n = ones(size_n,1)*i;
    atoms_removed = [atoms_removed;n];
    count_atoms =[count_atoms;size_n];
    
    i 
    size_n
    strongs = [];
    strong_AA = [];
    tEnd = toc(tStart)
    time = [time;tEnd];
end 

file_ID = fopen('enumerated_strongs.txt','w');
fprintf(file_ID,'%s \t %s \n',"atoms_removed", "stable_strongs");

for i = 1:size(stable_strongs,1)
    fprintf(file_ID,'%d \t %s \n',atoms_removed(i,1), stable_strongs(i,1));
end

fclose(file_ID);

file_ID = fopen('enumerated_strongs_time.txt','w');
fprintf(file_ID,'%s \t %s \n',"count_strongs", "time");

for i = 1:size(time,1)
    fprintf(file_ID,'%d \t %d \n',count_atoms(i,1), time(i,1));
end

fclose(file_ID);

end