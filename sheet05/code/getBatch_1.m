% --------------------------------------------------------------------
function [im, labels] = getBatch_1(imdb, batch)
%getBatch is called by cnn_train.

%'imdb' is the image database.
%'batch' is the indices of the images chosen for this batch.

%'im' is the height x width x channels x num_images stack of images. If
%opts.batchSize is 50 and image size is 64x64 and grayscale, im will be
%64x64x1x50.
%'labels' indicates the ground truth category of each image.

%This function is where you should 'jitter' data.

% Add jittering here before returning im
im = imdb.images.data(:,:,:,batch) ;
labels = imdb.images.labels(1,batch) ;

%...
%im2 = zeros(size(im));
%{
for x = 1:size(batch,2)
    for w= 1:size(im,2)
        im2(:,w,:,x) = im(:,size(im,2)+1-w,:,x);        
    end 
end
%}

im2= flip(im,2)


im = cat(4,im,im2);
labels = [labels,labels];

%...

%%% Supplement Code
% Supplement code here! 
% --------------------------------------------------------------------


end
