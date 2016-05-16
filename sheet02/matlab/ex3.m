
show_q1 = false;
show_q2 = false;
show_q3 = false;
show_q4 = true;

%
% Question 1: Hessian Detector
%

if show_q1
    I1 = imread('gantrycrane.png');
    I1_grayscale = double(rgb2gray(I1));
    
    figure(1);
    clf;
    
    hessian_sigma = 2.0;
    hessian_threshold = 30;
    
    for idx = 1:3
        subplot(2, 3, idx);
        cur_hessian_sigma = hessian_sigma^idx;
        
        [px1, py1, H] = hessian(I1_grayscale, cur_hessian_sigma, hessian_threshold);
        
        size(px1,1)
        
        imagesc(H);
        colormap gray;
        
        title(['hessian, sigma: ' num2str(cur_hessian_sigma)]);
        
        subplot(2, 3, 3+idx);
        imagesc(I1);
        hold on;
        plot(px1, py1, 'xy');
    end
    
end

%
% Question 2: Harris Detector
%

if show_q2
    
    I1 = imread('gantrycrane.png');
    I1_grayscale = double(rgb2gray(I1));
    
    figure(2);
    clf;
    
    harris_sigma = 2.0;
    harris_threshold = 1;
    
    for idx = 1:3
        subplot(2, 3, idx);
        
        cur_harris_sigma = harris_sigma^idx;
        [px1, py1, M] = harris(I1_grayscale, cur_harris_sigma, harris_threshold);
        
        imagesc(M);
        colormap gray;
        
        title(['harris, sigma: ' num2str(cur_harris_sigma)]);
        
        subplot(2, 3, 3+idx);
        figure(16)
        imagesc(I1);
        hold on;
        plot(px1, py1, 'xy');
    end
    
end


%
% Question 3 (region descriptors and matching)
%

if show_q3
    
    match_params.point_sigma = 2.0;
    match_params.point_threshold = 1e5;
    match_params.feature_window_size = 41;
    match_params.num_bins = 16;
    
    num_display_matches = 15;
    
    % harris points / rg_hist
    figure(4);
    set(gcf, 'Name', 'harris points, rg_hist');
    show_point_matches(@harris, 'rg', 'graff5_img1.ppm', 'graff5_img2.ppm', match_params, num_display_matches);
    
    % harris points / dxdy_hist
    figure(5);
    set(gcf, 'Name', 'harris points, dxdy_hist');
    show_point_matches(@harris, 'dxdy', 'graff5_img1.ppm', 'graff5_img2.ppm', match_params, num_display_matches);
    
    match_params.point_threshold = 1e2;
    
    % NewYork, hessian, dxdy_hist
    figure(6);
    set(gcf, 'Name', 'hessian points, dxdy_hist');
    show_point_matches(@hessian, 'dxdy', 'NewYork_im1.pgm', 'NewYork_im5.pgm', match_params, num_display_matches);
    
    % NewYork, hessian, dxdy_hist
    figure(7);
    set(gcf, 'Name', 'hessian points, maglap_hist');
    show_point_matches(@hessian, 'maglap', 'NewYork_im1.pgm', 'NewYork_im5.pgm', match_params, num_display_matches);
    
    
    
end

%
% Question 4
% Panorama Stitching
%

if show_q4
    
    img1 = double(imread('left.jpg'));
    img2 = double(imread('right.jpg'));
    [x1,y1,x2,y2] = get_corresponding_points(img1, img2);
    
    % Homography Estimation with RANSAC
    H = get_ransac_hom(x1,y1,x2,y2,img1,img2);
    
    % Panoramic image stitching
    imgRes = pan_sample(img1,img2,H,300,150);
    
    % display result image
    figure(11);
    clf;
    imshow(imgRes);
end