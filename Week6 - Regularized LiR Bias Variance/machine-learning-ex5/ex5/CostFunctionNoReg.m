function [J] = CostFunctionNoReg(X, y, theta)

m = size(X, 1);

h = X*theta;
err = (h-y);
sqerr = err.^2;

J = sum(sqerr)/(2*m);
end