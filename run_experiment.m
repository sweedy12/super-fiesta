function [ang_per_km,clust_per_km,alpha] = run_experiment(n,p,d,k,theta,sigma,tol,alpha_start)
%this function get all parameters required for sampling points, and runs
%k-means and SSC on it.

%sampling points
[X,B,Z,alpha] = sample_points(n,p,d,k,theta,sigma,tol,alpha_start);
%running K-means and PCA to recover the clusteing and subspaces. 
[B_km,Z_km] = run_k_means_pca(X,k,d);
%getting the two performance measures
ang_per_km = angle_performance(B_km,B);
clust_per_km = clustering_performance(Z_km,Z,k);

%running SSC algorithm to recover clustering:
[clust_miss,Cmat, Z_ssc] = SSC(X',k,Z);
%recovering the subspaces, and getting the performance measures:


clust_per_ssc = clustering_performance(Z,Z_ssc,k);


end