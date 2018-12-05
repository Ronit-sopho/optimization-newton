function [f, G, H, V, R, limits, m, n_var] = p1()

	% Problem type
	% m == 0--------minimization
	% m == 1--------mazimization
	m = 1;

	%Function Definition
	number_of_variables = 5;
	n_var = number_of_variables;
	X = sym('x', [1 number_of_variables]);
	elements = {};
	for i=1:number_of_variables
		elements = [elements, X(i)];
	end

	f = (number_of_variables)^(number_of_variables/2) * prod(elements);

	% Search space
	limits = repmat([0 1], number_of_variables, 1);

	% Parameter
	R = 5.1;


	%Inequality Constraints
	G = [];


	%Equality Constraints
	number_of_eq_const = 1;
	H = [];
	elements = {};
	for i=1:number_of_variables
		elements = [elements, X(i)^2];
	end
	H = [H, abs(sum(elements)-1)-1e-4];


	%Variable Bounds
	V = [];
	%Lower bounds
	for i=1:number_of_variables
		V = [V, X(i)];
	end
	%Upper bounds
	for i=1:number_of_variables
		V = [V, -X(i)+1];
	end

end