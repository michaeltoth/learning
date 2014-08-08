function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
%

% Cost function calculations

% Predictions based on theta and X vectors
% X has been passed with an additional column of ones corresponding to theta0 parameter
prediction = X * theta;

% cost function for unregularized linear regression:
unreg_cost = 1 / (2*m) * (sum((prediction - y).^2));

% compute regularization adjustment, noting that we do not regularize theta0 (indexed as theta(1))
reg_adj = lambda / (2*m) * (sum(theta.^2) - theta(1)^2);
J = unreg_cost + reg_adj;


% Gradient calculations

% Compute regularized gradient, noting that we do not regularize theta0 (indexed as theta(1))
theta_temp = theta; theta_temp(1) = 0;
grad = (1 / m) * (X' * (prediction - y)) + (lambda / m) * theta_temp;





% =========================================================================

grad = grad(:);

end
