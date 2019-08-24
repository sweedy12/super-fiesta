function [per] = angle_performance(B_rec, B )
%this function gets the original subspaces B, and the recovered subspaces
%B_rec, and calculates the angle performance measure mentioned in the
%project description (1).
per = 0;
%going over all permutations
b_s = size(B_rec);
k= b_s(2);
P = perms(1:k);
s = size(P);
for i=1:s(1)
    cur_per = 0;
    %going over all supspaces:
    for j=1:s(2)
        temp = cos(subspace(B{j},B_rec{P(i,j)}));
        temp = temp*temp;
        cur_per = cur_per + temp;
    end
    if (cur_per > per)
        per = cur_per;
    end
end
end