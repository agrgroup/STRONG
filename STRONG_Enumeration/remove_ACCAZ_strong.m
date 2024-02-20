function unique_strongs = remove_ACCAZ_strong(strongs)
remove_index = [];

for i = 1:size(strongs,1)
    A = append (strongs(i,1), strongs(i,1));
    
    B = "ACCAZ";
    C = "ZACCA";
    D = "FFZFACCAFAAFF";
    E = "FFFACCAFACAFF";
    F = "FZFFACCAFACAFF";
    G = "FZFACCAFAAF";
    H = "FZFFACAFACCAFF";
    I = "FZFACAFACAFZFF";
    J = "ACCAA";
    K = "AAFACCAFZFZF";
    L = "FACAFACAFAAF";
    M = "AAFACCAFZF";

    
    P = contains(A,B);
    Q = contains(A,C);
    R = contains(A,D);
    S = contains(A,E);
    T = contains(A,F);
    U = contains(A,G);
    V = contains(A,H);
    W = contains(A,I);
    X = contains(A,J);
    Y = contains(A,K);
    Z = contains(A,L);
    AA = contains(A,M);
    
    if (P+Q+R+S+T+U+V+W+X+Y+Z+AA>0)
        remove_index = [remove_index;i];
    end
end


if (isempty(remove_index) == 0)
    strongs(remove_index,:) = [];
end

unique_strongs = strongs;

end