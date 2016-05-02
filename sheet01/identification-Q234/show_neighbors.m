%
% for each image file from 'query_images' find and visualize the 5 nearest images from 'model_image'.
%
% note: use the previously implemented function 'find_best_match.m'
% note: use subplot command to show all the images in the same Matlab figure, one row per query image
%

function show_neighbors(model_images, query_images, dist_type, hist_type, num_bins)
  
  figure(4);
  clf;

  num_nearest = 5;
  number_of_images = size(query_images,1);
   
  
  
  
  for i=1:size(query_images,1)
        subplot(number_of_images,num_nearest+1,i*6-5);
        image(imread(char(query_images(i))));
  end
  
  for i=1:num_nearest
    [best_match,D] = find_best_match(model_images, query_images, dist_type, hist_type, num_bins);
    [A,I] = min(D);
    for j=1:size(I)
        subplot(number_of_images,num_nearest+1,j*(i+1));
        image(imread(char(model_images(i,1))));
    end
  end
    
  % ...
