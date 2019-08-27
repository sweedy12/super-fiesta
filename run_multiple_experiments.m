function [] = run_multiple_experiments(add_noise,tol)
%this function runs multiple experiments, where each experiment consists of
%sampling points using different parameters, and running both k-means and
%SSC algorithm to recover the clustering and original subspaces. 

%creating log-spaces and ranges for parameters:
if (add_noise == 0)
    N = uint16(logspace(1,3,10));
    xlabel = "Number of samples";
    ylabel = "theta";
    %titles variables:
    km_angle_title = "Heatmap for k-means, C_{subspace} performance, p=";
    km_cluster_title = "Heatmap for k-means, C_{cluster} performance, p=";
    ssc_angle_title = "Heatmap for SSC, C_{subspace} performance, p=";
    ssc_cluster_title = "Heatmap for SSC, C_{cluster} performance, p=";
else
    N = 1000;
    sigma = logspace(-2,1,10);
    xlabel = "Noise level (sigma)";
    ylabel = "theta";
    %titles variables:
    km_angle_title = "Heatmap for noisy case, k-means, C_{subspace} performance, p=";
    km_cluster_title = "Heatmap for noisy case, k-means, C_{cluster} performance, p=";
    ssc_angle_title = "Heatmap for noisy case, SSC, C_{subspace} performance, p=";
    ssc_cluster_title = "Heatmap for noisy case, SSC, C_{cluster} performance, p=";
end
P = [5,25,125];
K = 3;
theta = exp(linspace(log(0.001),log(pi/2),10));





%running for the noiseless case:
if (add_noise == 0) 
    exp_size = 100;
    for t=1:3 %p itertaion
        p = P(t);
        %creating arrays to hold the performance measures, and the variables they correspond to:
        km_ang_mes = zeros(1,exp_size);
        km_clust_mes = zeros(1,exp_size);
        ssc_ang_mes = zeros(1,exp_size);
        ssc_clust_mes = zeros(1,exp_size);
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
                disp("P is");
                disp(p);
                d= p/5;
                [ang_per_km, clust_per_km,ang_per_ssc,clust_per_ssc,alpha] = run_experiment(cur_n,p,d,K,cur_theta,0,tol,0.5);
                %updating all the holding arrays:
                km_ang_mes(exp_ind) = ang_per_km;
                km_clust_mes(exp_ind) = clust_per_km;
                ssc_ang_mes(exp_ind) = ang_per_ssc;
                ssc_clust_mes(exp_ind) = clust_per_ssc;
                theta_arr(exp_ind) = cur_theta;
                n_arr(exp_ind) = cur_n;
                exp_ind = exp_ind + 1;
            end
        end
        %plotting the heatmap for the current p value:
        ta = table(n_arr',theta_arr',km_ang_mes', km_clust_mes');
        pstr = int2str(p);
        cur_t = strcat(km_angle_title,pstr);
        hmname = strcat("kmeans_hm_angle_p=", pstr);
        save_heatmap(ta,hmname,"Var1","Var2","Var3",cur_t,xlabel,ylabel);
        cur_t = strcat(km_cluster_title,pstr);
        hmname = strcat("kmeans_hm_cluster_p=", pstr);
        save_heatmap(ta,hmname,"Var1","Var2","Var4",cur_t,xlabel,ylabel);
        %now, plotting the heatmaps for the SSC algorithm:
        ta = table(n_arr',theta_arr',ssc_ang_mes',ssc_clust_mes');
        cur_t = strcat(ssc_angle_title,pstr);
        hmname = strcat("ssc_hm_angle_p=", pstr);
        save_heatmap(ta,hmname,"Var1","Var2","Var3",cur_t,xlabel,ylabel);
        cur_t = strcat(ssc_cluster_title,pstr);
        hmname = strcat("ssc_hm_cluster_p=", pstr);
        save_heatmap(ta,hmname,"Var1","Var2","Var4",cur_t,xlabel,ylabel);        

        
        
    end
end

%running for the noisy case:
if (add_noise == 1)
    exp_size = 100;
    for t=1:3 %P iteration
        p = P(t);
        %creating arrays to hold the performance measures, and the variables they correspond to:
        km_ang_mes = zeros(1,exp_size);
        km_clust_mes = zeros(1,exp_size);
        ssc_ang_mes = zeros(1,exp_size);
        ssc_clust_mes = zeros(1,exp_size);
        theta_arr = zeros(1,exp_size);
        sigma_arr = zeros(1,exp_size);
        exp_ind = 1;
        for j=1:10 %angle iteration
            cur_theta = theta(j);
            for i=1:10 %sigma iteration
                cur_sig = sigma(i);
                disp("sigma is");
                disp(cur_sig);
                disp("theta is");
                disp(cur_theta);
                disp("P is");
                disp(p);
                d= p/5;
                [ang_per_km, clust_per_km,ang_per_ssc,clust_per_ssc,alpha] = run_experiment(N,p,d,K,cur_theta,cur_sig,tol,0.5);
                %updating all the holding arrays:
                km_ang_mes(exp_ind) = ang_per_km;
                km_clust_mes(exp_ind) = clust_per_km;
                ssc_ang_mes(exp_ind) = ang_per_ssc;
                ssc_clust_mes(exp_ind) = clust_per_ssc;
                theta_arr(exp_ind) = cur_theta;
                sigma_arr(exp_ind) = cur_sig;
                exp_ind = exp_ind + 1;
            end
        end
        %plotting the heatmap for the current p value:
        ta = table(sigma_arr',theta_arr',km_ang_mes', km_clust_mes');
        pstr = int2str(p);
        cur_t = strcat(km_angle_title,pstr);
        hmname = strcat("kmeans_hm_angle_p=", pstr);
        save_heatmap(ta,hmname,"Var1","Var2","Var3",cur_t,xlabel,ylabel);
        cur_t = strcat(km_cluster_title,pstr);
        hmname = strcat("kmeans_hm_cluster_p=", pstr);
        save_heatmap(ta,hmname,"Var1","Var2","Var4",cur_t,xlabel,ylabel);
        %now, plotting the heatmaps for the SSC algorithm:
        ta = table(sigma_arr',theta_arr',ssc_ang_mes',ssc_clust_mes');
        cur_t = strcat(ssc_angle_title,pstr);
        hmname = strcat("ssc_hm_angle_p=", pstr);
        save_heatmap(ta,hmname,"Var1","Var2","Var3",cur_t,xlabel,ylabel);
        cur_t = strcat(ssc_cluster_title,pstr);
        hmname = strcat("ssc_hm_cluster_p=", pstr);
        save_heatmap(ta,hmname,"Var1","Var2","Var4",cur_t,xlabel,ylabel); 

    end
end
end