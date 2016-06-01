function [cluster_centers,feature_patches,assignments] = create_codebook(sDir, num_clusters)
  
  PARAMS = get_ism_params();
  PATCHSIZE_PARAM = 30;

  vImgNames = dir(fullfile(sDir, '*.png'));
  sift_desc_sum = zeros(128,0);
  
  feature_patches = {};
  

  %...
  for i=1:size(vImgNames,1)
    img = (imread(strcat(sDir,'/',vImgNames(i).name)));
    img_gray = double((rgb2gray(img)));
    [px, py, H] = hessian(img_gray,PARAMS.hessian_sigma,PARAMS.hessian_thresh);
    %TODO hier Erzeugung des patches fuer die Interest points des Bildes
    %thisPatch = ....
    %feature_patches{i} = thisPatch;
    
    sift_frames = [px'; py'; PARAMS.feature_scale*ones(1, size(px,1)); ...
        PARAMS.feature_ori*ones(1, size(px,1))];
    [sift_frames, sift_desc] = vl_sift(im2single(img_gray), 'Frames', sift_frames);
    sift_desc_sum = [sift_desc_sum, sift_desc];
  end
  % assignments map every sift_desc to the corresponding index of the
  % matched cluster
  [cluster_centers, assignments] = vl_kmeans(double(sift_desc_sum), num_clusters);
  %...
  
end

 
 



