function [D, x] = gaussdx(sigma)

    % width and height of the filter
    dim = 6*sigma+1;

    % Distance of pixel to filteredge
    dim2= 3 * sigma;

    % local coordinates with respect to the center of gauss kernel
    x = zeros(dim,1);
    
    % Result
    D = zeros(dim,1);
    
    for i=1:dim
       for j=1:dim
        x(i) = i-dim2-1;
        D(i) = -x(i) / (sqrt(2 * pi) * sigma^3) * exp(-x(i)^2 / (2 * sigma^2));
       end 
    end
end