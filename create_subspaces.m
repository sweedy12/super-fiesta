function [B,alpha] = create_subspaces(n,p,d,theta,alpha,tol)
%n = number of subspaces to create
%p = the dimension of the linear space
%d = the dimension of the subspaces 
calibrated = 0;
alpha_high = 1;
alpha_low = 0;
while (calibrated == 0)
    %sampling n+1 different subspaces:
    subs = cell(1,n+1);
    for i=1:n+1
        subs{i}= sample_subspace(p,d);
    end
    B = cell(1,n);
    for i=1:n
        B{i} = alpha*subs{i+1}+(1-alpha)*subs{1};
    end
    %checking if the angle condition holds:
    cur_angle = average_angle(B,n);
    diff = theta-cur_angle;
     if (abs(diff)<=tol)
        calibrated = 1;
    elseif (diff<0) %angle too 
        alpha_high = alpha;
        alpha = alpha - (alpha-alpha_low) /2 ;
     else %angle too small
         alpha_low = alpha;
         alpha = alpha + (alpha_high-alpha) / 2;
         
     end
end
    
    
end 
