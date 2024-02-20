function [unique_strong] = symmetry_operations(strong)

%% Finding unique strongs 
unique_strong = [];
symmetric_counter = 0;

% rotation + reflection symmetry

for i = 1:size(strong,1)
    if (i==1)
        unique_strong = [unique_strong;strong(i,1)];
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
            
        for j = 1:size(unique_strong,1)
            A_rot = append (unique_strong(j,1), unique_strong(j,1));
            A_ref = reverse(unique_strong(j,1));
            A_ref = append (A_ref, A_ref);
            
            C_rot = contains (A_rot,B_rot);
            C_ref = contains (A_ref,B_ref);
            
            if (C_rot == 1 || C_ref == 1)
                symmetric_counter = 1;
                break
            end
        end
        
        if (symmetric_counter == 0)
            unique_strong = [unique_strong;strong(i,1)];
        end
        
        symmetric_counter = 0;
    end
end


end