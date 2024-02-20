function [updated_index_Z_atoms] = remove_Z_index(stable_strongs, index_Z_atoms)

updated_index_Z_atoms = [];
stable_strongs = (convertStringsToChars(stable_strongs(1,1)))';
counter = 0;

%%
for i = 1:size(index_Z_atoms,1)
    % ZFACCAF 
    if(index_Z_atoms(i,1) == size(stable_strongs,1)-5)
        if (strcat(string(stable_strongs(index_Z_atoms(i,1),1)), string(stable_strongs(index_Z_atoms(i,1)+1,1)), string(stable_strongs(index_Z_atoms(i,1)+2,1)), string(stable_strongs(index_Z_atoms(i,1)+3,1)), string(stable_strongs(index_Z_atoms(i,1)+4,1)), string(stable_strongs(index_Z_atoms(i,1)+5,1)), string(stable_strongs(1,1))) == "ZFACCAF")
            counter = 1;
        end
        
    elseif(index_Z_atoms(i,1) == size(stable_strongs,1)-4)
        if (strcat(string(stable_strongs(index_Z_atoms(i,1),1)), string(stable_strongs(index_Z_atoms(i,1)+1,1)), string(stable_strongs(index_Z_atoms(i,1)+2,1)), string(stable_strongs(index_Z_atoms(i,1)+3,1)), string(stable_strongs(index_Z_atoms(i,1)+4,1)), string(stable_strongs(1,1)), string(stable_strongs(2,1))) == "ZFACCAF")
            counter = 1;
        end
        
    elseif(index_Z_atoms(i,1) == size(stable_strongs,1)-3)
        if (strcat(string(stable_strongs(index_Z_atoms(i,1),1)), string(stable_strongs(index_Z_atoms(i,1)+1,1)), string(stable_strongs(index_Z_atoms(i,1)+2,1)), string(stable_strongs(index_Z_atoms(i,1)+3,1)), string(stable_strongs(1,1)), string(stable_strongs(2,1)), string(stable_strongs(3,1))) == "ZFACCAF")
            counter = 1;
        end
        
    elseif(index_Z_atoms(i,1) == size(stable_strongs,1)-2)
        if (strcat(string(stable_strongs(index_Z_atoms(i,1),1)), string(stable_strongs(index_Z_atoms(i,1)+1,1)), string(stable_strongs(index_Z_atoms(i,1)+2,1)), string(stable_strongs(1,1)), string(stable_strongs(2,1)), string(stable_strongs(3,1)), string(stable_strongs(4,1))) == "ZFACCAF")
            counter = 1;
        end
    elseif(index_Z_atoms(i,1) == size(stable_strongs,1)-1)
        if (strcat(string(stable_strongs(index_Z_atoms(i,1),1)), string(stable_strongs(index_Z_atoms(i,1)+1,1)), string(stable_strongs(1,1)), string(stable_strongs(2,1)), string(stable_strongs(3,1)), string(stable_strongs(4,1)), string(stable_strongs(5,1))) == "ZFACCAF")
            counter = 1;
        end
    elseif(index_Z_atoms(i,1) == size(stable_strongs,1))
        if (strcat(string(stable_strongs(index_Z_atoms(i,1),1)), string(stable_strongs(1,1)), string(stable_strongs(2,1)), string(stable_strongs(3,1)), string(stable_strongs(4,1)), string(stable_strongs(5,1)), string(stable_strongs(6,1))) == "ZFACCAF")
            counter = 1;
        end
    else
        if (strcat(string(stable_strongs(index_Z_atoms(i,1),1)), string(stable_strongs(index_Z_atoms(i,1)+1,1)), string(stable_strongs(index_Z_atoms(i,1)+2,1)), string(stable_strongs(index_Z_atoms(i,1)+3,1)), string(stable_strongs(index_Z_atoms(i,1)+4,1)), string(stable_strongs(index_Z_atoms(i,1)+5,1)), string(stable_strongs(index_Z_atoms(i,1)+6,1))) == "ZFACCAF")
            counter = 1;
        end
    end
    
    % FACCAFZ 
    if(index_Z_atoms(i,1) == 6)
        if (strcat(string(stable_strongs(end,1)), string(stable_strongs(index_Z_atoms(i,1)-5,1)), string(stable_strongs(index_Z_atoms(i,1)-4,1)), string(stable_strongs(index_Z_atoms(i,1)-3,1)), string(stable_strongs(index_Z_atoms(i,1)-2,1)), string(stable_strongs(index_Z_atoms(i,1)-1,1)), string(stable_strongs(index_Z_atoms(i,1),1))) == "FACCAFZ")
            counter = 1;
        end
    elseif(index_Z_atoms(i,1) == 5)
        if (strcat(string(stable_strongs(end-1,1)), string(stable_strongs(end,1)), string(stable_strongs(index_Z_atoms(i,1)-4,1)), string(stable_strongs(index_Z_atoms(i,1)-3,1)), string(stable_strongs(index_Z_atoms(i,1)-2,1)), string(stable_strongs(index_Z_atoms(i,1)-1,1)), string(stable_strongs(index_Z_atoms(i,1),1))) == "FACCAFZ")
            counter = 1;
        end
    elseif(index_Z_atoms(i,1) == 4)
        if (strcat(string(stable_strongs(end-2,1)), string(stable_strongs(end-1,1)), string(stable_strongs(end,1)), string(stable_strongs(index_Z_atoms(i,1)-3,1)), string(stable_strongs(index_Z_atoms(i,1)-2,1)), string(stable_strongs(index_Z_atoms(i,1)-1,1)), string(stable_strongs(index_Z_atoms(i,1),1))) == "FACCAFZ")
            counter = 1;
        end
    elseif(index_Z_atoms(i,1) == 3)
        if (strcat(string(stable_strongs(end-3,1)), string(stable_strongs(end-2,1)), string(stable_strongs(end-1,1)), string(stable_strongs(end,1)), string(stable_strongs(index_Z_atoms(i,1)-2,1)), string(stable_strongs(index_Z_atoms(i,1)-1,1)), string(stable_strongs(index_Z_atoms(i,1),1))) == "FACCAFZ")
            counter = 1;
        end
    elseif(index_Z_atoms(i,1) == 2)
        if (strcat(string(stable_strongs(end-4,1)), string(stable_strongs(end-3,1)), string(stable_strongs(end-2,1)), string(stable_strongs(end-1,1)), string(stable_strongs(end,1)), string(stable_strongs(index_Z_atoms(i,1)-1,1)), string(stable_strongs(index_Z_atoms(i,1),1))) == "FACCAFZ")
            counter = 1;
        end
    elseif(index_Z_atoms(i,1) == 1)
        if (strcat(string(stable_strongs(end-5,1)), string(stable_strongs(end-4,1)), string(stable_strongs(end-3,1)), string(stable_strongs(end-2,1)), string(stable_strongs(end-1,1)), string(stable_strongs(end,1)), string(stable_strongs(index_Z_atoms(i,1),1))) == "FACCAFZ")
            counter = 1;
        end
    else
        if (strcat(string(stable_strongs(index_Z_atoms(i,1)-6,1)), string(stable_strongs(index_Z_atoms(i,1)-5,1)), string(stable_strongs(index_Z_atoms(i,1)-4,1)), string(stable_strongs(index_Z_atoms(i,1)-3,1)), string(stable_strongs(index_Z_atoms(i,1)-2,1)), string(stable_strongs(index_Z_atoms(i,1)-1,1)), string(stable_strongs(index_Z_atoms(i,1),1))) == "FACCAFZ")
            counter = 1;
        end
    end
    
    % cheking for counter 
    if (counter == 0)
        updated_index_Z_atoms = [updated_index_Z_atoms;index_Z_atoms(i,1)];
    end
    
    counter = 0;
    
end



end