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
  
  %{
  G = gauss(sigma);
  Dx = gaussdx(sigma);
  Dxx = gaussdxx(sigma);
  
  imgDxx = conv2(img, Dxx, 'same');
  imgDxx = conv2(imgDxx, G', 'same');
  imgDxx = conv2(imgDxx, G', 'same');

  imgDxy = conv2(img, Dx, 'same');
  imgDxy = conv2(imgDxy, Dx', 'same');
  imgDxy = conv2(imgDxy, G, 'same');
  imgDxy = conv2(imgDxy, G', 'same');

  imgDyy = conv2(img, G, 'same');
  imgDyy = conv2(imgDyy, Dxx', 'same');
  imgDyy = conv2(imgDyy, G, 'same');
  imgDyy = conv2(imgDyy, G', 'same');
  %}
  % ... 
end

