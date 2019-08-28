function [km_ang_mes, km_clust_mes, ssc_ang_mes, ssc_clust_mes] = compute_column(n, p, d, K, tol, theta_size)
    theta = exp(linspace(log(0.001),log(pi/2),theta_size));
    km_ang_mes = zeros(1,theta_size);
    km_clust_mes = zeros(1,theta_size);
    ssc_ang_mes = zeros(1,theta_size);
    ssc_clust_mes = zeros(1,theta_size);
    for i = 1:theta_size
        [ang_per_km, clust_per_km,ang_per_ssc,clust_per_ssc,alpha] = run_experiment(n,p,d,K,theta(i),0,tol,0.5);
        km_ang_mes(i) = ang_per_km;
        km_clust_mes(i) = clust_per_km;
        ssc_ang_mes(i) = ang_per_ssc;
        ssc_clust_mes(i) = clust_per_ssc;
        
end