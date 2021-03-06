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
n = size(y, 1);
         
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


% Part 1: Feedforward

% Compute Cost:
% Add row of ones to X
X = [ones(m, 1) X];
a1 = X;
% Compute z2 (hidden layer), compute its sigmoid as a2, and add a row of ones
z2 = a1 * Theta1';
a2 = sigmoid(z2);
a2 = [ones(m, 1) a2];
% Compute z3 (output layer) and compute it's sigmoid
z3 = a2 * Theta2';
a3 = sigmoid(z3);
h = a3;

% Vectorize y:
yvec = zeros(n,num_labels);
for i = 1:n
	yvec(i,y(i)) = 1;
endfor

% Calculate cost:
costvec = zeros(m,1);

% Loop over training set examples to compute a cost vector, then sum
for i = 1:m
	costvec(i) = -yvec(i,:)*log(h(i,:))' - (1-yvec(i,:))*log(1-h(i,:))';
endfor
J = sum(costvec) / m;

% Regularized cost function:

regcost1 = 0;
regcost2 = 0;

% Compute first regularized cost using Theta1 parameters
for j = 1:hidden_layer_size
	for k = 2:(input_layer_size + 1) % start from 2 because we don't regularize bias term
		regcost1 = regcost1 + Theta1(j,k)^2;
	endfor
endfor

% Compute second regularized cost using Theta2 parameters
for j = 1:num_labels
	for k = 2:(hidden_layer_size + 1) % start from 2 because we don't regularize bias term
		regcost2 = regcost2 + Theta2(j,k)^2;
	endfor
endfor

regcost = (lambda/(2*m)) * (regcost1 + regcost2);
J = J + regcost;




% Part 2: Backpropagation

capital_delta1 = zeros(size(Theta1));
capital_delta2 = zeros(size(Theta2));

%Loop over training examples
for t = 1:m
	%Feedforward computations for single training example
	a_1 = X(t,:)'; % Bias unit already added above
	z_2 = Theta1 * a_1;
	a_2 = sigmoid(z_2);
	a_2 = [1; a_2]; % Adding bias unit
	z_3 = Theta2 * a_2;
	a_3 = sigmoid(z_3);
	
	%Compute delta 3 for outputs using vectorized y
	delta_3 = a_3 - yvec(t,:)';
	
	%Use backpropagation to compute delta 2
	delta_2 = (Theta2' * delta_3)(2:end) .* sigmoidGradient(z_2); % Removing first element associated with bias
	
	%Accumulate gradients by adding to capital_delta for each training example
	capital_delta1 = capital_delta1 + delta_2 * a_1';
	capital_delta2 = capital_delta2 + delta_3 * a_2';
endfor

Theta1_grad = (1 / m) * capital_delta1;
Theta2_grad = (1 / m) * capital_delta2;







% New backpropagation

	
	
% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
