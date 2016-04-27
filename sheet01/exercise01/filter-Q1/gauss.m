function [G,x] = gauss(sigma)
    dim = 6*sigma+1;
    dim2= 3 * sigma;
    % We have a 2D Gaussian so the indices are in 2D
    x = zeros(dim,dim,2);
    G = zeros(dim,dim);
    
    for i=1:dim
       for j=1:dim
        x(i,j,1) = i-dim2-1;
        x(i,j,2) = j-dim2-1;
        G(i,j) = 1.0 / (sqrt(2 * pi) * sigma) * exp(-(x(i,j,1)*x(i,j,1) + x(i,j,2)*x(i,j,2)) / (2 * sigma * sigma));
       end 
    end
    
    
end