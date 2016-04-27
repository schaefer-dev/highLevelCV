function outimage=gaussianfilter(img,sigma)
    G = gauss1b(sigma);
    width = (size(img,1));
    height = (size(img,2));
    for i=1:width
       list = conv(img(i,:),G,'same');
       outimage(i,:) = list;
    end
    for i=1:height
        list = conv(outimage(:,i),G,'same');
        outimage(:,i) = list;
    end
end
