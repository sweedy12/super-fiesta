function [B,Z, is_zero] = run_k_means_pca(X,k,d)
%this function gets data points X, and performs K-means to cluster them.
%Later, in order to find the supspace from which each cluster was drawn
%from, we perform PCA on every set of data points from X that correspond to
%the same cluster. 
%return values - B is the a cell containing the subspaces, Z is a vector
%containing the clustering identities for each point.

%performing K-means:
Z = kmeans(X,k);
[B, is_zero] = bases_for_clusters(X,Z,k,d);
Z = Z'; %transposing Z to match previous dimension calls.

end