function[f, G, H, V, R, limits, m, n_var] = p2()

	% Problem type
	% m == 0--------minimization
	% m == 1--------mazimization
	m = 0;

	%Function Definition
	number_of_variables = 8;
	n_var = number_of_variables;
	X = sym('x', [1 number_of_variables]);
	
	f = ((X(1) + X(2) + X(3))/30000);

	% Search Space
	limits = [100 10000; 1000 10000; 1000 10000; 10 1000; 10 1000; 10 1000; 10 1000; 10 1000];

	% Parameter
	R = 500.001;

	%Inequality Constraints
	G = [];
	G = [G, -0.0025*(X(4)+X(6)) + 1];
	G = [G, -0.0025*(-X(4)+X(5)+X(7)) + 1]; 
	G = [G, -0.01*(-X(6)+X(8)) + 1];
	G = [G, -100*X(1)+X(1)*X(6)-833.33252*X(4)+83333.333];
	G = [G, -X(2)*X(4)+X(2)*X(7)+1250*X(4)-1250*X(5)];
	G = [G, -X(3)*X(5)+X(3)*X(8)+2500*X(5)-125000]; %-------Constraint might be wrong!

	%Equality Constraints
	H = [];

	%Variable Bounds
	V = [];
	%Lower bounds
	V = [V, X(1)-100];
	V = [V, X(2)-1000];
	V = [V, X(3)-1000];
	V = [V, X(4)-10];
	V = [V, X(5)-10];
	V = [V, X(6)-10];
	V = [V, X(7)-10];
	V = [V, X(8)-10];
	%Upper bounds
	V = [V, -1*X(1)+10000];
	V = [V, -1*X(2)+10000];
	V = [V, -1*X(3)+10000];
	V = [V, -1*X(4)+1000];
	V = [V, -1*X(5)+1000];
	V = [V, -1*X(6)+1000];
	V = [V, -1*X(7)+1000];
	V = [V, -1*X(8)+1000];



end