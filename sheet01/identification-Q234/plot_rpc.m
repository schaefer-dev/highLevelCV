% 
% compute and plot the recall/precision curve
%
% D - square matrix, D(i, j) = distance between model image i, and query image j
%
% note: assume that query and model images are in the same order, i.e. correct answer for i-th query image is the i-th model image
%
function plot_rpc(D, plot_color)

  recall = [];
  precision = [];
  total_imgs = size(D, 2);

  num_images = size(D, 1);
  assert(size(D, 1) == size(D, 2));

  labels = eye(num_images);
  
  % this linearizes the matrices
  d = D(:);
  l = labels(:);
 
  % this sorts d in ascending order and saves the sorting indices in
  % sortidx. These indices are used to permute l
  [d, sortidx] = sort(d, 'ascend');
  l = l(sortidx);

  % we test all possible values for our threshold => compute value pairs 
  % (recall, precision) for every point 
  tp = 0;
  for idx = 1:length(d)
    tp = tp + l(idx);

    % compute precision and recall values and append them to "recall" and "precision" vectors
    fp = idx - tp;
    pre = tp / (tp + fp);
    precision(size(precision,2)+1) = pre;
    
    fn = total_imgs - idx;
    rec = tp / (tp + fn);
    recall(size(recall,2)+1) = rec;
  end

  plot(1-precision, recall, [plot_color '-'], 'LineWidth', 2);
