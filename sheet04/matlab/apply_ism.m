function [detections, acc] = apply_ism(imgname, cluster_centers, cluster_occurrences)

 
  PARAMS = get_ism_params();

  % load the image
  img = single(rgb2gray(imread(imgname)));

  % ...
    % Extract SIFT features
    img_height = size(img,1);
    img_width = size(img,2);
    img_center = [floor(img_width/2), floor(img_height/2)];
    [px, py, H] = hessian(img,PARAMS.hessian_sigma,PARAMS.hessian_thresh);
    sift_frames = [px'; py'; PARAMS.feature_scale*ones(1, size(px,1)); ...
        PARAMS.feature_ori*ones(1, size(px,1))];
    [sift_frames, sift_desc] = vl_sift(im2single(img), 'Frames', sift_frames);
    
    % Find matching codebook entries
    matches = zeros(size(cluster_centers, 2), 1);
    for c = 1:size(cluster_centers,2)
        cluster = cluster_centers(:,c);
        for f = 1:size(sift_desc,2)
            feature = sift_desc(:,f);
            euc_dist= sqrt(sum((cluster - double(feature)) .^ 2));
            if euc_dist < PARAMS.match_tresh
                matches(c) = 1;
            end
        end
    end
    % For some reason no distance is smaller then the threshold and matches
    % remains all zeros
    
    
    % Cast Votes
    votes = zeros(ceil(img_height/10), ceil(img_width/10));
    num_Cact = sum(matches);    
    for c = 1:size(cluster_centers,2)
        temp = cluster_occurrences(:,1) == c;
        num_occ = sum(temp);
        occ = cluster_occurrences(temp, :);
        
        w = (1/num_occ) * (1/num_Cact);
        %{
           for o = 1:num_occ
            xvote = img_center(1) - cluster_occurrences(o,2);
            yvote = img_center(2) - cluster_occurrences(o,3);
            
            xvote = round(xvote/10);
            yvote = round(yvote/10);
            
            votes(yvote,xvote) = votes(yvote,xvote) + w;
        end  
        %}
            xvote = img_center(1) - cluster_occurrences(temp,2);
            yvote = img_center(2) - cluster_occurrences(temp,3);
            
            xvote = round(xvote/10);
            yvote = round(yvote/10);
        for v = 1:length(xvote)
            votes(yvote(v),xvote(v)) = votes(yvote(v),xvote(v)) + w;
        %}
    end
    
    % Find maxima
    acc = nonmaxsup2d(votes);
    [py, px] = find(acc > 0);
    
    detections = []
    for i = 1:size(py)
        detections = [detections; px(i) py(i) acc(py(i), px(i))];
    end
    
    % Sort detections by score
    [D,I] = sort(detections(:,3), 'descend');
    detections = detections(I,:);

    
    %...
    
end