function [detections, acc] = apply_ism(imgname, cluster_centers, cluster_occurrences)

 
  PARAMS = get_ism_params();

  % load the image
  img = single(rgb2gray(imread(imgname)));

  % ...
    %img_height = size(img,1);
    %img_width = size(img,2);
    %img_center = [floor(img_width/2), floor(img_height/2)];
    [px, py, H] = hessian(img,PARAMS.hessian_sigma,PARAMS.hessian_thresh);
    sift_frames = [px'; py'; PARAMS.feature_scale*ones(1, size(px,1)); ...
        PARAMS.feature_ori*ones(1, size(px,1))];
    [sift_frames, sift_desc] = vl_sift(im2single(img), 'Frames', sift_frames);
    
    matches = zeros(size(cluster_centers, 2), 1);
    for c = 1:size(cluster_centers,2)
        cluster = cluster_centers(:,c);
        for f = 1:size(sift_desc,2)
            feature = sift_desc(:,f);
            euc_dist= sqrt(sum((cluster - double(feature)) .^ 2));
            if euc_dist < PARAMS.match_tresh
                matches(c) = matches(c) + 1;
            end
        end
    end
    % For some reason no distance is smaller then the threshold and matches
    % remains all zeros
    
    
 