function [f, G, H, V, R, limits, m, n_var] = p5()

	% Problem type
	% m == 0--------minimization
	% m == 1--------mazimization
	m = 0;

	%Function Definition
	number_of_variables = 5;
	n_var = number_of_variables;
	X = sym('x', [1 number_of_variables]);
	
	% While running for MOM method remove the normalization factor at the end
	f = exp(X(1)*X(2)*X(3)*X(4)*X(5))/1.9313e75;

	% Search Space
	limits = [-2.3 2.3; -2.3 2.3; -3.2 3.2; -3.2 3.2; -3.2 3.2];

	% Parameter
	R = 0.001;


	%Inequality Constraints
	G = [];


	%Equality Constraints
	number_of_eq_const = 3;
	H = [];
	elements = {};
	for i=1:number_of_variables
		elements = [elements, X(i)^2];
	end
	H = [H, (sum(elements)-10)];
	H = [H, (X(2)*X(3)-5*X(4)*X(5))];
	H = [H, (X(1)^3+X(2)^3+1)];


	%Variable Bounds
	V = [];
	%Lower bounds
	for i=1:2
		V = [V, X(i)+2.3];
	end
	for i=3:number_of_variables
		V = [V, X(i)+3.2];
	end
	%Upper bounds
	for i=1:2
		V = [V, -1*X(i)+2.3];
	end
	for i=3:number_of_variables
		V = [V, -1*X(i)+3.2];
	end

end