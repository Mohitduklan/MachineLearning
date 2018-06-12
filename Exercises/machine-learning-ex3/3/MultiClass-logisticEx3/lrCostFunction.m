function [J, grad] = lrCostFunction(theta, X, y, lambda)
m = length(y);
h=sigmoid(X*theta);
thetaT=theta;
thetaT(1)=0;
J=1/m * ( -y' * log(h) - (1-y)' * log(1 - h) )+((thetaT'*thetaT) * (lambda / (2 * m)));
grad=1/m * (X'*(h-y))+thetaT * (lambda / m);
grad = grad(:);
end
