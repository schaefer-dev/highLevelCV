%
% return 2nd order Gaussian derivatives of the image
% 
% note: use functions gauss.m and gaussdx.m from exercise 1
%

function [imgDxx, imgDxy, imgDyy] = gaussderiv2(img,sigma)
  
  assert(length(size(img)) == 2, 'expecting 2d grayscale image');
  G=gauss(sigma);
  D=gaussdx(sigma);
  D2=gaussdxx(sigma);
  
  img1 = conv2(img,D2,'same');
  imgDxx = conv2(img1,G','same');
  
  img2 = conv2(img,G,'same');
  imgDyy= conv2(img2,D2','same');
  
  img3 = conv2(img,D2,'same');
  imgDxy = conv2(img3,D2','same');
  % ... 
end

