function outimage=gaussianfilter(img,sigma)
outimage=img;
    G = gauss1b(sigma);
    width = (size(img,1));
    height = (size(img,2));
    channelnum = (size(img,3));
    for i=1:width
        for j = 1:channelnum
            list = conv(img(i,:,j),G,'same');
            outimage(i,:,j) = list;
        end
    end
    for i=1:height
        for j = 1:channelnum
            list = conv(outimage(:,i,j),G,'same');
            outimage(:,i,j) = list;
        end
    end
end
