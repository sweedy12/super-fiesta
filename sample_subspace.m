function [B] = sample_subspace (n,d)
    %n = dimension of the linear space
    %d = the dimension of the subspace
    %setting the return matrix
    B = zeros(n,d);
    %sampling d unit vectors:
    u = randperm(n,d);
    for i=1:d
        B(u(i),i)= 1;
    end
    
end 