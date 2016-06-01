show_q1 = true;
show_q2 = true;
show_q3 = true;

% order of addpath is important
addpath('./vlfeat-0.9.9/toolbox/kmeans');
addpath('./vlfeat-0.9.9/toolbox/sift');
addpath(['./vlfeat-0.9.9/toolbox/mex/' mexext]);

%
% Question 1: codebook generation
%

if show_q1
  num_clusters = 200;

  cluster_centers = create_codebook('./cars-training', num_clusters);
 
  cluster_idx = 1;
  show_cluster_patches(feature_patches, assignments, cluster_idx);
end

%
% Question 2: occurrence generation
%

if show_q2
  cluster_occurrences = create_occurrences('./cars-training', cluster_centers);
  
  show_occurrence_distribution(cluster_occurrences, cluster_idx);
end

%
% Question 3: Recognition
%

if show_q3
  apply_ism('./cars-test/test-24.png', cluster_centers, cluster_occurrences);
end