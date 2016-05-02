% 
% compute chi2 distance between x and y
% 

function d = dist_chi2(x,y)
    % dimensions for histograms x and y
    dim_x = length(size(x));
    dim_y = length(size(y));
    
    assert(dim_x == dim_y, 'Dimensions of histograms x and y should match');
    
    % the number of bins for each dimension
    bins_x = size(x);
    bins_y = size(y);
    
    for i=1:dim_x
        assert(bins_x(i) == bins_y(i), 'Number of used bins for the histograms should be equal');
    end
    
    
    error = 0.0;
    
    % hardcoded for array dimensions 1,2,3 
    % TODO: This is not very nice and does not work for histograms with
    % dimension 4 or bigger

    if (dim_x == 1) 
       for i=1:bins_x(1)
            error = error + (x(i) - y(i))^2 / (x(i) + y(i));
       end 
    elseif (dim_x == 2)
       for i=1:bins_x(1)
          for j=1:bins_x(2)
              error = error + (x(i,j) - y(i,j))^2 / (x(i,j) + y(i,j));
          end
       end
    elseif (dim_x == 3)
       for i=1:bins_x(1)
          for j=1:bins_x(2)
              for k=1:bins_x(2)
                 error = error + (x(i,j,k) - y(i,j,k))^2 / (x(i,j,k) + y(i,j,k));
              end
          end
       end  
    end
    
    d = error;
end
