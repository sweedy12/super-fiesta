function [per] = clustering_performance(Z_rec,Z,k)
%this function gets the original clustering of the data points Z, and the
%recreated clustering of the data points Z_rec, and returns the performance
%measure which is the maximum (over all permutations) fraction of points
%clustered correctly.


z_s = size(Z_rec);
n= z_s(2);
per = 0;
%going over all permutations
P = perms(1:k);
s = size(P);
for i=1:s(1)
    cur_per = 0;
    %going over all supspaces:
    for j=1:n
        if (P(i,Z_rec(j)) == Z(j)) %good clustering, found match.
            cur_per = cur_per + 1;
        end
    end
    if (cur_per > per)
        per = cur_per;
    end
end
per = per / n;
end