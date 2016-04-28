function [imgDx,imgDy]=gaussderiv(img,sigma)
    G=gauss(sigma);
    D=gaussdx(sigma);
end

% ...
