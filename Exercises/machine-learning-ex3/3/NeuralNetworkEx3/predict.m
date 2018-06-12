function p = predict(Theta1, Theta2, X)
m = size(X, 1);
num_labels = size(Theta2, 1);
p = zeros(size(X, 1), 1);
a1=[ones(m,1),X];
a2=sigmoid(a1*Theta1');
a2=[ones(m,1),a2];
h=sigmoid(a2*Theta2');
[min,max]=max(h,[],2);
p=max;
end
