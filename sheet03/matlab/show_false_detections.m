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
  
    
    [false_neg_score, false_neg_idx]=sort(pos_class_score);
    falsenegsum = false_neg_idx(false_neg_score < 0);
    fprintf('overall number of false negatives is: %d\n', length(falsenegsum));
    most_neg =  false_neg_idx(false_neg_score(1:num_show) < 0);
    %pos_class_score(most_neg)
    %false_neg_score(1:num_show)
    
    [false_pos_score, false_pos_idx]=sort(neg_class_score,'descend');
    falsepossum = false_pos_idx(false_pos_score > 0);
    fprintf('overall number of false positives is: %d\n', length(falsepossum));
    most_pos =  false_pos_idx(false_pos_score(1:num_show) > 0); 
    %neg_class_score(most_pos)
    %false_pos_score(1:num_show)
    
    %display('False negatives');
    for i=1:length(most_neg)
        figure(figidx+i-1)
        hold on;
        title(['False negative! Score: ' num2str(pos_class_score(most_neg(i)))]); 
        imshow(imread(pos_test_list{most_neg(i)}));
        hold off;
    end
    
    %display('False positives');
    for i=1:length(most_pos)
        figure(figidx+ length(most_neg) +i-1)
        hold on;
        title(['False positive! Score: ' num2str(neg_class_score(most_pos(i)))]); 
        imshow(imread(neg_test_list{most_pos(i)}));
        hold off;
    end
    
end