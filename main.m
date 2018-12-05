
% Follow the line below to comments input
% Enter Question number as p1,p2,p3...etc. and choose the method to be followed.

clc

ques_no = input('\nEnter question number: ', 's');

% Choose the number corresponding to them
fprintf('Choose Method: 1) Method of Multipliers :: 2) Penalty Method :: ');
method = input('');

% Get function expression and other parameters from the input file
[f, G, H, V, R, limits, m, n_var] = input_functions(ques_no);

% Define a figure for plots
% figure
% hold on

% Switch to the selected method
switch method

	case 1
		% For loop represents number of different initial guessess.
		for i=1:1
			[opt,function_array,seq_opt,nfunc_total] = MoM(f, G, H, V, R, limits, m, n_var);

			% Draw convergence plot of function value with sequence number
			% conv_plot(f, seq_opt, ques_no, method);
		end
	case 2
		fprintf('Normalizing Inequalities...\n');
		G_norm = normalization_ineq(G, limits);
		fprintf('Normalizing Equalities...\n');
 		H_norm = normalization_eq(H, limits);
 		for i=1:1
 			[opt,function_array,seq_opt,nfunc_total] = penalty_method(f, G_norm, H_norm, V, limits, m, n_var);

 			% Draw convergence plot of function value with sequence number
 			% conv_plot(f, seq_opt, ques_no, method);
 		end
 	otherwise
 		fprintf('Wrong input :(');
		
end

fprintf('Plotting...\n');

% Uncomment to draw contour plots

% Draw some plots
% 1)Contour
% If number of variables is 2
% if(n_var==2)
% 	draw_plot(function_array, seq_opt, G, limits, ques_no, method);
% end

fprintf('Done.\n');