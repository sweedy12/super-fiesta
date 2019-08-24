function [] = run_multiple_experiments(add_noise,tol)
%this function runs multiple experiments, where each experiment consists of
%sampling points using different parameters, and running both k-means and
%SSC algorithm to recover the clustering and original subspaces. 

%creating log-spaces and ranges for parameters:
if (add_noise == 0)
    N = uint16(logspace(1,3,10));
end
P = [5,25,125];
K = 3;
alpha = 0.5;
theta = exp(linspace(log(0.001),log(pi/2),10));


%running for the noiseless case:
if (add_noise == 0) 
    exp_size = 100;
    for t=1:3 %p itertaion
        p = P(t);
        %creating arrays to hold the performance measures, and the variables they correspond to:
        km_ang_mes = zeros(1,exp_size);
        km_clust_mes = zeros(1,exp_size);
        theta_arr = zeros(1,exp_size);
        n_arr = zeros(1,exp_size);
        exp_ind = 1;
        for j=1:10 %angle iteration
            cur_theta = theta(j);
            for i=1:10 %sample size iteration
                cur_n = N(i);
                disp("n is");
                disp(cur_n);
                disp("theta is");
                disp(cur_theta);
                d= p/5;
                [ang_per_km, clust_per_km,alpha] = run_experiment(cur_n,p,d,K,cur_theta,0,tol,alpha);
                %updating all the holding arrays:
                km_ang_mes(exp_ind) = ang_per_km;
                km_clust_mes(exp_ind) = clust_per_km;
                theta_arr(exp_ind) = cur_theta;
                n_arr(exp_ind) = cur_n;
                exp_ind = exp_ind + 1;
            end
        end
        %plotting the heatmap for the current p value:
        ta = table(n_arr',theta_arr',km_ang_mes', km_clust_mes');
        h1 = heatmap(ta, 'Var1','Var2','ColorVariable', 'Var4');
        hmpl = plot(h1);
        
        
    end
end


end