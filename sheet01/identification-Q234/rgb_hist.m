%
%  compute joint histogram for each color channel in the image, histogram should be normalized so that sum of all values equals 1
%  assume that values in each channel vary between 0 and 255
%
%  img_color - input color image
%  num_bins - number of bins used to discretize each channel, total number of bins in the histogram should be num_bins^3
%

function h=rgb_hist(img_color, num_bins)

  assert(size(img_color, 3) == 3, 'image dimension mismatch');
  assert(isfloat(img_color), 'incorrect image type');

  %define a 3D histogram  with "num_bins^3" number of entries
  h=zeros(num_bins,num_bins,num_bins);
  
  %quantize the image to "num_bins" number of values
  img_color = img_color .* num_bins/255;
  img_color= ceil(img_color);
  img_color = uint8(img_color);

  %execute the loop for each pixel in the image 
  for i=1:size(img_color,1)
    for j=1:size(img_color,2)
        if(img_color(i,j,1)==0)
            img_color(i,j,1) = 1;
        end
        if(img_color(i,j,2)==0)
            img_color(i,j,2) = 1;
        end
        if(img_color(i,j,3)==0)
            img_color(i,j,3) = 1;
        end
            h(img_color(i,j,1),img_color(i,j,2),img_color(i,j,3)) = h(img_color(i,j,1),img_color(i,j,2),img_color(i,j,3)) +1;
      %increment a histogram bin which corresponds to the value of pixel i,j; h(R,G,B)
      % ...

    end
  end
  %normalize the histogram such that its integral (sum) is equal 1
  % ... 
  
  h = h(:);
