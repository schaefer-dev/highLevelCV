% 
% compute intersection distance between x and y
% return 1 - intersection, so that smaller values also correspond to more similart histograms
% 

function d = dist_intersect(x, y)

    % dimensions for histograms x and y
    dim_x = length(size(x));
    dim_y = length(size(y));
    
    assert(dim_x == dim_y, 'Dimensions of histograms x and y should match');
    assert(dim_x <= 3, 'Dimension of histograms are not allowed to be >3');
    
    % the number of bins for each dimension
    bins_x = size(x);
    bins_y = size(y);
    
    for i=1:dim_x
        assert(bins_x(i) == bins_y(i), 'Number of used bins for the histograms should be equal');
    end


    % normalization of both histograms
    sumX = 0
    if (dim_x == 1)
        for i=1:bins_x
           sumX = sumX + x(i)
       end 
       x ./ sumX
    elseif (dim_x = 2)
        for i=1:bins_x
            for j=1:bins_x
                sumX = sumX + x(i,j)
            end
        end
        x ./ sumX
    elseif (dim_x = 3)
        for i=1:bins_x
            for j=1:bins_x
                for k=1:bins_x
                    sumX = sumX + x(i,j,k)
                end
            end
        end
        x ./ sumX
    end

    d = 0.0;

    if (dim_x == 1)
        for i=1:bins_x(1)
            d = d + min(x(i),y(i));
        end
    elseif (dim_x == 2)
        for i=1:bins_x(1)
            for j=1:bins_x(2)
                d = d + min(x(i,j),y(i,j));
            end
        end
    elseif (dim_x == 3)
        for i=1:bins_x(1)
            for j=1:bins_x(2)
                for k=1:bins_x(3)
                    d = d + min(x(i,j,k),y(i,j,k));
                end
            end
        end
    end
end
