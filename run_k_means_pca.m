function [B,Z] = run_k_means_pca(X,k,d)
%this function gets data points X, and performs K-means to cluster them.
%Later, in order to find the supspace from which each cluster was drawn
%from, we perform PCA on every set of data points from X that correspond to
%the same cluster. 
%return values - B is the a cell containing the subspaces, Z is a vector
%containing the clustering identities for each point.

%performing K-means:
Z = kmeans(X,k);
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
    %taking the leading d components 
    cur_b(:,1:cmin)= coeff(:,1:cmin);
    B{i}=  cur_b;
end
Z = Z'; %transposing Z to match previous dimension calls.

end