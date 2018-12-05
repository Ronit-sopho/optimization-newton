function[f, G, H, V, R, limits, m, n_var] = p3()

	% Problem type
	% m == 0--------minimization
	% m == 1--------mazimization
	m = 1;

	%Function Definition
	number_of_variables = 2;
	n_var = number_of_variables;
	X = sym('x', [1 number_of_variables]);
	
	f = ((sin(2*pi*X(1)))^3*(sin(2*pi*X(2))))/(X(1)^3*(X(1)+X(2)));

	% Search Space
	limits = repmat([0 10], number_of_variables, 1);

	% Parameter
	R = 5.1;

	%Inequality Constraints
	G = [];
	G = [G, -(X(1))^2 + X(2) - 1];
	G = [G, X(1) - (X(2)-4)^2 - 1]; 


	%Equality Constraints
	H = [];

	%Variable Bounds
	V = [];
	%Lower bounds
	V = [V, X(1)];
	V = [V, X(2)];
	%Upper bounds
	V = [V, -1*X(1)+10];
	V = [V, -1*X(2)+10];


end