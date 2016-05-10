%
% compute joint histogram of gradient magnitudes and Laplacian
% 
% note: use the functions gradmag.m and laplace.m
%
% note: you can assume that gradient magnitude is in the range [0, 100], 
%       and Laplacian is in the range [-60, 60]
% 

function h = maglap_hist(img_gray, num_bins)

  assert(length(size(img_gray)) == 2, 'image dimension mismatch');
  assert(isfloat(img_gray), 'incorrect image type');

  sigma = 2.0;

  %define a 2D histogram  with "num_bins^2" number of entries
  h=zeros(num_bins,num_bins);

  % compute the gradient magnitudes and Laplacian
  % ... 
  lap = laplace(img_gray,sigma);
  mag = gradmag(img_gray,sigma);
  
  % quantize the gradient magnitude and Laplacian to "num_bins" number of values
  % ... 
  lap = uint8((double(lap))./100 .* num_bins)+1;
  mag = uint8((double(mag)+60)./120 .* num_bins)+1;

  % execute the loop for each pixel in the image, 
  % ... 
  for i=1:size(img_gray,1)
      for j=1:size(img_gray,2)
          h(mag(i,j),lap(i,j)) = h(mag(i,j),lap(i,j)) + 1;
      end
  end
  

  % normalize the histogram such that its integral (sum) is equal 1
  % ...
  h=h ./ sum(sum(h));
  h=reshape(h,num_bins^2,1);
end


