function [cluster_centers,feature_patches,assignments] = create_codebook(sDir, num_clusters)
  
  PARAMS = get_ism_params();
  PATCHSIZE_RAD_PARAM = 15;

  vImgNames = dir(fullfile(sDir, '*.png'));
  sift_desc_sum = zeros(128,0);
  
  feature_patches = {};
  

  %...
  for i=1:size(vImgNames,1)
    img = (imread(strcat(sDir,'/',vImgNames(i).name)));
    img_gray = double((rgb2gray(img)));
    img_height = size(img,1);
    img_width = size(img,2);
    [px, py, H] = hessian(img_gray,PARAMS.hessian_sigma,PARAMS.hessian_thresh);
    %TODO hier Erzeugung des patches fuer die Interest points des Bildes
    for j=1:size(px,1)
       % thisPatch = zeros(2*PATCHSIZE_RAD_PARAM + 1, 2*PATCHSIZE_RAD_PARAM + 1)
        thisPatch = img(max(1,py(j)-PATCHSIZE_RAD_PARAM):min(img_height,py(j)+PATCHSIZE_RAD_PARAM), ...
            max(1,px(j)-PATCHSIZE_RAD_PARAM):min(img_width,px(j)+PATCHSIZE_RAD_PARAM));
        feature_patches{i}{j} = thisPatch;
    end
    
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

 
 



