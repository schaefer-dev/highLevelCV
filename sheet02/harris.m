% px - vector of x coordinates of interest points
% py - vector oy y coordinates of interest points
% M - value of the cornerness function computed for every image pixel
%


function [px py M] = harris(img, sigma, thresh)

alpha = 0.05;
sig2 = 1.5 * sigma;
G = gauss(sig2);

[imgDx,imgDy]=gaussderiv(img,sigma);

GDxx = sigma^2 .* gaussianfilter(imgDx .^ 2,sig2);
GDyy = sigma^2 .* gaussianfilter(imgDy .^ 2,sig2);
GDxy = sigma^2 .* gaussianfilter(imgDx .* imgDy,sig2);

Cdet = (GDxx .* GDyy - GDxy .^ 2);
Ctrace = (GDxx + GDyy);

M = Cdet - alpha .* Ctrace .^ 2;
imgMax = nonmaxsup2d(M);
[py,px] = find(imgMax > thresh);
end
