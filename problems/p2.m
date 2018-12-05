function[f, G, H, V, R, limits, m, n_var] = p2()

	% Problem type
	% m == 0--------minimization
	% m == 1--------mazimization
	m = 0;

	%Function Definition
	number_of_variables = 2;
	n_var = number_of_variables;
	X = sym('x', [1 number_of_variables]);
	
	f = (X(1) - 10)^3 + (X(2) - 20)^3;

	% Search Space
	limits = [13 100; 0 100];

	% Parameter
	R = 100.1;

	%Inequality Constraints
	G = [];
	G = [G, (X(1)-5)^2 + (X(2)-5)^2 - 82.81];
	G = [G, -1*(X(1)-5)^2 + -1* (X(2)-5)^2 + 100]; 


	%Equality Constraints
	H = [];

	%Variable Bounds
	V = [];
	%Lower bounds
	V = [V, X(1)-13];
	V = [V, X(2)];
	%Upper bounds
	V = [V, -1*X(1)+100];
	V = [V, -1*X(2)+100];


end