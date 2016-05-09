% px - vector of x coordinates of interest points
% py - vector oy y coordinates of interest points
% H - value of Hessian determinant computed for every image pixel
%
% note: use the functions gaussderiv2.m and nonmaxsup2d.m 

function [px py, H] = hessian(img, sigma, thresh)

   % ...