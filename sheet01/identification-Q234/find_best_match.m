%
% model_images - list of file names of model images
% query_images - list of file names of query images
%
% dist_type - string which specifies distance type:  'chi2', 'l2', 'intersect'
% hist_type - string which specifies histogram type:  'grayvalue', 'dxdy', 'rgb', 'rg'
%
% note: use functions 'get_dist_by_name.m', 'get_hist_by_name.m' and 'is_grayvalue_hist.m' to obtain 
%       handles to distance and histogram functions, and to find out whether histogram function 
%       expects grayvalue or color image
%

function [best_match, D] = find_best_match(model_images, query_images, dist_type, hist_type, num_bins)

  dist_func = get_dist_by_name(dist_type);
  hist_func = get_hist_by_name(hist_type);
  hist_isgray = is_grayvalue_hist(hist_type);
  
  
  lm = length(model_images);
  lq = length(query_images);
  
  D = zeros(lm, lq);

  % compute distance matrix
  for i=1:lq
     img1 = double(imread(char(query_images(i))));
     
     % if hist is expecting a gray picture we convert it
     if (hist_isgray == 1)
        if (size(img1,3) == 3)
            img1 = double(rgb2gray(img1));
        end
     end 
     h1 = hist_func(img1, num_bins);
     for j=1:lm
        img2 = double(imread(char(model_images(j))));
        if (hist_isgray == 1) 
            if (size(img2,3) == 3)
                img2 = double(rgb2gray(img2));
            end
        end
        h2 = hist_func(img2, num_bins);
        D(j,i) = dist_func(h1,h2);
     end
  end
  
  
  % find the best match for each query image
  best_match = zeros(1,lq);
  [M,best_match] = min(D);
end
  

function image_hist = compute_histograms(image_list, hist_func, hist_isgray, num_bins)
  
  assert(iscell(image_list));
  image_hist = [];

  % compute hisgoram for each image and add it at the bottom of image_hist
  % ...
end
