function outimage=gaussianfilter(img,sigma)
 [G,x] = gauss(sigma);
 outimage= conv2(img,G,'same');
end