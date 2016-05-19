% px - vector of x coordinates of interest points
% py - vector oy y coordinates of interest points
% M - value of the cornerness function computed for every image pixel
%


function [px py M] = harris(img, sigma, thresh)

alpha = 0.05;
sig2 = 1.5 * sigma;
G = gauss(sig2);

[Dx,Dy]=gaussderiv(img,sigma);

GDx2 = sigma^2 .* gaussianfilter(Dx .^ 2,sig2);
GDy2 = sigma^2 .* gaussianfilter(Dy .^ 2,sig2);
GDxDy = sigma^2 .* gaussianfilter(Dx .* Dy,sig2);

Cdet = (GDx2 .* GDy2 - GDxDy .^ 2);
Ctrace = (GDx2 + GDy2);

M = Cdet - alpha .* (Ctrace .^ 2);
imgMax = nonmaxsup2d(M);
[py,px] = find(imgMax > thresh);
end
