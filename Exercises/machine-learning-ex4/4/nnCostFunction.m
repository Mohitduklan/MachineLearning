function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
m = size(X, 1);
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));
D1= zeros(size(Theta1));
D2= zeros(size(Theta2));
a1=[ones(m,1) X];
z2=a1*Theta1';
a2=sigmoid(z2);
a2=[ones(m,1) a2];
z3=a2*Theta2';
h=sigmoid(z3);
for i=1:m,
  y_new(i,y(i))=1;
end
J=(1/m)*sum(sum(-y_new.*log(h)-(1-y_new).*log(1-h) ));
reg=lambda/(2*m)*(sum(sum(Theta1(:,2:end).^2)) + sum(sum(Theta2(:,2:end).^2)));
J+=reg;
d3= h-y_new;
d2=d3*Theta2.*sigmoidGradient([ones(m,1) z2]);
D1+=(d2(:,2:end)'*a1);
D2+=d3'*a2;
Theta1_grad = 2*D1 / m;
Theta2_grad = 2*D2 / m;
Theta1_grad(:, 2:end) += ((lambda/m) * Theta1(:, 2:end));
Theta2_grad(:, 2:end) += ((lambda/m) * Theta2(:, 2:end));
grad = [Theta1_grad(:) ; Theta2_grad(:)];
end
