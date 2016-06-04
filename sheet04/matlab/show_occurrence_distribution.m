function show_occurrence_distribution(cluster_occurrences, cluster_idx)

  % ...
  % hardcoding the ranges
  figure(7)
  Xplot = [];
  Yplot = [];
  
 
  for i=1:size(cluster_occurrences,1)
      if cluster_occurrences(i,1)==cluster_idx
          Xplot = [Xplot cluster_occurrences(i,2)];
          Yplot = [Yplot cluster_occurrences(i,3)];
      end
  end
  %...
  
  
  plot(Xplot,Yplot,'.',0,0,'*');
  xlim([-150,150]);
  ylim([-50,50]);
end