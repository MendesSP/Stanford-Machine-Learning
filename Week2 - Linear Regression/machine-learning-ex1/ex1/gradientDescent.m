function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn theta
%   theta = GRADIENTDESENT(X, y, theta, alpha, num_iters) updates theta by 
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
J_history = zeros(num_iters, 1);

for iter = 1:num_iters

    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta. 
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCost) and gradient here.
    %

    %Vectorized Version
    sumOfError1 = sum(((theta(1)*X(:,1)+theta(2)*X(:,2))-y(:)).*X(:,1));
    temp1 = theta(1)-(alpha*sumOfError1)/m;
    
    sumOfError2 = sum(((theta(1)*X(:,1)+theta(2)*X(:,2))-y(:)).*X(:,2));
    temp2 = theta(2)-(alpha*sumOfError2)/m;
    
    %Loop Version
    % for i=1:m
    %     h(i) = theta(1)*X(i,1)+theta(2)*X(i,2);
    %     error(i) = (h(i)-y(i));
    % end
    % sumOfError = sum(error);
    % temp1 = theta(1)-(alpha*sumOfError)/m;
    %
    % for i=1:m
    %     h(i) = theta(1)*X(i,1)+theta(2)*X(i,2);
    %     error(i) = (h(i)-y(i))*X(i,2);
    % end
    %
    % sumOfError = sum(error);
    % temp2 = theta(2)-(alpha*sumOfError)/m;
    
    theta(1)=temp1;
    theta(2)=temp2;

    % ============================================================

    % Save the cost J in every iteration    
    J_history(iter) = computeCost(X, y, theta);

end

end
