function [f, G, H, V, R, limits, m, n_var] = test()

	% Problem type
	% m == 0--------minimization
	% m == 1--------mazimization
	m = 0;

	%Function Definition
	number_of_variables = 2;
	n_var = number_of_variables;
	X = sym('x', [1 number_of_variables]);

	f = (X(1)^2 + X(2) - 11)^2 + (X(1) + X(2)^2 - 7)^2;

	% Search Space
	limits = repmat([0 5], number_of_variables, 1);

	% Parameter
	R = 0.1;


	%Inequality Constraints
	G = [];
	G = [G, (X(1)-5)^2 + X(2)^2 - 26];


	%Equality Constraints
	H = [];


	%Variable Bounds
	V = [];
	%Lower bounds
	for i=1:number_of_variables
		V = [V, X(i)];
	end
	%Upper bounds

end