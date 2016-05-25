%
% show false negatives (misclassified positive examples) with smallest score
% show false positives (misclassified negative examples) with largest score
%
% parameters: 
%
% figidx - index of the figure used for visualization
%
% pos_test_list - cell array of positive image filenames
% pos_class_score - vector with classifier output on the images from pos_test_list
%
% neg_test_list - cell array of negative image filenames
% neg_class_score - vector with classifier output on the images from neg_test_list
%
% num_show - number of examples to be shown
%

function show_false_detections(figidx, pos_test_list, pos_class_score, neg_test_list, neg_class_score, num_show)
    % ...
    
    % show false negatives (missclassified positive examples) with largest
    % score)
    for i=1:num_show
        worst = 0.0;
        worstindex = 0;
        for i=1:length(pos_class_score)
            if pos_class_score(i) < worst
                worst = pos_class_score(i);
                worstindex = i;
            end
        end
        if worst == 0.0
            % there are no more errors to be found, because everything
            % is already positive!
            break;
        else
            % set the worst value found to zero to avoid finding it
            % twice
            pos_class_score(worstindex) = 0.0;
            % TODO we have to some stuff now with the picture we identified
            % as the worst (at index worstindex) in the current state, this 
            % is being reached num_show times
        end      
    end
    
    
    % show false positives (misclassified negative examples) with largest 
    % score
    for i=1:num_show
        worst = 0.0;
        worstindex = 0;
        for i=1:length(neg_class_score)
            if neg_class_score(i) > worst
                worst = neg_class_score(i);
                worstindex = i;
            end
        end
        if worst == 0.0
            % there are no more errors to be found, because everything
            % is already negative!
            break;
        else
            % set the worst value found to zero to avoid finding it
            % twice
            neg_class_score(worstindex) = 0.0;
            % TODO we have to some stuff now with the picture we identified
            % as the worst (at index worstindex) in the current state, this 
            % is being reached num_show times
        end      
    end
    
    % ...
end