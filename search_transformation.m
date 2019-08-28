function [new_n] = search_transformation(n, n_new_start, p1, p2, d1, d2, K, tol)
    theta_size = 10; 
    [km_ang_target, km_clust_target, ssc_ang_target, ssc_clust_target] = compute_column(n, p1, d1, K, tol, theta_size);
    [km_ang_approx, km_clust_approx, ssc_ang_approx, ssc_clust_approx] = compute_column(n_new_start, p2, d2, K, tol, theta_size);
    new_n = n_new_start;
    while norm(km_ang_target-km_ang_approx) + norm(km_clust_target-km_clust_approx)... 
            + norm(ssc_ang_target-ssc_ang_approx) + norm(ssc_clust_target-ssc_clust_approx) < tol
        %todo: search
    end
end