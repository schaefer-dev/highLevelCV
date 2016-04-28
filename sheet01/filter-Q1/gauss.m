function [G, x] = gauss(sigma) % we deleted output x because it didn't make sense in our opinion, and it's also not meantioned on the sheet

    % width and height of the filter
    dim = 6*sigma+1;

    % Distance of pixel to filteredge
    dim2= 3 * sigma;

    % local coordinates with respect to the center of gauss kernel
    x = zeros(dim,dim,2);

    % Result
    G = zeros(dim,dim);
    
    for i=1:dim
       for j=1:dim
        x(i,j,1) = i-dim2-1;
        x(i,j,2) = j-dim2-1;
        G(i,j) = 1.0 / (sqrt(2 * pi) * sigma) * exp(-(x(i,j,1)*x(i,j,1) + x(i,j,2)*x(i,j,2)) / (2 * sigma * sigma));
       end 
    end
    dim2
    x=linspace(-dim2,dim2,dim)
    
end
