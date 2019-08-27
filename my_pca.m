function [PC, PV] = my_pca(X)
C = cov(X) ;   % co-variance matrix 
[V,D] = eig(C) ;  % GEt Eigenvalues and Eigenvectors 
Eig = diag(D) ;
[val,idx] = sort(Eig,'descend') ;
PV = Eig(idx)
PC = V(:,idx)
end