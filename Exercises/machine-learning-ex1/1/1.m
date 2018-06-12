clear all,clc
data=load('data1.txt');   
m=length(data);
n=columns(data)-1;
x=[ones(m,1),data(:,1:n)];
x=[x,x(:,2).^2]; #more features
noOfTheta=columns(x);
y=data(:,n+1);
theta=zeros(noOfTheta,1);
alpha=0.001;
lambda=0.1;

#gradient descent and iteration
for i=1:15000
  h=x*theta;
  theta-=alpha*(1/m)*(x'*(h-y));    #overfitted
  #theta-=alpha*(1/m)*(x'*(h-y))+(lambda/m).*theta;  #regularization
end

#costFunction for fminunc
function [J,grad] = costFunction(theta,x,y,lambda)
  m=length(y);
  h=x*theta;
  J=1/m*sum((h-y).^2);
  #grad=1/m*(x'*(h-y)); #Overfitting
  grad=1/m*(x'*(h-y))+(lambda/m).*theta;
end
  init_theta=zeros(noOfTheta,1);
  options=options = optimset('GradObj','on');
  [init_theta,cost]=fminunc(@(init_theta)(costFunction(init_theta,x,y,lambda)),init_theta,options);

plot(data(:,1),y,'rx');
hold on;
plot(x(:,2),x*theta,'b-');
plot(x(:,2),x*init_theta,'r-');
legend('Input data','by for loop','by inbuilt function');
hold off;


