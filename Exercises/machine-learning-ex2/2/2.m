clear;clc;
data=load('data3.txt');
m=length(data);
n=columns(data);
x_orig=data(:,1:n-1);
y=data(:,n);
x=[ones(m,1),x_orig,x_orig(:,1).^2,x_orig(:,2).^2];
no_theta=columns(x);
theta_i=zeros(no_theta,1);
theta_f=zeros(no_theta,1);
alpha=0.001;

#By fminunc
function [J, grad] = costFunction(theta_f, X, y)
    h=1./(1+exp(-X*theta_f));
    J = -y'* log(h) - (1 - y)'* log(1 - h);
    grad = ((X' * (h - y)));
end
options = optimset('GradObj', 'on', 'MaxIter', 400);
[theta_f, J] = fminunc(@(theta_f)(costFunction(theta_f, x, y)), theta_f, options);

 
 
#By iteration

for i=0:150000
    h=1./(1+exp(-x*theta_i));
    J = 1/m*(-y'* log(h) - (1 - y)'* log(1 - h));
    cost = sum(J)./length(y);
    grad = ((x' * (h - y)));
    theta_i-=1/m*(alpha*grad);
    if mod(i,10000)==0
      printf("cost=%f\n",cost);
    end
end

predictionsOfFun =round( 1./(1+exp(-x*theta_f)));
predictionsOfItr =round( 1./(1+exp(-x*theta_i)));
accuracyOfFun=mean((predictionsOfFun==y)*100); 
accuracyOfItr=mean((predictionsOfItr==y)*100);