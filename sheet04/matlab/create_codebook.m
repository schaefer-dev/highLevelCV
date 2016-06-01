function cluster_centers = create_codebook(sDir, num_clusters)
  
  PARAMS = get_ism_params();

  vImgNames = dir(fullfile(sDir, '*.png'));
  sift_desc_sum = zeros(128,1);
  
  %...
  for i=1:size(vImgNames,1)
    img = (imread(strcat(sDir,'/',vImgNames(i).name)));
    img_gray = double((rgb2gray(img)));
    [px, py, H] = hessian(img_gray,PARAMS.hessian_sigma,PARAMS.hessian_thresh);
    sift_frames = [px'; py'; PARAMS.feature_scale*ones(1, size(px,1)); ...
        PARAMS.feature_ori*ones(1, size(px,1))];
    [sift_frames, sift_desc] = vl_sift(im2single(img_gray), 'Frames', sift_frames);
    sift_desc_sum = [sift_desc_sum, sift_desc];
  end
  size(sift_desc_sum)
  [cluster_centers, assignments] = vl_kmeans(double(sift_desc_sum), num_clusters);
  %...
  
end

 
 



