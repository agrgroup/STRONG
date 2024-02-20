function [strong_ACA_updated] = remove_ACA_atom(strong_ACA)
strong_ACA_char = (convertStringsToChars(strong_ACA(1,1)))';
strong = [];
strong_ACA_updated = [];

%% This section takes a strong, find FACAF in it and replace it by ZFZ
for i = 1:size(strong_ACA_char,1)
    if (i == size(strong_ACA_char,1)-3)
        if (strcat(string(strong_ACA_char(i,1)), string(strong_ACA_char(i+1,1)), string(strong_ACA_char(i+2,1)), string(strong_ACA_char(i+3,1)), string(strong_ACA_char(1,1))) == "FACAF")
            new_strong = [];
            for j = 2:size(strong_ACA_char,1)-4
                new_strong = [new_strong;strong_ACA_char(j,1)];
            end
            new_strong = [new_strong;'Z'];
            new_strong = [new_strong;'F'];
            new_strong = [new_strong;'Z'];
            strong = [strong;convertCharsToStrings(new_strong)];
        end
 
    elseif (i == size(strong_ACA_char,1)-2)
        if (strcat(string(strong_ACA_char(i,1)), string(strong_ACA_char(i+1,1)), string(strong_ACA_char(i+2,1)), string(strong_ACA_char(1,1)), string(strong_ACA_char(2,1))) == "FACAF")
            new_strong = [];
            for j = 3:size(strong_ACA_char,1)-3
                new_strong = [new_strong;strong_ACA_char(j,1)];
            end
            new_strong = [new_strong;'Z'];
            new_strong = [new_strong;'F'];
            new_strong = [new_strong;'Z'];
            strong = [strong;convertCharsToStrings(new_strong)];
        end
    
    elseif (i == size(strong_ACA_char,1)-1)
        if (strcat(string(strong_ACA_char(i,1)), string(strong_ACA_char(i+1,1)), string(strong_ACA_char(1,1)), string(strong_ACA_char(2,1)), string(strong_ACA_char(3,1))) == "FACAF")
            new_strong = [];
            for j = 4:size(strong_ACA_char,1)-2
                new_strong = [new_strong;strong_ACA_char(j,1)];
            end
            new_strong = [new_strong;'Z'];
            new_strong = [new_strong;'F'];
            new_strong = [new_strong;'Z'];
            strong = [strong;convertCharsToStrings(new_strong)];
        end
    elseif(i == size(strong_ACA_char,1))
        if (strcat(string(strong_ACA_char(i,1)), string(strong_ACA_char(1,1)), string(strong_ACA_char(2,1)), string(strong_ACA_char(3,1)), string(strong_ACA_char(4,1))) == "FACAF")
            new_strong = [];
            for j = 5:size(strong_ACA_char,1)-1
                new_strong = [new_strong;strong_ACA_char(j,1)];
            end
            new_strong = [new_strong;'Z'];
            new_strong = [new_strong;'F'];
            new_strong = [new_strong;'Z'];
            strong = [strong;convertCharsToStrings(new_strong)];
        end
        
    else
        if (strcat(string(strong_ACA_char(i,1)), string(strong_ACA_char(i+1,1)), string(strong_ACA_char(i+2,1)), string(strong_ACA_char(i+3,1)), string(strong_ACA_char(i+4,1))) == "FACAF")
            new_strong = [];
            for j = 1:size(strong_ACA_char,1)
                if (j == i)
                    new_strong = [new_strong;'Z'];
                elseif (j== i+1)
                    new_strong = [new_strong;'F'];
                elseif (j == i+2)
                    new_strong = [new_strong;'Z'];
                elseif (j == i+3)
                elseif (j == i+4)
                else
                    new_strong = [new_strong;strong_ACA_char(j,1)];
                end
            end
            strong = [strong;convertCharsToStrings(new_strong)];
        end
    end
    
end

%% This section takes the new strongs and replace ZZ->AA, ZAA->ACA, AAZ->ACA, ZACA->ACCA, ACAZ->ACCA
for i = 1:size(strong,1)
    updated_strong = replace_substring(strong(i,1));
    strong_ACA_updated = [strong_ACA_updated;updated_strong];
end

end