    match_params.point_sigma = 2.0;
    match_params.point_threshold = 1e5;
    match_params.feature_window_size = 41;
    match_params.num_bins = 16;
    
    num_display_matches = 15;
    
    % ---------------------- Grafiti ------------------------------
    
    % harris points / rg_hist
    figure(1);
    set(gcf, 'Name', 'harris points, rg_hist');
    show_point_matches(@harris, 'rg', 'graff5_img1.ppm', 'graff5_img2.ppm', match_params, num_display_matches);
    
    % harris points / dxdy_hist
    figure(2);
    set(gcf, 'Name', 'harris points, dxdy_hist');
    show_point_matches(@harris, 'dxdy', 'graff5_img1.ppm', 'graff5_img2.ppm', match_params, num_display_matches);
    
    
    % threshold for hessian
    match_params.point_threshold = 1e2;
    
    
    % hessian points / rg_hist
    figure(3);
    set(gcf, 'Name', 'hessian points, rg_hist');
    show_point_matches(@hessian, 'rg', 'graff5_img1.ppm', 'graff5_img2.ppm', match_params, num_display_matches);
    
    % hessian points / dxdy_hist
    figure(4);
    set(gcf, 'Name', 'hessian points, dxdy_hist');
    show_point_matches(@hessian, 'dxdy', 'graff5_img1.ppm', 'graff5_img2.ppm', match_params, num_display_matches);
    
    % ---------------------- NEW YORK ------------------------------

    % threshold for hessian
    match_params.point_threshold = 1e2;
     
    % NewYork, hessian, dxdy_hist
    figure(7);
    set(gcf, 'Name', 'hessian points, dxdy_hist');
    show_point_matches(@hessian, 'dxdy', 'NewYork_im1.pgm', 'NewYork_im5.pgm', match_params, num_display_matches);
    
    % NewYork, hessian, maglap
    figure(8);
    set(gcf, 'Name', 'hessian points, maglap_hist');
    show_point_matches(@hessian, 'maglap', 'NewYork_im1.pgm', 'NewYork_im5.pgm', match_params, num_display_matches);