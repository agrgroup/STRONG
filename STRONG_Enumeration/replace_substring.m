function [strong_updated] = replace_substring(strong)
strong = (convertStringsToChars(strong(1,1)))';

%% ZZ -> AA
for i = 1:size(strong,1)
    if (i==size(strong,1))
        if(strcat(string(strong(i,1)), string(strong(1,1))) == "ZZ")
            strong(i,1) = 'A';
            strong(1,1) = 'A';
        end
    else
        if(strcat(string(strong(i,1)), string(strong(i+1,1))) == "ZZ")
            strong(i,1) = 'A';
            strong(i+1,1) = 'A';
        end
    end
end

%% ZAA -> ACA or AAZ -> ACA
for i = 1:size(strong,1)
    if (i == size(strong,1)-1)
        if (strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(1,1))) == "ZAA" || strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(1,1))) == "AAZ")
            strong(i,1) = 'A';
            strong(i+1,1) = 'C';
            strong(1,1) = 'A';
        end
 
    elseif (i == size(strong,1))
        if (strcat(string(strong(i,1)), string(strong(1,1)), string(strong(2,1))) == "ZAA" || strcat(string(strong(i,1)), string(strong(1,1)), string(strong(2,1))) == "AAZ")
            strong(i,1) = 'A';
            strong(1,1) = 'C';
            strong(2,1) = 'A';
        end
    
    else
        if (strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(i+2,1))) == "ZAA" || strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(i+2,1))) == "AAZ")
            strong(i,1) = 'A';
            strong(i+1,1) = 'C';
            strong(i+2,1) = 'A';
        end
    end
end


%% ZACA -> ACCA or ACAZ -> ACCA
for i = 1:size(strong,1)
    if (i == size(strong,1)-2)
        if (strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(i+2,1)), string(strong(1,1))) == "ZACA" || strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(i+2,1)), string(strong(1,1))) == "ACAZ")
            strong(i,1) = 'A';
            strong(i+1,1) = 'C';
            strong(i+2,1) = 'C';
            strong(1,1) = 'A';
        end
 
    elseif (i == size(strong,1)-1)
        if (strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(1,1)), string(strong(2,1))) == "ZACA" || strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(1,1)), string(strong(2,1))) == "ACAZ")
            strong(i,1) = 'A';
            strong(i+1,1) = 'C';
            strong(1,1) = 'C';
            strong(2,1) = 'A';
        end
    elseif (i == size(strong,1))
        if (strcat(string(strong(i,1)), string(strong(1,1)), string(strong(2,1)), string(strong(3,1))) == "ZACA" || strcat(string(strong(i,1)), string(strong(1,1)), string(strong(2,1)), string(strong(3,1))) == "ACAZ")
            strong(i,1) = 'A';
            strong(1,1) = 'C';
            strong(2,1) = 'C';
            strong(3,1) = 'A';
        end
    
    else
        if (strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(i+2,1)), string(strong(i+3,1))) == "ZACA" || strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(i+2,1)), string(strong(i+3,1))) == "ACAZ")
            strong(i,1) = 'A';
            strong(i+1,1) = 'C';
            strong(i+2,1) = 'C';
            strong(i+3,1) = 'A';
        end
    end
end
strong_updated = convertCharsToStrings(strong);

%% ZAAZ -> ACCA
for i = 1:size(strong,1)
    if (i == size(strong,1)-2)
        if (strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(i+2,1)), string(strong(1,1))) == "ZAAZ")
            strong(i,1) = 'A';
            strong(i+1,1) = 'C';
            strong(i+2,1) = 'C';
            strong(1,1) = 'A';
        end
 
    elseif (i == size(strong,1)-1)
        if (strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(1,1)), string(strong(2,1))) == "ZAAZ")
            strong(i,1) = 'A';
            strong(i+1,1) = 'C';
            strong(1,1) = 'C';
            strong(2,1) = 'A';
        end
    elseif (i == size(strong,1))
        if (strcat(string(strong(i,1)), string(strong(1,1)), string(strong(2,1)), string(strong(3,1))) == "ZAAZ")
            strong(i,1) = 'A';
            strong(1,1) = 'C';
            strong(2,1) = 'C';
            strong(3,1) = 'A';
        end
    
    else
        if (strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(i+2,1)), string(strong(i+3,1))) == "ZAAZ")
            strong(i,1) = 'A';
            strong(i+1,1) = 'C';
            strong(i+2,1) = 'C';
            strong(i+3,1) = 'A';
        end
    end
end
strong_updated = convertCharsToStrings(strong);


%% ACCZ -> ACCA or ZACC -> ACCA or ZCCA -> ACCA or AAAA-> ACCA 

for i = 1:size(strong,1)
    if (i == size(strong,1)-2)
        if (strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(i+2,1)), string(strong(1,1))) == "ACCZ" || strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(i+2,1)), string(strong(1,1))) == "ZACC" || strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(i+2,1)), string(strong(1,1))) == "ZCCA" || strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(i+2,1)), string(strong(1,1))) == "AAAA")
            strong(i,1) = 'A';
            strong(i+1,1) = 'C';
            strong(i+2,1) = 'C';
            strong(1,1) = 'A';
        end
 
    elseif (i == size(strong,1)-1)
        if (strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(1,1)), string(strong(2,1))) == "ACCZ" || strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(1,1)), string(strong(2,1))) == "ZACC" || strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(1,1)), string(strong(2,1))) == "ZCCA" || strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(1,1)), string(strong(2,1))) == "AAAA")
            strong(i,1) = 'A';
            strong(i+1,1) = 'C';
            strong(1,1) = 'C';
            strong(2,1) = 'A';
        end
    elseif (i == size(strong,1))
        if (strcat(string(strong(i,1)), string(strong(1,1)), string(strong(2,1)), string(strong(3,1))) == "ACCZ" || strcat(string(strong(i,1)), string(strong(1,1)), string(strong(2,1)), string(strong(3,1))) == "ZACC" || strcat(string(strong(i,1)), string(strong(1,1)), string(strong(2,1)), string(strong(3,1))) == "ZCCA" || strcat(string(strong(i,1)), string(strong(1,1)), string(strong(2,1)), string(strong(3,1))) == "AAAA")
            strong(i,1) = 'A';
            strong(1,1) = 'C';
            strong(2,1) = 'C';
            strong(3,1) = 'A';
        end
    
    else
        if (strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(i+2,1)), string(strong(i+3,1))) == "ACCZ" || strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(i+2,1)), string(strong(i+3,1))) == "ZACC" || strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(i+2,1)), string(strong(i+3,1))) == "ZCCA"|| strcat(string(strong(i,1)), string(strong(i+1,1)), string(strong(i+2,1)), string(strong(i+3,1))) == "AAAA")
            strong(i,1) = 'A';
            strong(i+1,1) = 'C';
            strong(i+2,1) = 'C';
            strong(i+3,1) = 'A';
        end
    end
end
strong_updated = convertCharsToStrings(strong);

%%

end