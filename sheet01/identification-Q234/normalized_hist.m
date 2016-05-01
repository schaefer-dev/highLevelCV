%
%  compute histogram of image intensities, histogram should be normalized so that sum of all values equals 1
%  assume that image intensity varies between 0 and 255
%
%  img_gray - input image in grayscale format
%  num_bins - number of bins in the histogram
%
function h = normalized_hist(img_gray, num_bins)
    img_gray=double(img_gray);

    % catching wrong inputs
    assert(length(size(img_gray)) == 2, 'image dimension mismatch');
    assert(isfloat(img_gray), 'incorrect image type');
  
    % data is collecting the amout of times a specific range of values occurs
    % the range is determined by num_bins which specifies the amout of ranges
    % we split our spectrum to.
    data = zeros(1,num_bins);
    
    height = size(img_gray,1);
    width = size(img_gray,2);
    
    
    for i=1:height
        for j=1:width
            % multiply with num_bin-1 to map in the interval [0,num_bin-1]
            % and shift then with 1 to map in [1,num_bin] (Matlab indices start with 1)
            index = uint8(img_gray(i,j)*(num_bins-1)/255) + 1;
            data(index) = data(index)+1;
        end
    end
    
    % now we normalize the histogramm such that its integral is equal 1
    s = height * width;
    h = data ./ s; 
    
    
    %step = 255 / num_bins;
    %h = bar(1:step:255, data);
end
