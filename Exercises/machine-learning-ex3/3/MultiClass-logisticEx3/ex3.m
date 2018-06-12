clear ; close all; clc
input_layer_size  = 400;  % 20x20 Input Images of Digits
num_labels = 10;          % 10 labels, from 1 to 10
load('ex3data1.mat'); % training data stored in arrays X, y
m = size(X, 1);
lambda = 0.1;
[all_theta] = oneVsAll(X, y, num_labels, lambda);
pred=predictOneVsAll(all_theta,X);
rp = randperm(m);
for i = 1:m
    displayData(X(rp(i), :));
    index=rp(i);
    printf("%d\n",mod(pred(index),10));

    s = input('Paused - press enter to continue, q to exit:','s');
    if s == 'q'
      break
    end
end