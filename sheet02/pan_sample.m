%
% This function stiches two images related by a homogrphy into one image. 
% The image plane of image 1 is extended to fit the additional points of
% image 2. Intensity values are looked up in image 2, using bilinear
% interpolation (use the provided function interpolate_2d). 
% Further parts belonging to image 1 and image 2 are smoothly blended. 
% 
%
% img1 : the first gray value image
% img2 : the second gray value image 
% H    : the homography estimated between the images
% sz   : the amount of pixel to increase the left image on the right 
% st   : amount of overlap between the images
%
% img  : the final panorama image
% 
function img = pan_sample(img1,img2,H,sz,st)

%% Image Resampling (Question 4b)

  % append a sufficient number of black columns to the left image  
  % ...
    
  % loop over all newly appended pixels plus some overlap    
    % ...
    
    % transform the current pixel coordinates to a point in the right image    
    % ...
    
    % look up gray-values of the four pixels nearest to the transformed
    % coordinates    
    % ...
    
    % bilinearly interpolate the gray-value at transformed coordinates and 
    % assign them to the source pixel in the left image. 
    % (Tip: use interpolate_2d.m for bilinear interpolation).
    % ...
    
    
    %% Intensity Adjustment (Question 4c)
    
    % linear weighting according to distance in horizontal direction
    % ...
  
    
  % end loop