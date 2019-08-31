function [new_n] = search_transformation(n, n_new_start, p1, p2, d1, d2, K, tol, max_search)
    theta_size = 10; 
    [km_ang_target, km_clust_target, ssc_ang_target, ssc_clust_target] = compute_column(n, p1, d1, K, tol, theta_size);
    
    %calculating threshold by computing the mean distance for similar
    %parameters.
    thresh = 0;
    for i=1:5
        [km_ang_approx, km_clust_approx, ssc_ang_approx, ssc_clust_approx] = compute_column(n, p1, d1, K, tol, theta_size);
        thresh = thresh + norm(ssc_ang_target - ssc_ang_approx);
    end
    thresh = thresh/5;
    disp(thresh)
    accumulation=0;            
    new_n = n_new_start;

    for i=1:5
        [km_ang_approx, km_clust_approx, ssc_ang_approx, ssc_clust_approx] = compute_column(new_n, p2, d2, K, tol, theta_size);
        accumulation = accumulation + norm(ssc_ang_target - ssc_ang_approx);
    end
        accumulation=accumulation/5;    
    while accumulation > 2*thresh && new_n/n_new_start < max_search %norm(km_ang_target-km_ang_approx) + norm(km_clust_target-km_clust_approx) + norm(ssc_clust_target-ssc_clust_approx) > 1
        accumulation=0;
        disp(norm(ssc_ang_target-ssc_ang_approx))
        new_n = new_n + n_new_start;
        disp(new_n)
        for i=1:5
        [km_ang_approx, km_clust_approx, ssc_ang_approx, ssc_clust_approx] = compute_column(new_n, p2, d2, K, tol, theta_size);
        accumulation = accumulation + norm(ssc_ang_target - ssc_ang_approx);
        end
        accumulation=accumulation/5;
    end
end