function unique_strongs()
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

%% Finding unique pore set 
disp('symmetry operation started for unique pore set')
unique_pore_file_name = [];
unique_pore_strong = [];
unique_id = 0;
symmetric_counter = 0;

% rotation + reflection symmetry
fileID = fopen('unique_pore_subset.txt','w');
str = sprintf('unique pore xyz, STRONG and unique_id');
fprintf(fileID,'%s \n',str);
fprintf(fileID,'%s \t %s \t %s \n','file_name','unique_id', 'STRONG');

for i = 1:size(strong,1)
    if (i==1)
        unique_id = unique_id + 1;
        unique_pore_file_name = [unique_pore_file_name;file_name(i,1)];
        unique_pore_strong = [unique_pore_strong;strong(i,1)];
        fprintf(fileID,'%s \t %d \t %s \n',file_name(i,1),unique_id,strong(i,1));
    else
        B_rot = strong (i,1);
        if (isempty(findstr(strong(i,1),"S")) == 0)
            B_ref = strong(i,1);
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
            B_ref = strong(i,1);
        end
            
        for j = 1:size(unique_pore_strong,1)
            A_rot = append (unique_pore_strong(j,1), unique_pore_strong(j,1));
            A_ref = reverse(unique_pore_strong(j,1));
            A_ref = append (A_ref, A_ref);
            
            C_rot = contains (A_rot,B_rot);
            C_ref = contains (A_ref,B_ref);
            
            if (C_rot == 1 || C_ref == 1)
                symmetric_counter = 1;
                break
            end
        end
        
        if (symmetric_counter == 0)
            unique_id = unique_id + 1;
            unique_pore_file_name = [unique_pore_file_name;file_name(i,1)];
            unique_pore_strong = [unique_pore_strong;strong(i,1)];
            fprintf(fileID,'%s \t %d \t %s \n',file_name(i,1),unique_id,strong(i,1));
        end
        
        symmetric_counter = 0;
    end
end

fclose(fileID);
disp('symmetry operation ended for unique pore set')
end