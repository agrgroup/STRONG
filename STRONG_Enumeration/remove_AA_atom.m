function [strong_AA_updated] = remove_AA_atom(strong_AA)
strong_AA_char = (convertStringsToChars(strong_AA(1,1)))';
strong = [];
strong_AA_updated = [];
%% This section takes a strong, find FAAF in it and replace it by ZFFZ
for i = 1:size(strong_AA_char,1)
    if (i == 1)
        if (strcat(string(strong_AA_char(size(strong_AA_char,1),1)), string(strong_AA_char(i,1)), string(strong_AA_char(i+1,1)), string(strong_AA_char(i+2,1))) == "FAAF")
            new_strong = strong_AA_char;
            new_strong(size(strong_AA_char,1),1) = 'Z';
            new_strong(i,1) = 'F';
            new_strong(i+1,1) = 'F';
            new_strong(i+2,1) = 'Z';
            strong = [strong;convertCharsToStrings(new_strong)];
        end
 
    elseif (i == size(strong_AA_char,1))
        if (strcat(string(strong_AA_char(i-1,1)), string(strong_AA_char(i,1)), string(strong_AA_char(1,1)), string(strong_AA_char(2,1))) == "FAAF")
            new_strong = strong_AA_char;
            new_strong(i-1,1) = 'Z';
            new_strong(i,1) = 'F';
            new_strong(1,1) = 'F';
            new_strong(2,1) = 'Z';
            strong = [strong;convertCharsToStrings(new_strong)];
        end
    
    elseif (i == size(strong_AA_char,1)-1)
        if (strcat(string(strong_AA_char(i-1,1)), string(strong_AA_char(i,1)), string(strong_AA_char(i+1,1)), string(strong_AA_char(1,1))) == "FAAF")
            new_strong = strong_AA_char;
            new_strong(i-1,1) = 'Z';
            new_strong(i,1) = 'F';
            new_strong(i+1,1) = 'F';
            new_strong(1,1) = 'Z';
            strong = [strong;convertCharsToStrings(new_strong)];
        end
    else
        if (strcat(string(strong_AA_char(i-1,1)), string(strong_AA_char(i,1)), string(strong_AA_char(i+1,1)), string(strong_AA_char(i+2,1))) == "FAAF")
            new_strong = strong_AA_char;
            new_strong(i-1,1) = 'Z';
            new_strong(i,1) = 'F';
            new_strong(i+1,1) = 'F';
            new_strong(i+2,1) = 'Z';
            strong = [strong;convertCharsToStrings(new_strong)];
        end
    end
    
end

%% This section takes the new strongs and replace ZZ->AA, ZAA->ACA, AAZ->ACA, ZACA->ACCA, ACAZ->ACCA
for i = 1:size(strong,1)
    updated_strong = replace_substring(strong(i,1));
    strong_AA_updated = [strong_AA_updated;updated_strong];
end

end