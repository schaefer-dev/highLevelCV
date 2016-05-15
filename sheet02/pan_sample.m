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
  black_height = size(img1, 1);
  black_width = size(img2, 2) + round(H(1,3));
  black = zeros(black_height, black_width);
  img = [img1, black];
  %{
  figure(42);
  clf;
  imagesc(img);
  colormap gray;
  %}
    
  % loop over all newly appended pixels plus some overlap    
    % ...
    overlap = 150;
    start = size(img1, 2) + 1 - overlap;
    ende = size(img, 2);
    for x = [start:ende]
        for y = [1:size(img,1)]
            if x == size(img,2) && y == 50
                test = 1
            end
            % transform the current pixel coordinates to a point in the right image    
            % ...
            c = H * [x y 1]';
            cx = c(1) / c(3);
            cy = c(2) / c(3);

            %cx = min(max(cx,1), size(img2,1))
            %cy = min(max(cy,1), size(img2,1))

            % look up gray-values of the four pixels nearest to the transformed
            % coordinates    
            % ...

            % bilinearly interpolate the gray-value at transformed coordinates and 
            % assign them to the source pixel in the left image. 
            % (Tip: use interpolate_2d.m for bilinear interpolation).
            % ...

            g = interpolate_2d(img2, cy, cx);
            
            
            %% Intensity Adjustment (Question 4c)
    
            % linear weighting according to distance in horizontal direction
            % ...
            p = 1;
            if x <= size(img1,2)
                p = (x - start) / overlap;
            end
            
            img(y,x) = round(p * round(g) + (1 - p) * img(y,x));
            
        end
    end
    
    test = 1;
    
    figure(43);
    clf;
    imagesc(img);
    colormap gray;
            
end