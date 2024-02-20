function generate_strongs()

%% reading xyz files
% asking user to select the folder where xyz files are present
cd xyz_file
d = pwd;
% storing the xyz file details in files variable
xyz_files = dir(fullfile(d, '*.xyz'));

%% Generating STRONGS from the xyz files
strongs = [];
circular_pore = [];
horse_shoe_strongs = [];
horse_shoe_pore = [];
disp('STRONGS generation started')

file_ID = fopen('horshoe_pore.txt','w');
str = sprintf('Horse-Shoe File ID');
fprintf(file_ID,'%s \n',str);

for i = 1:size(xyz_files,1)
    try
        A = xyz_to_strongs(xyz_files(i,1).name,d);
        strongs = [strongs;A];
        circular_pore = [circular_pore;convertCharsToStrings(xyz_files(i,1).name)];
    catch
        try
            B = horse_xyz_to_strongs(xyz_files(i,1).name,d);
            horse_shoe_strongs = [horse_shoe_strongs;B];
            horse_shoe_pore = [horse_shoe_pore;convertCharsToStrings(xyz_files(i,1).name)];
        catch
            fprintf(file_ID,'%s \n',convertCharsToStrings(xyz_files(i,1).name));
        end
    end
end
fclose(file_ID);

strongs = [strongs;horse_shoe_strongs];
circular_pore = [circular_pore;horse_shoe_pore];

disp('Strongs have been generated')

%% writing text files
cd ..
cd text_files
fileID = fopen('STRONGS.txt','w');
str = sprintf('STRONGS of xyz file');
fprintf(fileID,'%s \n',str);
fprintf(fileID,'%s \t %s \n','file_name','STRONGS');
for i = 1:size(strongs,1)
    fprintf(fileID,'%s \t %s \n',circular_pore(i,1),strongs(i,1)); 
end
fclose(fileID);

end