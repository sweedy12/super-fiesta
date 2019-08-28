function [] = run_k_experiments (tol)
%this function runs additional experiments of the subspace clustering
%problem, testing different parameter (d)
N = 1000;
sigma = logspace(-2,1,10);
theta = exp(linspace(log(0.001),log(pi/2),10));
P = 50;
K = 1:10;
D = 10;
%noiseless case
xlabel = "K value";
ylabel = "theta value";
exp_size = 100;
km_ang_mes = zeros(1,exp_size);
km_clust_mes = zeros(1,exp_size);
ssc_ang_mes = zeros(1,exp_size);
ssc_clust_mes = zeros(1,exp_size);
theta_arr = zeros(1,exp_size);
k_arr = zeros(1,exp_size);
exp_ind = 1;
for t=1:10 %theta iteration
    cur_theta = theta(t);
    for d=10 %d iteration
        cur_k = K(d);
        [ang_per_km, clust_per_km,ang_per_ssc,clust_per_ssc,alpha] = run_experiment(N,P,D,cur_k,cur_theta,0,tol,0.5);
        %updating all the holding arrays:
        km_ang_mes(exp_ind) = ang_per_km;
        km_clust_mes(exp_ind) = clust_per_km;
        ssc_ang_mes(exp_ind) = ang_per_ssc;
        ssc_clust_mes(exp_ind) = clust_per_ssc;
        theta_arr(exp_ind) = cur_theta;
        k_arr(exp_ind) = cur_k;
        exp_ind = exp_ind + 1;
    end
end
%plotting the heatmap for the current p value:
ta = table(k_arr',theta_arr',km_ang_mes', km_clust_mes');
cur_t = "Heatmap for k-means, c_subspace";
hmname = "kmeans_hm_angle_k_theta=";
save_heatmap(ta,hmname,"Var1","Var2","Var3",cur_t,xlabel,ylabel);
cur_t ="Heatmap for k-means, c_cluster";
hmname = "kmeans_hm_cluster_k_theta=";
save_heatmap(ta,hmname,"Var1","Var2","Var4",cur_t,xlabel,ylabel);
%now, plotting the heatmaps for the SSC algorithm:
ta = table(k_arr',theta_arr',ssc_ang_mes',ssc_clust_mes');
cur_t = "Heatmap for ssc, c_subspace";
hmname = "ssc_hm_angle_k_theta=";
save_heatmap(ta,hmname,"Var1","Var2","Var3",cur_t,xlabel,ylabel);
cur_t = "Heatmap for ssc, c_cluster";
hmname = "ssc_hm_cluster_k_theta=";
save_heatmap(ta,hmname,"Var1","Var2","Var4",cur_t,xlabel,ylabel);

%testing noisy case:
Theta = pi\4;
xlabel = "noise level (sigma)";
ylabel = "k value";
km_ang_mes = zeros(1,exp_size);
km_clust_mes = zeros(1,exp_size);
ssc_ang_mes = zeros(1,exp_size);
ssc_clust_mes = zeros(1,exp_size);
sigma_arr = zeros(1,exp_size);
k_arr = zeros(1,exp_size);
exp_ind = 1;
for t=1:10 %sigma iteration
    cur_sigma = sigma(t);
    for d=1:10 %d iteration
        cur_k = K(d);
        [ang_per_km, clust_per_km,ang_per_ssc,clust_per_ssc,alpha] = run_experiment(N,P,D,cur_k,Theta,cur_sigma,tol,0.5);
        %updating all the holding arrays:
        km_ang_mes(exp_ind) = ang_per_km;
        km_clust_mes(exp_ind) = clust_per_km;
        ssc_ang_mes(exp_ind) = ang_per_ssc;
        ssc_clust_mes(exp_ind) = clust_per_ssc;
        sigma_arr(exp_ind) = cur_sigma;
        k_arr(exp_ind) = cur_k;
        exp_ind = exp_ind + 1;
    end
end
%plotting the heatmap for the current p value:
ta = table(k_arr',sigma_arr',km_ang_mes', km_clust_mes');
cur_t = "Heatmap for noisy case, k-means, c_subspace";
hmname = "noisy_kmeans_hm_angle_k_theta=";
save_heatmap(ta,hmname,"Var1","Var2","Var3",cur_t,xlabel,ylabel);
cur_t ="Heatmap for noisy case, k-means, c_cluster";
hmname = "noisy_kmeans_hm_cluster_k_theta=";
save_heatmap(ta,hmname,"Var1","Var2","Var4",cur_t,xlabel,ylabel);
%now, plotting the heatmaps for the SSC algorithm:
ta = table(k_arr',theta_arr',ssc_ang_mes',ssc_clust_mes');
cur_t = "Heatmap for noisy case, ssc, c_subspace";
hmname = "noisy_ssc_hm_angle_k_theta=";
save_heatmap(ta,hmname,"Var1","Var2","Var3",cur_t,xlabel,ylabel);
cur_t = "Heatmap for noisy case, ssc, c_cluster";
hmname = "noisy_ssc_hm_cluster_k_theta=";
save_heatmap(ta,hmname,"Var1","Var2","Var4",cur_t,xlabel,ylabel);

end