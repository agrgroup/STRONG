function [stable_strongs,size_n] = unique_stable_symmetry(unique_strongs, stable_strongs)

n1 = size(stable_strongs,1);
counter = 0; 

for i = 1:size(unique_strongs,1)
    B_rot = unique_strongs(i,1);
    if (isempty(findstr(unique_strongs(i,1),"S")) == 0)
        B_ref = unique_strongs(i,1);
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
        B_ref = unique_strongs(i,1);
    end
    
    for j = 1:size(stable_strongs,1)
        A_rot = append (stable_strongs(j,1), stable_strongs(j,1));
        A_ref = reverse(stable_strongs(j,1));
        A_ref = append (A_ref, A_ref);
            
        C_rot = contains (A_rot,B_rot);
        C_ref = contains (A_ref,B_ref);
        
        if (C_rot == 1 || C_ref == 1)
            counter = 1;
            break
        end 
    end
    
    if(counter == 0)
        stable_strongs = [stable_strongs;unique_strongs(i,1)];
    end
    
    counter = 0;
end

n2 = size(stable_strongs,1);
size_n = n2-n1;

end