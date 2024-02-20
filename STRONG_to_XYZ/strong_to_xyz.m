tic
%% reading the input file containing STRONGs for which xyz files has to be developed
fid = fopen("strongs.txt", 'r');
tline = fgets(fid);
tline = fgets(fid);
strong = [];
while ischar(tline)
    data = (strtrim(tline));
    strong = [strong;convertCharsToStrings(data)];
    tline = fgets(fid);
end
fclose(fid);

%% global variables
global i;
global j; 
global k;
global direct;

%% Generating the xyz file for a set of STRONGS
file_number = 0;

for strong_count = 1:size(strong,1)
    %% User input for number of atoms in a pristine sheet
    C = num2cell(convertStringsToChars(strong(strong_count,1)));
    len = size(C,2);
    numb = 968; %input number of atoms here {648, 722, 800}: for pristine graphene sheet, the number of atoms are double of the square of a whole number.
    %% This creates a pristine sheet atom indices 
    A = zeros(numb, 3); % Matrix to store the atom indices of a pristine graphhene sheet
    row = sqrt(numb/2); % Number of unit cells in a row of a graphene sheet
    
    % initializing the i,j,k (index values)
    i = 1;
    j = 1;
    k = 1;
    % This loop is providing a number index to each atom in pristine sheet, j represents movement in x direction, i represents movement in y direction, k represents lower (1) or upper atom (2) in a unit cell of graphene sheet.
    for p = 1:numb
        A(p, 1) = i;
        A(p, 2) = j;
        A(p, 3) = k;

        if(j == row && k == 2)
            i = i+1; 
            j = 1; 
        elseif(j ~= row && k == 2)
            j = j+1; 
        end

        if(k == 1)
            k = 2; 
        else
            k = 1; 
        end   
    end
    
    %% Finding the rim atoms based on STRONG
    % This picks up the center atom in the pristine graphene sheet.
    i = (row/2); 
    j = (row/2)-1;  
    k = 1;
    % initializing the direction variable and this has to be fixed (i.e. do not chnage this direct variable value) 
    direct = 4; 
    
    % Matrix to store (i,j,k) for rim atoms
    B = [];
    B = [B; [i,j,k]];
    % This loop traces the rim from second to final character of the strong
    for count_char = 2:len
        if (C{count_char} == 'A')
            if (C{count_char-1} == 'F')
                f_a();
            elseif (C{count_char-1} == 'C')
                c_a();
            elseif (C{count_char-1} == 'A')
                a_a();
            end
        elseif (C{count_char} == 'C')
            if (C{count_char-1} == 'A')
                a_c();
            elseif (C{count_char-1} == 'C')
                c_c();
            end

        elseif (C{count_char} == 'F')
            if (C{count_char-1} == 'A')
                a_f();
            elseif (C{count_char-1} == 'Z')
                z_f();
            elseif (C{count_char-1} == 'F')
                f_f();
            end

        elseif (C{count_char} == 'Z')
            if (C{count_char-1} == 'F')
                f_z();
            end
        end
        B = [B; [i,j,k]];
    end 

    %% Genrating the coordinates of a pristine graphene sheet

    coords = zeros (numb,3);
    bond_length = 1.42260;
    theta = 30*(pi/180);

    for atom = 1:numb
        if (rem(A(atom,1),2) ~= 0)
            coords(atom,1) = (A(atom,2)-1)* (2*bond_length*cos(theta));
            coords(atom,2) = (A(atom,3)-1) * bond_length + (A(atom,1)-1) * bond_length * (1+ sin(theta));
            coords(atom,3) = 0;  
        elseif (rem(A(atom,1),2) == 0)
            coords(atom,1) = (A(atom,2)-1)* (2*bond_length*cos(theta)) + bond_length * cos(theta);
            coords(atom,2) = (A(atom,3)-1) * bond_length + (A(atom,1)-1) * bond_length * (1+ sin(theta));
            coords(atom,3) = 0;
        end 
    end
    
    %% The index of atoms in B are representative of rim atoms

    rim_coords = zeros(size(B,1),3);

    for atom = 1:size(B,1)
        if (rem(B(atom,1),2) ~= 0)
            rim_coords(atom,1) = (B(atom,2)-1)* (2*bond_length*cos(theta));
            rim_coords(atom,2) = (B(atom,3)-1) * bond_length + (B(atom,1)-1) * bond_length * (1+ sin(theta));
            rim_coords(atom,3) = 0;  
        elseif (rem(B(atom,1),2) == 0)
            rim_coords(atom,1) = (B(atom,2)-1)* (2*bond_length*cos(theta)) + bond_length * cos(theta);
            rim_coords(atom,2) = (B(atom,3)-1) * bond_length + (B(atom,1)-1) * bond_length * (1+sin(theta));
            rim_coords(atom,3) = 0;
        end 
    end
    
    %% findind the points inside the rim atoms
    [in, on] = inpolygon(coords(:,1), coords(:,2), rim_coords(:,1), rim_coords(:,2));
    in = in-on;
    
    %% writing final nanopore coords
    nanopore_coords = [];

    for atom = 1:size(coords,1)
        if (in(atom,1) == 0)
            nanopore_coords = [nanopore_coords;[coords(atom,1), coords(atom,2), coords(atom,3)]];     
        end
    end
    
    %% writing an xyz file for a STRONG
    file_number = file_number + 1;

    fileID = fopen(strcat(string(file_number), ".xyz"),'w');%"file", 
    fprintf(fileID,'%d \n',size(nanopore_coords,1));
    str_head = sprintf('Graphene Nanopore');
    fprintf(fileID,'%s \n',str_head);

    for m = 1:size(nanopore_coords,1)
        fprintf(fileID,'%s \t %.6f \t %.6f \t %.6f \n','C', nanopore_coords(m,1), nanopore_coords(m,2), nanopore_coords(m,3));
    end

    fclose(fileID);
   
end

toc
%% Funtions are written below

% there are in total 10 functions. The first function "forward" deals with the change in (i,j,k) indices based on the direction to which we have to travel.
% All other function contains the chnage in direction which is based in the previous direction and the atom where we are reaching and atom where we are present. 

function forward()
global i;
global j;
global k;
global direct;

if (direct == 1)
    i = i;
    j = j;
    k = k+1;

elseif (direct == 2)
    if (rem(i,2) == 0)
        i = i+1;
        j = j+1;
        k = k-1;
    else
        i = i+1;
        j = j;
        k = k-1;
    end
    
elseif (direct == 3)
    if (rem(i,2) == 0)
        i = i-1;
        j = j+1;
        k = k+1;
    else
        i = i-1;
        j = j;
        k = k+1;
    end

elseif (direct == 4)
    i = i;
    j= j;
    k = k-1;

elseif (direct == 5)
    if (rem(i,2) == 0)
        i = i+1;
        j = j;
        k = k-1;
    else
        i = i+1;
        j = j-1;
        k = k-1;
    end

elseif (direct == 6)
    if (rem (i,2) == 0)
        i = i-1;
        j = j;
        k = k+1;
    else
        i = i-1;
        j = j-1;
        k = k+1;
    end
end
end

function f_a()
global direct; 
if (direct == 1)
    direct = direct - 2 + 6;
elseif (direct == 2)
    direct = direct - 1;
elseif (direct == 3)
    direct = direct - 1;
elseif (direct == 4)
    direct = direct - 1;
elseif (direct == 5)
    direct = direct + 1;
elseif (direct == 6)
    direct = direct - 2;
end

forward();
end

function a_c()
global direct;
if (direct == 1)
    direct = direct + 1;
elseif (direct == 2)
    direct = direct + 1;
elseif (direct == 3)
    direct = direct + 1;
elseif (direct == 4)
    direct = direct + 2;
elseif (direct == 5)
    direct = direct + 2 - 6;
elseif (direct == 6)
    direct = direct - 1;
end

forward();
end

function c_c()
global direct;
if (direct == 1)
    direct = direct + 1;
elseif (direct == 2)
    direct = direct + 1;
elseif (direct == 3)
    direct = direct + 1;
elseif (direct == 4)
    direct = direct + 2;
elseif (direct == 5)
    direct = direct + 2 - 6;
elseif (direct == 6)
    direct = direct - 1;
end

forward();
end
 
function c_a()
global direct;
if (direct == 1)
    direct = direct + 1;
elseif (direct == 2)
    direct = direct + 1;
elseif (direct == 3)
    direct = direct + 1;
elseif (direct == 4)
    direct = direct + 2;
elseif (direct == 5)
    direct = direct + 2 - 6;
elseif (direct == 6)
    direct = direct - 1;
end

forward();
end
 

function a_f()
global direct;
if (direct == 1)
    direct = direct + 1;
elseif (direct == 2)
    direct = direct + 1;
elseif (direct == 3)
    direct = direct + 1;
elseif (direct == 4)
    direct = direct + 2;
elseif (direct == 5)
    direct = direct + 2 -6;
elseif (direct == 6)
    direct = direct - 1;
end

forward();
end 

function a_a()
global direct;
if (direct == 1)
    direct = direct + 1;
elseif (direct == 2)
    direct = direct + 1;
elseif (direct == 3)
    direct = direct + 1;
elseif (direct == 4)
    direct = direct + 2;
elseif (direct == 5)
    direct = direct + 2 - 6;
elseif (direct == 6)
    direct = direct - 1;
end

forward();
end 

function f_z()
global direct;
if (direct == 1)
    direct = direct - 2 + 6;
elseif (direct == 2)
    direct = direct - 1;
elseif (direct == 3)
    direct = direct - 1;
elseif (direct == 4)
    direct = direct - 1;
elseif (direct == 5)
    direct = direct + 1;
elseif (direct == 6)
    direct = direct - 2;
end

forward ();
end 

function z_f()
global direct;
if (direct == 1)
    direct = direct + 1;
elseif (direct == 2)
    direct = direct + 1;
elseif (direct == 3)
    direct = direct + 1;
elseif (direct == 4)
    direct = direct + 2;
elseif (direct == 5)
    direct = direct + 2 - 6;
elseif (direct == 6)
    direct = direct - 1;
end

forward();
end 

function f_f()
global direct;
if (direct == 1)
    direct = direct - 2 + 6;
elseif (direct == 2)
    direct = direct - 1;
elseif (direct == 3)
    direct = direct - 1;
elseif (direct == 4)
    direct = direct - 1;
elseif (direct == 5)
    direct = direct + 1;
elseif (direct == 6)
    direct = direct - 2;
end

forward();
end 








