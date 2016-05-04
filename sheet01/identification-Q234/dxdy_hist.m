%
%  compute joint histogram of Gaussian partial derivatives of the image in x and y direction
%  for sigma = 6.0, the range of derivatives is approximately [-34, 34]
%  histogram should be normalized so that sum of all values equals 1
%
%  img_gray - input grayvalue image
%  num_bins - number of bins used to discretize each dimension, total number of bins in the histogram should be num_bins^2
%
%  note: you can use the function gaussderiv.m from the filter exercise.
%

function h=dxdy_hist(img_gray, num_bins)
  
  assert(length(size(img_gray)) == 2, 'image dimension mismatch');
  % This does not work for me - Thomas
  % assert(isfloat(img_gray), 'incorrect image type');

  % compute the first derivatives
  
  % Supress namespace warning
  warnid = 'MATLAB:dispatcher:nameConflict';
  warning('off',warnid)
  
  cd ../filter-Q1/;
  
  % do not change this value. Otherwise the shift below will now work!
  sigma = 6;
  
  [imgDx,imgDy]=gaussderiv(img_gray,sigma);
  
  % turn warning back on
  warning('on',warnid)
  
  cd ../identification-Q234/;
   
  h = zeros(num_bins,num_bins);
  
  
  
    for i=1:size(img_gray,1)
        for j=1:size(img_gray,2)
            dx = imgDx(i,j);
            dy = imgDy(i,j);
            
            % normalize dx and dy to the interval [0,1]
            % with sigma = 6 they are in the interval [-34, 34] so we shift
            % with +34 and divide by 68
            
            dx_n = double(dx + 34) / double(68);
            dy_n = double(dy + 34) / double(68);
            
            indexdx = uint8(dx_n * (num_bins-1))+1;
            indexdy = uint8(dy_n * (num_bins-1))+1;

            h(indexdx, indexdy) = h(indexdx, indexdy) + 1; 
        end
    end  
  
end
