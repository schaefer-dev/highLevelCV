function [D, x] = gaussdx(sigma)
    dim = 6*sigma+1;
    dim2= 3 * sigma;
    x = zeros(dim,dim,2);
    D = zeros(dim,dim);
    
    for i=1:dim
       for j=1:dim
        x(i,j,1) = i-dim2-1;
        x(i,j,2) = j-dim2-1;
        x1 = x(i,j,1);
        x2 = x(i,j,2);
        % scalar product
        scP = x1^2 + x2^2;
        % Assumption: Total derivative is used => sum of all partial
        % derivatives
        D(i,j) = -(x1 + x2) / (sqrt(2 * pi) * sigma^3) * exp(-scP / (2 * sigma^2));
       end 
    end
end