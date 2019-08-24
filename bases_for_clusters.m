function [B] = bases_for_clusters(X,Z,k,ds)
B = cell(1,k);
Xs = size(X);
p = Xs(2);
%going through all clusters, performing PCA:
for i=1:k
    %creating array to hold the current base:
    cur_b = zeros(p,d);
    clu_ind = find(Z==i);
    clu_points = X(clu_ind,:);
    coeff = pca(clu_points);
    %making sure the base would be padded (when n < p)
    cs = size(coeff);
    cmin  = min(cs(2),d);
    %taking the leading d components to be the basis
    cur_b(:,1:cmin)= coeff(:,1:cmin);
    B{i}=  cur_b;
end
end