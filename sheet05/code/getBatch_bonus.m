% --------------------------------------------------------------------
function [im, labels] = getBatch(imdb, batch)
%getBatch is called by cnn_train.

%'imdb' is the image database.
%'batch' is the indices of the images chosen for this batch.

%'im' is the height x width x channels x num_images stack of images. If
%opts.batchSize is 50 and image size is 64x64 and grayscale, im will be
%64x64x1x50.
%'labels' indicates the ground truth category of each image.

im = imdb.images.data(:,:,:,batch) ;
labels = imdb.images.labels(1,batch) ;

%%% Supplement Code
% Supplement code here! 
% if you want to do jittering(data augmentation)

end
