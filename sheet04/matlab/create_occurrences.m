function cluster_occurrences = create_occurrences(sDir, cluster_centers)
  
  PARAMS = get_ism_params();
  
  vImgNames = dir(fullfile(sDir,'*.png'));
  
  cluster_occurrences = [];
  
  % ...
   for i=1:size(vImgNames,1)
    img = (imread(strcat(sDir,'/',vImgNames(i).name)));
    img_gray = double((rgb2gray(img)));
    [px, py, H] = hessian(img_gray,PARAMS.hessian_sigma,PARAMS.hessian_thresh);
    sift_frames = [px'; py'; PARAMS.feature_scale*ones(1, size(px,1)); ...
        PARAMS.feature_ori*ones(1, size(px,1))];
    [sift_frames, sift_desc] = vl_sift(im2single(img_gray), 'Frames', sift_frames);
    [cluster_center, assignments] = vl_kmeans(double(sift_desc), 1);
    for j=1:size(cluster_centers,2)
        euc_dist= sqrt(sum((cluster_centers(:,j)-cluster_center) .^ 2));
        if euc_dist < PARAMS.match_tresh
            cluster_occurrences= [cluster_occurrences;[j,euc_dist]];
        end
    end
  end

  % ...