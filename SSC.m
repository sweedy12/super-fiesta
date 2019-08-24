%--------------------------------------------------------------------------
% This is the function to call the sparse optimization program, to call the 
% spectral clustering algorithm and to compute the clustering error.
% r = projection dimension, if r = 0, then no projection
% affine = use the affine constraint if true
% s = clustering ground-truth
% missrate = clustering error
% CMat = coefficient matrix obtained by SSC
%--------------------------------------------------------------------------
% Copyright @ Ehsan Elhamifar, 2012
%--------------------------------------------------------------------------

function [missrate,CMat, grps] = SSC(X,r,s,affine,alpha,outlier,rho)

if (nargin < 7)
    rho = 1;
end
if (nargin < 6)
    outlier = false;
end
if (nargin < 5)
    alpha = 20;
end
if (nargin < 4)
    affine = false;
end
if (nargin < 3)
    r = 0;
end

n = max(s);
Xp = DataProjection(X,r);

if (~outlier)
    CMat = admmLasso_mat_func(Xp,affine,alpha);
    C = CMat;
else
    CMat = admmOutlier_mat_func(Xp,affine,alpha);
    N = size(Xp,2);
    C = CMat(1:N,:);
end

CKSym = BuildAdjacency(thrC(C,rho));
grps = SpectralClustering(CKSym,n);
%grps2 = bestMap(s,grps);
%missrate = sum(s(:) ~= grps2(:)) / length(s);
missrate = 0;