data = load('data.txt');
X = data(:,1:2)';
Y = data(:,3)';

hold on;
pos = find(Y==1);neg = find(Y==0);
plot(X(1,pos),X(2,pos),'b+');
plot(X(1,neg),X(2,neg),'ro');
hold off;

shape_X = size(X);
shape_Y = size(Y);
n_x = shape_X(1);
n_h = 10;
n_y = shape_Y(1);
m = shape_Y(2);
alpha = 1.5;

W1 = rande(n_h, n_x)*1;
b1 = zeros(n_h, 1);
W2 = rand(n_y, n_h)*1;
b2 = zeros(n_y, 1);

function g = sigmoid(z)
  g = 1.0 ./ (1.0 + exp(-z));
end

function g = sigmoidGrad(z)
  g = sigmoid(z) .* (1 - sigmoid(z));
end

function cost = compute_cost(A2, Y)
  m = size(Y,2);
  logprobs = Y .* log(A2) + (1 - Y) .* log(1 - A2);
  cost = - sum(logprobs) / m;
end

for i=0:10000
  
  #forward Propogation
  Z1 = W1 * X + b1;
  A1 = tanh(Z1);
  Z2 = W2 * A1 + b2;
  A2 = sigmoid(Z2);

  cost = compute_cost(A2, Y);
  
  #backward Propogation
  dZ2 = A2 - Y;
  dW2 = (dZ2 * A1') / m;
  db2 = sum(dZ2) / m;
  dZ1 = (W2' * dZ2 ) .* (1 - A1.^2);
  dW1 = (dZ1 * X') / m;
  db1 = sum(dZ1,2) / m;

  #updating Parameters
  W1 -= alpha * dW1;
  W2 -= alpha * dW2;
  b1 -= alpha * db1;
  b2 -= alpha * db2;
  
  if mod(i, 500)==0
    printf("%d\n",cost);
  end
end
printf("Accuracy=%d Cost=%d",mean(round(A2)==Y)*100,cost);
