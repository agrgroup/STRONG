function remove_Ri_atoms(N,d)
%opening the xyz file and reading the first line
cd (d)
xyz_files = dir(fullfile(d, '*.xyz'));
mkdir(strcat('pore_',num2str(N)));
new_folder = strcat(d,'\pore_',num2str(N));

for i = 1:size(xyz_files,1)
    i
    fid = fopen(xyz_files(i,1).name,'r');
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
           data = strtrim(strsplit(strtrim(tline),' '));
           element = [element;convertCharsToStrings(cell2mat(data(1)))];
           coords = [coords; str2double(cell2mat(data(2))), str2double(cell2mat(data(3))), str2double(cell2mat(data(4)))];
        end
        tline = fgets(fid);
    end
    
    fclose(fid);
    
    % removing Ri, Re, ZZ, AC, UA  and SB atoms and generating a file 
    
    index_Re = find(element == "Re");
    index_Ri = find(element == "Ri");
    index_ZZ = find(element == "ZZ");
    index_AC = find(element == "AC");
    index_UA = find(element == "UA");
    index_Ua = find(element == "Ua");
    index_SB = find(element == "SB");
    index_Sb = find(element == "Sb");
    index_removed = [index_Re;index_Ri;index_ZZ;index_AC;index_UA;index_Ua;index_SB;index_Sb];
    element(index_removed,:) = [];
    coords(index_removed,:) = [];
    
    % writing the xyz file in new directory created
    cd (new_folder)
    
    fileID = fopen(strcat('pore',xyz_files(i,1).name),'w');
    fprintf(fileID,'%d \n',size(element,1));
    str = sprintf('number of removed atoms: ');
    fprintf(fileID,'%s %d \n',str, N);
    for j = 1:size(element,1)
        fprintf(fileID,'%s \t %d \t %d \t %d \n',element(j,1),coords(j,1),coords(j,2),coords(j,3)); 
    end
    fclose(fileID);
    
    cd (d)
end


end