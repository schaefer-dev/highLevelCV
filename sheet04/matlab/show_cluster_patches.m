function show_cluster_patches(feature_patches, assignments, cluster_idx)
%...
counter = 1;
figurecount = 1;
% starts iteration over all images (containing their features)
for i=1:size(feature_patches,2)
    % start iteration over the features of picture i
    for f=1:size(feature_patches{i},2)
        if assignments(counter)==cluster_idx
            %plotting of feature_patches{i}{f}, TODO: subplot
            figure(figurecount);
            subimage(feature_patches{i}{f});
            figurecount = figurecount + 1;
        end
        counter = counter + 1;
    end   
end

%...
end