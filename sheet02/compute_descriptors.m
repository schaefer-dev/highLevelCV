%
% compute image descriptors corresponding to the list of interest points 
% 
% D - matrix with number of rows equal to number of interest points, each row should be equal to the corresponding descriptor vector
% px, py - vectors of x/y coordinates of interest points
% desc_size - size of the region around interest point which is used to compute the descriptor
% desc_func - handle of the corresponding descriptor function (i.e. @rg_hist)
% num_bins - number of bins parameter of the descriptor function 
%

function D = compute_descriptors(desc_func, img, px, py, desc_size, num_bins)
  
  desc_radius = round((desc_size-1)/2);
  
  for i=1:size(px,1)
      x1 = max(1,px(i)-desc_radius);
      x2 = min(size(img,1),px(i)+desc_radius);
      y1 = max(1,py(i)-desc_radius);
      y2 = min(size(img,2),py(i)+desc_radius);
      
      D(i,:) = desc_func(img([x1:x2],[y1:y2],:),num_bins)';
    
  end
end
  

  % ... 
  
