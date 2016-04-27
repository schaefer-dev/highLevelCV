% Faster version of gauss, because we use the fact that 2D Gaussian filter is seperable
function [G] = gauss1b(sigma) % we deleted output x because it didn't make sense in our opinion, and it's also not meantioned on the sheet

    % width and height of the filter
    dim = 6*sigma+1;

    % Distance of pixel to filteredge
    dim2= 3 * sigma;

    % local coordinates with respect to the center of gauss kernel
    x = zeros(dim,1);

    % Result
    G = zeros(dim,1);
    
    for i=1:dim
        x(i) = i-dim2-1;
        G(i) = 1.0 / (sqrt(2 * pi) * sigma) * exp(-(x(i)*x(i)) / (2 * sigma * sigma));
    end
    
end
