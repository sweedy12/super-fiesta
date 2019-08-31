function [ang_per_km,clust_per_km,ang_per_ssc,clust_per_ssc,alpha] = run_experiment(n,p,d,k,theta,sigma,tol,alpha_start)
%this function get all parameters required for sampling points, and runs
%k-means and SSC on it.


%sampling points
[X,B,Z,alpha] = sample_points(n,p,d,k,theta,sigma,tol,alpha_start);
%running K-means and PCA to recover the clusteing and subspaces. 
[B_km,Z_km,is_zero_km] = run_k_means_pca(X,k,d);
%getting the two performance measures
ang_per_km = angle_performance(B_km,B,is_zero_km);
clust_per_km = clustering_performance(Z_km,Z,k);

%running SSC algorithm to recover clustering:
if sigma == 0
%CMat = SparseCoefRecovery(X',0,'Lasso',0.01);
%[CMatC,sc,OutlierIndx,Fail] = OutlierDetection(CMat,Z);
%Z=sc;
%CKSym = BuildAdjacency1(CMat,d);
%[Z_ssc ,boo, LapKernel] = SpectralClustering1(CKSym,k);
%Z_ssc = Z_ssc(:,3);
    [clust_miss,Cmat, Z_ssc] = SSC(X',k,Z);
else
    [clust_miss,Cmat, Z_ssc] = SSC(X',k,Z);
end
%recovering the subspaces, and getting the performance measures:
[B_ssc,is_zero_ssc] = bases_for_clusters(X,Z_ssc,k,d);
Z_ssc = Z_ssc';
disp(size(Z_ssc))
disp(size(Z))
clust_per_ssc = clustering_performance(Z,Z_ssc,k);
ang_per_ssc = angle_performance(B_ssc,B,is_zero_ssc);


end