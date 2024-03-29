%
%  compute joint histogram for each color channel in the image, histogram should be normalized so that sum of all values equals 1
%  assume that values in each channel vary between 0 and 255
%
%  img_color - input color image
%  num_bins - number of bins used to discretize each channel, total number of bins in the histogram should be num_bins^3
%

function h=rgb_hist_daniel(img_color, num_bins)

    assert(size(img_color, 3) == 3, 'image dimension mismatch');
    
    % This does not work for me - Thomas
    % assert(isfloat(img_color), 'incorrect image type');

    %define a 3D histogram  with "num_bins^3" number of entries
    data=zeros(num_bins,num_bins,num_bins);
  
    %execute the loop for each pixel in the image 
    for i=1:size(img_color,1)
        for j=1:size(img_color,2)
            % calculate r,g,b coordinate in histogram and increase
            % corresponding voxel (bin)
            indexr = uint8(img_color(i,j,1) * (num_bins-1)/255)+1;
            indexg = uint8(img_color(i,j,2) * (num_bins-1)/255)+1;
            indexb = uint8(img_color(i,j,3) * (num_bins-1)/255)+1;
            
            data(indexr, indexg, indexb) = data(indexr, indexg, indexb) + 1; 
            
            % for logging purposes
            % disp(data)
            
            % old version by daniel
            %{
            for h=1:size(img_color,3)

                % adding r value
                index = uint8(i * (num_bins-1)/255)+1;
                data(1,index) = data(1,index)+1;
    
                % adding g value
                index = uint8(j * (num_bins-1)/255)+1;
                data(2,index) = data(2,index)+1;
    
                % adding b value
                index = uint8(h * (num_bins-1)/255)+1;
                data(3,index) = data(3,index)+1;

            end
            %}
        end
    end

    % normalize everything
    
    % There should be no normalization in this histogram - Thomas
    
    r = sum(data(1));
    data(1) = data(1) ./ r;
    
    g = sum(data(2));
    data(2) = data(2) ./ g;

    b = sum(data(3));
    data(3) = data(3) ./ b;

    h = data

    disp(data)
end
