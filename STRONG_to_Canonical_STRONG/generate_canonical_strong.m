function strong_canonical = generate_canonical_strong(strong)

n = strlength(strong);
appended_strong = append(strong,strong);
appended_strong = convertStringsToChars(appended_strong);

if (isempty(findstr(strong,"S")) == 0)
    strong_ref = (char(strong))';
    for k = 1:size(strong_ref,1)
        if (strong_ref(k,1) == 'S')
            if (strong_ref(k-1,1) == 'F')
                strong_ref(k,1) = strong_ref(k-1,1);
                strong_ref(k-1,1) = 'S';
            elseif (strong_ref(k-2,1) == 'F' && strong_ref(k-1,1) == 'A')
                strong_ref(k,1) = strong_ref(k-2,1);
                strong_ref(k-2,1) = 'S';
            elseif (strong_ref(k-3,1) == 'F' && strong_ref(k-2,1) == 'A' && strong_ref(k-1,1) == 'C')
                strong_ref(k,1) = strong_ref(k-3,1);
                strong_ref(k-1,1) = strong_ref(k-2,1);
                strong_ref(k-2,1) = 'C';
                strong_ref(k-3,1) = 'S';
            end
        end   
    end
    strong_ref = string(strong_ref');
else
    strong_ref = strong;
end



reverse_appended_strong = append(reverse(strong_ref),reverse(strong_ref));
reverse_appended_strong = convertStringsToChars(reverse_appended_strong);

strong_set = [];

for i = 1:n
    strong_set = [strong_set;appended_strong(1,[i:i+n-1])];
    strong_set = [strong_set;reverse_appended_strong(1,[i:i+n-1])];
end

B = sort(cellstr(strong_set));
strong_canonical = string(B(1,1));

end