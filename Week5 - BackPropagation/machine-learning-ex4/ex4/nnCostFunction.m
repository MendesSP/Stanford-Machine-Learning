function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

X= [ones(m,1) X];           %X  = m x n+1
z2 = X*Theta1';             %z2 = (m x n+1)x(n+1 x h) = m x h
a2 = sigmoid(z2);           %a2 = m x h
a2= [ones(size(X,1),1) a2]; %a2 = m x h+1
z3 = a2*Theta2';            %z3 = (m x h+1)x(h+1 x k) = m x k
a3 = sigmoid(z3);           %a2 = m x k

yk = zeros(num_labels,m);
yk(sub2ind(size(yk), y', 1:m)) = 1;
yk=yk'; %yk= m x k
err = (-yk.*log(a3))-((1-yk).*log(1-a3));

reg1 = sum(sum(Theta1(:,2:end).^2));
reg2 = sum(sum(Theta2(:,2:end).^2));

J = sum(sum(err))/m + (lambda*(reg1+reg2)/(2*m));

 
delta3 = a3 - yk; % m x k 
delta2 = (delta3*Theta2).*[ones(size(X,1),1) sigmoidGradient(z2)]; % (m x k) x (k x h+1) = (m x h+1) .x ( m x h+1)
delta2 = delta2(:,2:end);

Cdelta1 = X'*delta2; % (n+1 x m) x (m x h+1) = n+1 x h
Cdelta2 = a2'*delta3; % (h+1 x  m) x (m x k) = h+1 x k

Cdelta1 = Cdelta1'; % h x n+1
Cdelta2 = Cdelta2'; % k x h+1


Theta1_grad = Cdelta1/m; 
Theta2_grad = Cdelta2/m;

Theta1_grad(:,2:end) = Theta1_grad(:,2:end) + (lambda*Theta1(:,2:end)/(m));
Theta2_grad(:,2:end) = Theta2_grad(:,2:end) + (lambda*Theta2(:,2:end)/(m));


% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end