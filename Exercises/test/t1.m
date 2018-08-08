
X = [1,0,1,0;0,0,1,1];
y = [0,1,1,0];
epsilon_init=0.12;
w1 = rand(2,2)* 2 * epsilon_init - epsilon_init;
w2 = rand(1,2)* 2 * epsilon_init - epsilon_init;
b1 = rand(2,4)* 2 * epsilon_init - epsilon_init;
b2 = rand(1,4)* 2 * epsilon_init - epsilon_init;
alpha = 15;

function g = sigmoid(z)
  g = 1./(1+exp(-z));
end

function g = Gsigmoid(z)
  g = 1./(1+exp(-z));
end
for i=1:7000
  m = length(X);
  z1 = w1*X + b1;
  a1 = sigmoid(z1);
  z2 = w2*a1 + b2;
  a2 = sigmoid(z2);
  J=(1/m)*sum(sum(-y.*log(a2) - (1-y).*log(1-a2) ))

  da2 = (a2-y);
  dz2 = da2.*Gsigmoid(z2);
  dw2 = (dz2*a1')./m;
  db2 = dz2./m;
  da1 = w2' * dz2;
  dz1 = da1.*Gsigmoid(z1);
  dw1 = (dz1*X')./m;
  db1 = dz1./m;
  w1 = w1 - alpha*dw1;
  w2 = w2 - alpha*dw2;
  b1 = db1;
  b2 = db2;
end


#[j,gr] = nnCOstFunction(w1,w2,b1,b2,X,y);