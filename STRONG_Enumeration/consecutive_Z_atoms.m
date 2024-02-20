function [updated_strong] = consecutive_Z_atoms(new_strong, left_Z_position, right_Z_position)
new_strong = (convertStringsToChars(new_strong(1,1)))';

for p = 1:size(new_strong,1)
    % left position
    if (p == left_Z_position)
        if (p-1==0)
            if (strcat(string(new_strong(end,1)), string(new_strong(p,1))) == "ZZ")
                new_strong(end,1) = 'A';
                new_strong(p,1) = 'A';
            elseif (strcat(string(new_strong(end-1,1)), string(new_strong(end,1)), string(new_strong(p,1))) == "AAZ")
                new_strong(end-1,1) = 'A';
                new_strong(end,1) = 'C';
                new_strong(p,1) = 'A';
            elseif(strcat(string(new_strong(end-2,1)), string(new_strong(end-1,1)), string(new_strong(end,1)), string(new_strong(p,1))) == "ACAZ")
                new_strong(end-2,1) = 'A';
                new_strong(end-1,1) = 'C';
                new_strong(end,1) = 'C';
                new_strong(p,1) = 'A';
            end
        elseif (p-2 == 0)
            if (strcat(string(new_strong(p-1,1)), string(new_strong(p,1))) == "ZZ")
                new_strong(p-1,1) = 'A';
                new_strong(p,1) = 'A';
            elseif (strcat(string(new_strong(end,1)), string(new_strong(p-1,1)), string(new_strong(p,1))) == "AAZ")
                new_strong(end,1) = 'A';
                new_strong(p-1,1) = 'C';
                new_strong(p,1) = 'A';
            elseif(strcat(string(new_strong(end-1,1)), string(new_strong(end,1)), string(new_strong(p-1,1)), string(new_strong(p,1))) == "ACAZ")
                new_strong(end-1,1) = 'A';
                new_strong(end,1) = 'C';
                new_strong(p-1,1) = 'C';
                new_strong(p,1) = 'A';
            end
        elseif (p-3 == 0)
            if (strcat(string(new_strong(p-1,1)), string(new_strong(p,1))) == "ZZ")
                new_strong(p-1,1) = 'A';
                new_strong(p,1) = 'A';
            elseif (strcat(string(new_strong(p-2,1)), string(new_strong(p-1,1)), string(new_strong(p,1))) == "AAZ")
                new_strong(p-2,1) = 'A';
                new_strong(p-1,1) = 'C';
                new_strong(p,1) = 'A';
            elseif(strcat(string(new_strong(end,1)), string(new_strong(p-2,1)), string(new_strong(p-1,1)), string(new_strong(p,1))) == "ACAZ")
                new_strong(end,1) = 'A';
                new_strong(p-2,1) = 'C';
                new_strong(p-1,1) = 'C';
                new_strong(p,1) = 'A';
            end
        else
            if (strcat(string(new_strong(p-1,1)), string(new_strong(p,1))) == "ZZ")
                new_strong(p-1,1) = 'A';
                new_strong(p,1) = 'A';
            elseif (strcat(string(new_strong(p-2,1)), string(new_strong(p-1,1)), string(new_strong(p,1))) == "AAZ")
                new_strong(p-2,1) = 'A';
                new_strong(p-1,1) = 'C';
                new_strong(p,1) = 'A';
            elseif(strcat(string(new_strong(p-3,1)), string(new_strong(p-2,1)), string(new_strong(p-1,1)), string(new_strong(p,1))) == "ACAZ")
                new_strong(p-3,1) = 'A';
                new_strong(p-2,1) = 'C';
                new_strong(p-1,1) = 'C';
                new_strong(p,1) = 'A';
            end  
        end
    end
    % right position
    if (p == right_Z_position)
        if (p == size(new_strong,1))
            if (strcat(string(new_strong(p,1)), string(new_strong(1,1))) == "ZZ")
                new_strong(p,1) = 'A';
                new_strong(1,1) = 'A';
            elseif (strcat(string(new_strong(p,1)), string(new_strong(1,1)), string(new_strong(2,1))) == "ZAA")
                new_strong(p,1) = 'A';
                new_strong(1,1) = 'C';
                new_strong(2,1) = 'A';
            elseif(strcat(string(new_strong(p,1)), string(new_strong(1,1)), string(new_strong(2,1)), string(new_strong(3,1))) == "ZACA")
                new_strong(p,1) = 'A';
                new_strong(1,1) = 'C';
                new_strong(2,1) = 'C';
                new_strong(3,1) = 'A';
            end
        elseif (p+1 == size(new_strong,1))
            if (strcat(string(new_strong(p,1)), string(new_strong(p+1,1))) == "ZZ")
                new_strong(p,1) = 'A';
                new_strong(p+1,1) = 'A';
            elseif (strcat(string(new_strong(p,1)), string(new_strong(p+1,1)), string(new_strong(1,1))) == "ZAA")
                new_strong(p,1) = 'A';
                new_strong(p+1,1) = 'C';
                new_strong(1,1) = 'A';
            elseif(strcat(string(new_strong(p,1)), string(new_strong(p+1,1)), string(new_strong(1,1)), string(new_strong(2,1))) == "ZACA")
                new_strong(p,1) = 'A';
                new_strong(p+1,1) = 'C';
                new_strong(1,1) = 'C';
                new_strong(2,1) = 'A';
            end
        elseif (p+2 == size(new_strong,1))
            if (strcat(string(new_strong(p,1)), string(new_strong(p+1,1))) == "ZZ")
                new_strong(p,1) = 'A';
                new_strong(p+1,1) = 'A';
            elseif (strcat(string(new_strong(p,1)), string(new_strong(p+1,1)), string(new_strong(p+2,1))) == "ZAA")
                new_strong(p,1) = 'A';
                new_strong(p+1,1) = 'C';
                new_strong(p+2,1) = 'A';
            elseif(strcat(string(new_strong(p,1)), string(new_strong(p+1,1)), string(new_strong(p+2,1)), string(new_strong(1,1))) == "ZACA")
                new_strong(p,1) = 'A';
                new_strong(p+1,1) = 'C';
                new_strong(p+2,1) = 'C';
                new_strong(1,1) = 'A';
            end
        else
            if (strcat(string(new_strong(p,1)), string(new_strong(p+1,1))) == "ZZ")
                new_strong(p,1) = 'A';
                new_strong(p+1,1) = 'A';
            elseif (strcat(string(new_strong(p,1)), string(new_strong(p+1,1)), string(new_strong(p+2,1))) == "ZAA")
                new_strong(p,1) = 'A';
                new_strong(p+1,1) = 'C';
                new_strong(p+2,1) = 'A';
            elseif(strcat(string(new_strong(p,1)), string(new_strong(p+1,1)), string(new_strong(p+2,1)), string(new_strong(p+3,1))) == "ZACA")
                new_strong(p,1) = 'A';
                new_strong(p+1,1) = 'C';
                new_strong(p+2,1) = 'C';
                new_strong(p+3,1) = 'A';
            end
        end
    end
end

updated_strong = convertCharsToStrings(new_strong);
end