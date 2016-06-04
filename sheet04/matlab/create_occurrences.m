function cluster_occurrences = create_occurrences(sDir, cluster_centers)
  
  PARAMS = get_ism_params();
  
  vImgNames = dir(fullfile(sDir,'*.png'));
  
  cluster_occurrences = [];
  
  % ...
   for i=1:size(vImgNames,1)
    img = (imread(strcat(sDir,'/',vImgNames(i).name)));
    img_gray = double((rgb2gray(img)));
    img_height = size(img,1);
    img_width = size(img,2);
    img_center = [floor(img_width/2), floor(img_height/2)];
    [px, py, H] = hessian(img_gray,PARAMS.hessian_sigma,PARAMS.hessian_thresh);
    sift_frames = [px'; py'; PARAMS.feature_scale*ones(1, size(px,1)); ...
        PARAMS.feature_ori*ones(1, size(px,1))];
    [sift_frames, sift_desc] = vl_sift(im2single(img_gray), 'Frames', sift_frames);
    for k=1:size(sift_desc,2)
        for j=1:size(cluster_centers,2)
            euc_dist= sqrt(sum((cluster_centers(:,j)-double(sift_desc(:,k))) .^ 2));
            if euc_dist < PARAMS.match_tresh
                %cluter_occurences(x,1) contains the activated cluster
                
                %TODO: cluster_occurences(x,2) contains the euc_dist of this
                %activated cluster but it SHOULD contain the relative
                %coordinate of the activating feature relative to the
                %picture center! (to make show_occurence possible)
                cluster_occurrences= [cluster_occurrences;[j,px(k)-img_center(1),py(k)-img_center(2)]];
            end
        end
    end
  end

  % ...