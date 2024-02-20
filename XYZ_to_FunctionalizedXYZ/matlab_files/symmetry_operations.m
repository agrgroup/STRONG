function [unique_func_strongs_final] = symmetry_operations(func_strongs, functional_groups,unique_occurence)
%% Finding unique strongs

unique_func_strongs_final = [];
symmetric_counter = 0;

unique_ids = unique(unique_occurence);

for i = 1:size(unique_ids,1)
    i
    row_index = find(unique_occurence == unique_ids(i,1));
    strong = func_strongs(row_index,1);
    
    unique_func_strongs = [];
    
    for j = 1:size(strong,1)
        if (j==1)
            unique_func_strongs = [unique_func_strongs;strong(j,1)];
        else
            B_rot = strong(j,1);
            B_ref = strong(j,1);
            
            B_ref = (char(B_ref))';
            
            for k = 1:size(B_ref,1)
                if(sum(B_ref(k,1) == functional_groups)>0)
                    dummy = B_ref(k-1,1);
                    B_ref(k-1,1) = B_ref(k,1);
                    B_ref(k,1) = dummy;
                end
            end
            B_ref = string(B_ref');
            
            
            for m = 1:size(unique_func_strongs,1)
                A_rot = append (unique_func_strongs(m,1), unique_func_strongs(m,1));
                A_ref = reverse(unique_func_strongs(m,1));
                A_ref = append (A_ref, A_ref);

                C_rot = contains (A_rot,B_rot);
                C_ref = contains (A_ref,B_ref);

                if (C_rot == 1 || C_ref == 1)
                    symmetric_counter = 1;
                    break
                end
            end

            if (symmetric_counter == 0)
                unique_func_strongs = [unique_func_strongs;strong(j,1)];
            end

            symmetric_counter = 0;
        end
    end
    
    unique_func_strongs_final = [unique_func_strongs_final;unique_func_strongs];
    
end
%% Finding unique strongs 
% unique_func_strongs = [];
% symmetric_counter = 0;
% 
% % rotation + reflection symmetry
% 
% for i = 1:size(func_strongs,1)
%     if (i==1)
%         unique_func_strongs = [unique_func_strongs;func_strongs(i,1)];
%     else
%         B_rot = func_strongs(i,1);
%         
%         B_ref = func_strongs(i,1);
%         B_ref = (char(B_ref))';
%         
%         for k = 1:size(B_ref,1)
%             if(sum(B_ref(k,1) == functional_groups)>0)
%                 dummy = B_ref(k-1,1);
%                 B_ref(k-1,1) = B_ref(k,1);
%                 B_ref(k,1) = dummy;
%             end
%         end
%         B_ref = string(B_ref');
% 
%             
%         for j = 1:size(unique_func_strongs,1)
%             A_rot = append (unique_func_strongs(j,1), unique_func_strongs(j,1));
%             A_ref = reverse(unique_func_strongs(j,1));
%             A_ref = append (A_ref, A_ref);
%             
%             C_rot = contains (A_rot,B_rot);
%             C_ref = contains (A_ref,B_ref);
%             
%             if (C_rot == 1 || C_ref == 1)
%                 symmetric_counter = 1;
%                 break
%             end
%         end
%         
%         if (symmetric_counter == 0)
%             unique_func_strongs = [unique_func_strongs;func_strongs(i,1)];
%         end
%         
%         symmetric_counter = 0;
%     end
% end

end