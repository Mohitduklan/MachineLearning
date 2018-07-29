clear,clc,close all
load('ex7faces.mat');
[m,n] = size(X);
K = 3;



#Optimizing Centroids
for j = 1:200
  j
  suffle = randperm(rows(X));
  for k = 1:K
    centroids(k,:) = [X(suffle(k),:)];
  endfor
  add=0;
  min=inf;
  for i = 1:m
    for k = 1:K
        diff = X(i,:) - centroids(k,:);
        diff = diff * diff';
        if(diff<min)
           min = diff;
        endif
     endfor
     add = add+ min;
  endfor
  
  if(add < 0.10)
    add
    break;
  endif

endfor

  #graphics
  hold on;
  scatter(X(:,1),X(:,2));
  scatter(centroids(:,1),centroids(:,2),'x');
  hold off;
  pause;
  
for maxItr = 1:10
  for i = 1:m
    min = inf;
     for k = 1:K
      diff = X(i,:) - centroids(k,:);
      diff = diff * diff';
      if(diff < min)
        min = diff;
        closest(i) = k;
      endif
    endfor
  endfor
  
  
  #computing new Centroids position
  for k = 1:K
    find_k = find(closest == k);
    add = sum(X(find_k,:));
    centroids(k,:) = add./columns(find_k);
  endfor

endfor


  #graphics
  hold on;
  scatter(X(:,1),X(:,2));
  scatter(centroids(:,1),centroids(:,2),'x');
  hold off;
  pause;