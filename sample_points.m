function [X,B,Z,alpha]  = sample_points(n,p,d,k,theta,sigma,tol,alpha_start)
X = zeros(n,p);
Z = zeros(1,n);
Id = eye(d); 
Ip = eye(p);
[B, alpha] = create_subspaces(k,p,d,theta,alpha_start,tol);

for i=1:n
    zi = unidrnd(k);
    Z(i) = zi;
    wi = mvnrnd(zeros(1,d),Id,1);
    %getting the subspaces:
    xi = mvnrnd(B{zi}*wi', sigma*Ip,1);
    X(i,:) = xi;
    
    
end
end