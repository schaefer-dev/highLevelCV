function [imgDx,imgDy]=gaussderiv(img,sigma)
    G=gauss(sigma);
    D=gaussdx(sigma);
    derivx= 1/3 .* [1 0 1;1 0 1;1 0 1];
    derivy= 1/3 .* [1 1 1;0 0 0;1 1 1];
    imgDx = conv2(conv2(img,D),derivx)
    imgDy= conv2(conv2(img,D),derivx); 
end

% ...
