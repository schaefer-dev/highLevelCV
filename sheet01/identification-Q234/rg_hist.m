%
%  compute joint histogram for r/g values
%  note that r/g values should be in the range [0, 1];
%  histogram should be normalized so that sum of all values equals 1
%
%  img_color - input color image
%  num_bins - number of bins used to discretize each dimension, total number of bins in the histogram should be num_bins^2
%

function h = rg_hist(img_color, num_bins)
    assert(size(img_color, 3) == 3, 'image dimension mismatch');
    %assert(isfloat(img_color), 'incorrect image type');

    %define a 2D histogram  with "num_bins^2" number of entries
    h=zeros(num_bins, num_bins);
  
    %execute the loop for each pixel in the image 
    for i=1:size(img_color,1)
        for j=1:size(img_color,2)
            red = img_color(i,j,1);
            green = img_color(i,j,2);
            blue = img_color(i,j,3);
            
            sum = red + green + blue;
            
            red_n = double(red) / double(sum);
            green_n = double(green) /  double(sum);
            
            indexr = uint8(red_n * (num_bins-1))+1;
            indexg = uint8(green_n * (num_bins-1))+1;

            h(indexr, indexg) = h(indexr, indexg) + 1; 
        end
    end  
end


