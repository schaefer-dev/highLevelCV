function show_occurrence_distribution(cluster_occurrences, cluster_idx)

  % ...
  figure(7)
  Xplot = [];
  Yplot = [];
  
  % collecting all the data to be plotted afterwards
  for i=1:size(cluster_occurrences,1)
      if cluster_occurrences(i,1)==cluster_idx
          Xplot = [Xplot cluster_occurrences(i,2)];
          Yplot = [Yplot cluster_occurrences(i,3)];
      end
  end
  
  % plots data and a star in the center
  plot(Xplot,Yplot,'.',0,0,'*');
  
  % hardcoded limitation for 300x100 pictures
  xlim([-150,150]);
  ylim([-50,50]);
  %...
end