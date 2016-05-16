%
% return 2nd order Gaussian derivatives of the image
% 
% note: use functions gauss.m and gaussdx.m from exercise 1
%

function [imgDxx, imgDxy, imgDyy] = gaussderiv2(img,sigma)
  
  assert(length(size(img)) == 2, 'expecting 2d grayscale image');
  
    
  [imgDx,  imgDy ] = gaussderiv(img,   sigma);
  [imgDxx, imgDxy] = gaussderiv(imgDx, sigma);
  [~,      imgDyy] = gaussderiv(imgDy, sigma);

  
end

