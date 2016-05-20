%
% Visualization of the training data, support vectors, and linear SVM decision boundary.
% 
% The linear SVM decision boundary is defined by f(x) = w'*x + w0
%
% parameters:
%
% X - matrix of training points (one row per point), you can assume that points are 2 dimensional
% y - vector of point labels (+1 or -1)
% model.w and model.w0 are parameters of the decision function
% model.alpha is a vector of Lagrange multipliers

function vis_svm(X, y, model)

  min_x1 = min(X(:, 1));
  max_x1 = max(X(:, 1));
  min_x2 = min(X(:, 2));
  max_x2 = max(X(:, 2));
  
  % visualize positive and negative points  
  scatter(X(y<0,1),X(y<0,2),[],'blue','filled');
  hold;
  scatter(X(y>0,1),X(y>0,2),[],'red','filled');
  
  % visualize support vectors
  % ...

  % visualze decision boundary

  x = [min_x1,max_x1];
  y = - (model.w(1)*x+model.w0)/model.w(2);
  p = plot(x,y,'red');



  axis equal;
  axis([1.5*min_x1, 1.5*max_x1, 1.5*min_x2, 1.5*max_x2]);
  hold off;

