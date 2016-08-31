function [error] = dataset3ParamsTesting(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

% Initialize the values array to test various C and sigma parameters
values = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];

% Initialize the error array to use in determining the optimal C and sigma parameters
error = zeros(size(values,2),size(values,2));

% Initialize optimal_C, optimal_sigma, and lowest_error parameters
optimal_C = 0;
optimal_sigma = 0;
lowest_error = 10000;

% Loop through the values above, train the model on X and y, and compute error on xval and yval
for i = 1:length(values)
	C = values(i);
	
	for j = 1:length(values)
		sigma = values(j);
		model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
		predictions = svmPredict(model,Xval);
		error(i, j) = mean(double(predictions ~= yval));
	endfor
endfor




% =========================================================================

end
