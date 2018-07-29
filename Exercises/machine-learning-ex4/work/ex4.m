%% Initialization
clear ; close all; clc
input_layer_size  = 400;  % 20x20 Input Images of Digits
hidden_layer_size = 25;   % 25 hidden units
num_labels = 10;          % 10 labels, from 1 to 10   
load('ex3weights.mat');
VectorImage = Image2Matrix("img.jpg");
[prob Res]=predictions(Theta1,Theta2,VectorImage);
printf("Res=%f",Res);