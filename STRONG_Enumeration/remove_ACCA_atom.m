function [strong_ACCA_updated] = remove_ACCA_atom(strong_ACCA)
strong_ACCA_char = (convertStringsToChars(strong_ACCA(1,1)))';
strong = [];
strong_ACCA_updated = [];

%% This section takes a strong, find FACCAF in it and replace it by AA
for i = 1:size(strong_ACCA_char,1)
    if (i == size(strong_ACCA_char,1)-4)
        if (strcat(string(strong_ACCA_char(i,1)), string(strong_ACCA_char(i+1,1)), string(strong_ACCA_char(i+2,1)), string(strong_ACCA_char(i+3,1)),string(strong_ACCA_char(i+4,1)), string(strong_ACCA_char(1,1))) == "FACCAF")
            new_strong = [];
            for j = 2:size(strong_ACCA_char,1)-5
                new_strong = [new_strong;strong_ACCA_char(j,1)];
            end
            new_strong = [new_strong;'A'];
            new_strong = [new_strong;'A'];
            strong = [strong;convertCharsToStrings(new_strong)];
        end
 
    elseif (i == size(strong_ACCA_char,1)-3)
        if (strcat(string(strong_ACCA_char(i,1)), string(strong_ACCA_char(i+1,1)), string(strong_ACCA_char(i+2,1)), string(strong_ACCA_char(i+3,1)),string(strong_ACCA_char(1,1)), string(strong_ACCA_char(2,1))) == "FACCAF")
            new_strong = [];
            for j = 3:size(strong_ACCA_char,1)-4
                new_strong = [new_strong;strong_ACCA_char(j,1)];
            end
            new_strong = [new_strong;'A'];
            new_strong = [new_strong;'A'];
            strong = [strong;convertCharsToStrings(new_strong)];
        end
    
    elseif (i == size(strong_ACCA_char,1)-2)
        if (strcat(string(strong_ACCA_char(i,1)), string(strong_ACCA_char(i+1,1)), string(strong_ACCA_char(i+2,1)), string(strong_ACCA_char(1,1)),string(strong_ACCA_char(2,1)), string(strong_ACCA_char(3,1))) == "FACCAF")
            new_strong = [];
            for j = 4:size(strong_ACCA_char,1)-3
                new_strong = [new_strong;strong_ACCA_char(j,1)];
            end
            new_strong = [new_strong;'A'];
            new_strong = [new_strong;'A'];
            strong = [strong;convertCharsToStrings(new_strong)];
        end
    elseif(i == size(strong_ACCA_char,1)-1)
        if (strcat(string(strong_ACCA_char(i,1)), string(strong_ACCA_char(i+1,1)), string(strong_ACCA_char(1,1)), string(strong_ACCA_char(2,1)),string(strong_ACCA_char(3,1)), string(strong_ACCA_char(4,1))) == "FACCAF")
            new_strong = [];
            for j = 5:size(strong_ACCA_char,1)-2
                new_strong = [new_strong;strong_ACCA_char(j,1)];
            end
            new_strong = [new_strong;'A'];
            new_strong = [new_strong;'A'];
            strong = [strong;convertCharsToStrings(new_strong)];
        end
    elseif(i == size(strong_ACCA_char,1))
        if (strcat(string(strong_ACCA_char(i,1)), string(strong_ACCA_char(1,1)), string(strong_ACCA_char(2,1)), string(strong_ACCA_char(3,1)),string(strong_ACCA_char(4,1)), string(strong_ACCA_char(5,1))) == "FACCAF")
            new_strong = [];
            for j = 6:size(strong_ACCA_char,1)-1
                new_strong = [new_strong;strong_ACCA_char(j,1)];
            end
            new_strong = [new_strong;'A'];
            new_strong = [new_strong;'A'];
            strong = [strong;convertCharsToStrings(new_strong)];
        end        
    else
        if (strcat(string(strong_ACCA_char(i,1)), string(strong_ACCA_char(i+1,1)), string(strong_ACCA_char(i+2,1)), string(strong_ACCA_char(i+3,1)),string(strong_ACCA_char(i+4,1)), string(strong_ACCA_char(i+5,1))) == "FACCAF")
            new_strong = [];
            for j = 1:size(strong_ACCA_char,1)
                if (j == i)
                    new_strong = [new_strong;'A'];
                elseif (j== i+1)
                    new_strong = [new_strong;'A'];
                elseif (j == i+2)
                elseif (j == i+3)
                elseif (j == i+4)
                elseif (j == i+5)
                else
                    new_strong = [new_strong;strong_ACCA_char(j,1)];
                end
            end
            strong = [strong;convertCharsToStrings(new_strong)];
        end
    end
    
end

%% This section takes the new strongs and replace ZZ->AA, ZAA->ACA, AAZ->ACA, ZACA->ACCA, ACAZ->ACCA
for i = 1:size(strong,1)
    updated_strong = replace_substring(strong(i,1));
    strong_ACCA_updated = [strong_ACCA_updated;updated_strong];
end

end