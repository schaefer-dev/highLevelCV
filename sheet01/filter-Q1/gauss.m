%
% compute the Gauss 1D kernel with width [-3sigma, 3sigma]
%


function [G, x] = gauss(sigma) 

    % width and height of the filter
    dim = 6*sigma+1;

    % Distance of pixel to filteredge
    dim2= 3 * sigma;

    % Result
    G = zeros(dim,1);
    
    % local coordinates with respect to the center of gauss kernel
    x = zeros(dim,1);
    
    for i=1:dim
       for j=1:dim
        x(i) = i-dim2-1;
        G(i) = 1.0 / (sqrt(2 * pi) * sigma) * exp(-(x(i)^2) / (2 * sigma^2));
       end 
    end
end
