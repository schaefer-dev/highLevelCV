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
    for i=1:(size(img_gray,1))
        for j=1:(size(img_gray,2))
            index = uint8(img_gray(i,j)*num_bins/255);
            data(index) = data(index)+1;
        end
    end

    % now we normalize the histogramm such that its integral is equal 1
    s = sum(data);
    h = data ./ s; 
    %step = 255 / num_bins;
    %h = bar(1:step:255, data);
end
