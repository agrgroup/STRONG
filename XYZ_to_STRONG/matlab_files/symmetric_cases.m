function symmetric_cases()
%% reading STRONGS Text file
%opening the STRONGS text file and reading the first line
fid = fopen('STRONGS.txt','r');
tline = fgets(fid);
% variable to count
count=0;
% vector to store file names
file_name = [];
% vector to store strong corresponding to the file name
strong = [];

% reading the filename and strong respectively
while ischar(tline)
    % keeping the count of lines
    count=count+1;
    % reads from line 3 in the text file 
    if (count>2)
       data = strtrim(strsplit(strtrim(tline),'\t'));
       file_name = [file_name;string(cell2mat(data(1)))];
       strong = [strong; string(cell2mat(data(2)))];
    end
    tline = fgets(fid);
end
fclose(fid);

%% implementing symmetry opertions using STRONGS
disp('symmetry operation started')
% variables to store type of symmetry and pairs which are symmetric
unique_pore = [];
counter = 0;

% rotation + reflection symmetry
fileID = fopen('symmetric_pairs.txt','w');
str = sprintf('Symmetric Pairs');
fprintf(fileID,'%s \n',str);
fprintf(fileID,'%s \t %s \t %s \n','file_name','symm_file_name', 'symmetry_type');

for i = 1:size(strong,1)
    A_rot = append (strong(i,1), strong(i,1));
    A_ref = reverse(strong(i,1));
    A_ref = append (A_ref, A_ref);
    
    for j = 1:size(strong,1)
        if(j~=i)
            B_rot = strong (j,1);
            
            if (isempty(findstr(strong(j,1),"S")) == 0)
                B_ref = strong(j,1);
                B_ref = (char(B_ref))';
                for k = 1:size(B_ref,1)
                    if(B_ref(k,1) == 'S')
                        if (B_ref(k-1,1) == 'F')
                            B_ref(k,1) = B_ref(k-1,1);
                            B_ref(k-1,1) = 'S';
                        elseif (B_ref(k-2,1) == 'F' && B_ref(k-1,1) == 'A')
                            B_ref(k,1) = B_ref(k-2,1);
                            B_ref(k-2,1) = 'S';
                        elseif (B_ref(k-3,1) == 'F' && B_ref(k-2,1) == 'A' && B_ref(k-1,1) == 'A')
                            B_ref(k,1) = B_ref(k-3,1);
                            B_ref(k-3,1) = 'S';
                        end
                    end
                end
                B_ref = string(B_ref');
            else
                B_ref = strong(j,1);
            end
            
            C_rot = contains (A_rot,B_rot);
            C_ref = contains (A_ref,B_ref);
            
            if (C_rot + C_ref == 2)
                fprintf(fileID,'%s \t %s \t %s \n',file_name(i,1),file_name(j,1),"rotation & reflection");
                counter = counter + 1;
            elseif (C_rot + C_ref == 1)
                
                if (C_rot ==1)
                    fprintf(fileID,'%s \t %s \t %s \n',file_name(i,1),file_name(j,1),"rotation");
                    counter = counter + 1;
                elseif (C_ref ==1)
                    fprintf(fileID,'%s \t %s \t %s \n',file_name(i,1),file_name(j,1),"reflection");
                    counter = counter + 1;
                end
            end
        end
    end
    
    if (counter == 0)
        unique_pore = [unique_pore;file_name(i,1)];
    end
    
    counter = 0;
    
end
fclose(fileID);
disp('symmetry operation ended')
end