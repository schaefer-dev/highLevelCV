%
%  compute joint histogram for each color channel in the image, histogram should be normalized so that sum of all values equals 1
%  assume that values in each channel vary between 0 and 255
%
%  img_color - input color image
%  num_bins - number of bins used to discretize each channel, total number of bins in the histogram should be num_bins^3
%

function h=rgb_hist(img_color, num_bins)

    assert(size(img_color, 3) == 3, 'image dimension mismatch');
    
    
    assert(num_bins <= 255, 'num_bins is not allowed to be bigger than 255');
    assert(num_bins > 0, 'num_bins has to be > 0');
    num_bins = uint8(num_bins);
    
    % This does not work for me - Thomas
    % assert(isfloat(img_color), 'incorrect image type');

    %define a 3D histogram  with "num_bins^3" number of entries
    data=zeros(uint8(num_bins),uint8(num_bins),uint8(num_bins));
  
    %execute the loop for each pixel in the image 
    for i=1:size(img_color,1)
        for j=1:size(img_color,2)
            % calculate r,g,b coordinate in histogram and increase
            % corresponding voxel (bin)
            indexr = uint8(img_color(i,j,1) * (num_bins-1)/255)+1;
            indexg = uint8(img_color(i,j,2) * (num_bins-1)/255)+1;
            indexb = uint8(img_color(i,j,3) * (num_bins-1)/255)+1;
            
            data(indexr, indexg, indexb) = data(indexr, indexg, indexb) + 1; 
        end
    end
    h = data;
    
    s= sum(sum(sum(h)));
    
    h = h./ s;
    h = h(:);
end