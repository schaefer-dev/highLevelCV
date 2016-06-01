function show_cluster_patches(feature_patches, assignments, cluster_idx)
%...
counter = 1;
figurecount = 1;
toBeDisplayed = {};
% starts iteration over all images (containing their features)
for i=1:size(feature_patches,2)
    % start iteration over the features of picture i
    for f=1:size(feature_patches{i},2)
        if assignments(counter)==cluster_idx
            % put all pictures to be displayed later in toBeDisplayed
            toBeDisplayed{figurecount} = feature_patches{i}{f};
            figurecount = figurecount + 1;
        end
        counter = counter + 1;
    end   
end

% plot all the collected patches in a rasterSize^2 grid
rasterSize = ceil(sqrt(size(toBeDisplayed,2)));
for i=1:size(toBeDisplayed,2)
    figure(1);
    subplot(rasterSize, rasterSize,i), subimage(toBeDisplayed{i});   
end

%...
end