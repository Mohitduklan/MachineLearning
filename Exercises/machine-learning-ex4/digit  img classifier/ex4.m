%% Initialization
clear ; close all; clc
input_layer_size  = 400;  % 20x20 Input Images of Digits
hidden_layer_size = 25;   % 25 hidden units
num_labels = 10;          % 10 labels, from 1 to 10   
load('ex4data1.mat');
m = size(X, 1);
Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
VectorImage = Image2Matrix("img.jpg");
[prob Res]=predictions(Theta1,Theta2,VectorImage);
printf("Res=%f",Res);
init_nn_params = [Theta1(:) ; Theta2(:)];
options = optimset('MaxIter', 50);
lambda = 1;

costFunction = @(p) nnCostFunction(p,input_layer_size,hidden_layer_size,num_labels, X, y, lambda);
[nn_params, cost] = fmincg(costFunction, init_nn_params, options);
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)),hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end),num_labels, (hidden_layer_size + 1));
[h2 pred] = predictions(Theta1, Theta2, X);
printf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);
VectorImage = Image2Matrix("img.jpg");
[prob Res]=predictions(Theta1,Theta2,VectorImage);
printf("Res=%f",Res);