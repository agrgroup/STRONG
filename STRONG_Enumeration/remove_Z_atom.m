function [strong] = remove_Z_atom(stable_strongs)
strong = [];
index_Z_atoms = (strfind(stable_strongs(1,1), "Z"))';

index_Z_atoms = remove_Z_index(stable_strongs(1,1), index_Z_atoms);
% here I have to write a function to remove index of Z atoms which are either second atom to the left or second atom to the right of ACCA substring

for k = 1:size(index_Z_atoms,1)
    strong_char = (convertStringsToChars(stable_strongs(1,1)))';
    if (index_Z_atoms(k,1) == 1)
        counter = 1;
        counter_m = 1;
        for m = 1:size(strong_char,1)-2
            if (m == index_Z_atoms(k,1))
                left_Z_position = counter;
                new_strong (counter,1) = 'Z';
                counter = counter + 1;
                new_strong (counter,1) = 'F';
                counter = counter + 1;
                new_strong (counter,1) = 'F';
                counter = counter + 1;
                new_strong (counter,1) = 'F';
                counter = counter + 1;
                right_Z_position = counter;
                new_strong (counter,1) = 'Z';
                counter = counter + 1;
                counter_m = counter_m + 2;
            else
                new_strong (counter,1) = strong_char(counter_m,1);
                counter = counter+1;
                counter_m = counter_m + 1;
            end
        end
    elseif (index_Z_atoms(k,1) == size(strong_char,1))
        counter = 1;
        counter_m = 2;
        for m = 2:size(strong_char,1)-1
            if (m == index_Z_atoms(k,1)-1)
                left_Z_position = counter;
                new_strong (counter,1) = 'Z';
                counter = counter + 1;
                new_strong (counter,1) = 'F';
                counter = counter + 1;
                new_strong (counter,1) = 'F';
                counter = counter + 1;
                new_strong (counter,1) = 'F';
                counter = counter + 1;
                right_Z_position = counter;
                new_strong (counter,1) = 'Z';
                counter = counter + 1;
                counter_m = counter_m + 3;
            else
                new_strong (counter,1) = strong_char(counter_m,1);
                counter = counter+1;
                counter_m = counter_m + 1;
            end
        end
    else
        counter = 1;
        counter_m = 1;
        for m = 1:size(strong_char,1)-2
            if (m == index_Z_atoms(k,1)-1)
                left_Z_position = counter;
                new_strong (counter,1) = 'Z';
                counter = counter + 1;
                new_strong (counter,1) = 'F';
                counter = counter + 1;
                new_strong (counter,1) = 'F';
                counter = counter + 1;
                new_strong (counter,1) = 'F';
                counter = counter + 1;
                right_Z_position = counter;
                new_strong (counter,1) = 'Z';
                counter = counter + 1;
                counter_m = counter_m + 3;
            else
                new_strong (counter,1) = strong_char(counter_m,1);
                counter = counter+1;
                counter_m = counter_m + 1;
            end
        end
    end
    new_strong_1 = new_strong;
    new_strong_2 = convertCharsToStrings(new_strong_1);
    updated_strong = consecutive_Z_atoms(new_strong_2, left_Z_position, right_Z_position);
    strong = [strong;updated_strong];
end

end