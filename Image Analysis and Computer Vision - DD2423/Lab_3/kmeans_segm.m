function [segmentation, centers] = kmeans_segm(image, K, L, seed, bool)

% parameter bool : false if used with graph segment, true otherwise

  rand("seed", seed);
  image = double(image);
  [width, height, ~] = size(image);
  
  if bool
      Ivec = reshape(image, width*height, 3);
  else
      Ivec = image;
  end
      
%   Ivec = reshape(image, width*height, 3);
  
  segmentation = zeros(1, width*height);
  
  % Initialization
%   centers = randi(255, K, 3);
%   centers = Ivec(randi(width*height, K, 1), :);
    centers = Ivec(randi(size(Ivec, 1), K, 1), :);

  d = pdist2(Ivec, centers); 
  
  % Iterate L times
  old_centers = centers;
  empty_clusters = [];
  for i=1:L
    % Assign each pixel to the cluster center for which the distance is minimum
    [~, c] = min(d, [], 2); 
    segmentation = transpose(c);
    for k=1:K
        cluster = Ivec(segmentation == k, :);
        if size(cluster, 1) > 0
          centers(k, :) = mean(cluster);
        end               
    end
    
    if old_centers == centers
      fprintf("Converged at iteration number %d \n", i);
      break;
    end
    
    % Recompute all distances between pixels and cluster centers
    d = pdist2(Ivec, centers);
    
    old_centers = centers;
  end
  
  if old_centers ~= centers
      fprintf("Didn't converge \n");
  end 
      
  for k=1:K
    cluster = Ivec(segmentation == k, :);
    if size(cluster, 1) == 0
      empty_clusters(end+1) = k;
    end
  end
  fprintf("Empty clusters: ")
  fprintf('%g ', empty_clusters);
  
  % reshape to real form
   if bool 
     segmentation = reshape(segmentation, width, height);
   end
end