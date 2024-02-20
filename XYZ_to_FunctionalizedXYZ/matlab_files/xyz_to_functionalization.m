function [func_strongs] = xyz_to_functionalization(strong, functional_groups)

%% finding number of functional sites and functional groups


N_functional_site = count(strong,"Z") + count(strong,"A") + count(strong,"C") ;
N_functional_groups = size(functional_groups,1);
% creating a vector inidicating functional groups
v_functional = 1:1:N_functional_groups;
v_functional = v_functional';

%% finding all possible combinations for complete functionalization
functional_combination = permn(v_functional, N_functional_site); 


%% creating full functionalization STRONGs
functional_positions = strfind(strong,"Z");
functional_positions = [functional_positions, strfind(strong,"A")];
functional_positions = [functional_positions, strfind(strong,"C")];
functional_positions = sort(functional_positions);
functional_positions = functional_positions';

func_strongs = [];
counter = 0;

for i = 1:size(functional_combination,1)
    new_str = strong;
    for j = 1:size(functional_combination,2)
        position = functional_positions (j,1) + counter;
        new_str = insertAfter(new_str,position,functional_groups(functional_combination(i,j),1));
        counter = counter + 1;
    end
    counter = 0;
    func_strongs = [func_strongs;new_str];
end


end
