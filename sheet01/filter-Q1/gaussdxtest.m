imgImp = zeros(25,25);
imgImp(13,13) = 1.0;

% original image
imagesc(imgImp)
waitforbuttonpress

sigma = 6.0;
G = gauss(sigma);
D = gaussdx(sigma);

width = size(imgImp,1);
height = size(imgImp,1);


% Test 1: G then G'
modified = imgImp;
for i=1:width
    list = conv(modified(i,:),G,'same');
    modified(i,:) = list;
end


imagesc(modified)
waitforbuttonpress

for i=1:height
    list = conv(modified(:,i),G,'same');
    modified(:,i) = list;
end

imagesc(modified)
waitforbuttonpress

% Test 2: G then D'
modified = imgImp;
for i=1:width
    list = conv(modified(i,:),G,'same');
    modified(i,:) = list;
end


imagesc(modified)
waitforbuttonpress

for i=1:height
    list = conv(modified(:,i),D,'same');
    modified(:,i) = list;
end


imagesc(modified)
waitforbuttonpress


% Test 3: D then G'
modified = imgImp;
for i=1:width
    list = conv(modified(i,:),D,'same');
    modified(i,:) = list;
end


imagesc(modified)
waitforbuttonpress

for i=1:height
    list = conv(modified(:,i),G,'same');
    modified(:,i) = list;
end


imagesc(modified)
waitforbuttonpress


% Test 4: G' then D
modified = imgImp;

for i=1:height
    list = conv(modified(:,i),G,'same');
    modified(:,i) = list;
end

imagesc(modified)
waitforbuttonpress

for i=1:width
    list = conv(modified(i,:),D,'same');
    modified(i,:) = list;
end


imagesc(modified)
waitforbuttonpress


% Test 2: D' then G
modified = imgImp;

for i=1:height
    list = conv(modified(:,i),D,'same');
    modified(:,i) = list;
end

imagesc(modified)
waitforbuttonpress

for i=1:width
    list = conv(modified(i,:),G,'same');
    modified(i,:) = list;
end


imagesc(modified)
waitforbuttonpress