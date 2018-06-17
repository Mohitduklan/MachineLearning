clear ; close all; clc
input_layer_size  = 400;  % 20x20 Input Images of Digits
hidden_layer_size = 25;   % 25 hidden units there is only 1 hidden layer of 25 neurons
num_labels = 10;          % 10 labels, from 1 to 10   
load('ex3data1.mat');     % image pixel(value b/w 0-1) 
                          % there are 5000 images and 400(20x20) pixels on each pic
m = size(X, 1);           % size will be totalImg*pixelInOneImg==>[5000 400]
load('ex3weights.mat');   % weights are already given for this problem
                          % this file will contain weights for layer 1,2
                          
%   input(5000x400) theta1(25*401)  hiddenLayer(5000*25) theta2(26*10) Output(5000*10)
%         |              |                |                 |               |
%      layer1____________|______________layer2______________|_____________layer3
                          
                          
pred = predict(Theta1, Theta2, X);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);
VectorImage=Image2Matrix("img.jpg");
pred = predict(Theta1,Theta2,VectorImage);
#{
rp = randperm(m);
for i = 1:m
    displayData(X(rp(i), :));
    pred = predict(Theta1, Theta2, X(rp(i),:));
    fprintf('\nNeural Network Prediction: %d (digit %d)\n', pred, mod(pred, 10));
    s = input('Paused - press enter to continue, q to exit:','s');
    if s == 'q'
      break
    end
end
#}
