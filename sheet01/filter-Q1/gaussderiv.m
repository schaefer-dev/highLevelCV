function [imgDx,imgDy]=gaussderiv(img,sigma)
    G=gauss(sigma);
    D=gaussdx(sigma);
    
    width = (size(img,1));
    height = (size(img,2));
    channelnum = (size(img,3));
    
    imgDx = zeros(width,height,channelnum);
    imgDy = zeros(width,height,channelnum);
    
    % calculate the patial x-derivative by applying D
    % horizontally and G vertically
    % calculate the patial y-derivative by applying G
    % horizontally and D vertically
    for i=1:height
        for h = 1:channelnum
            Dhor_img = conv(img(:,i,h),D,'same');
            imgDx(:,i,h) = Dhor_img;
            Ghor_img = conv(img(:,i,h),G,'same');
            imgDy(:,i,h) = Ghor_img;
        end 
    end
 
    for i=1:width
        for h = 1:channelnum
            Gver_img = conv(imgDx(i,:,h),G,'same');
            imgDx(i,:,h) = Gver_img;
            Dver_img = conv(imgDy(i,:,h),D,'same');
            imgDy(i,:,h) = Dver_img;
        end
    end
    
    % displaying the result
    %{
    impixelregion(imagesc(imgDx))
    waitforbuttonpress
    
    impixelregion(imagesc(imgDy))
    waitforbuttonpress
    %}
end
