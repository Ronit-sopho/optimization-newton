function [ opt, function_array, seq_opt, nfunc_total ] = penalty_method( f, G, H, V, limits, m, n_var )

	% Plotting Semantics
	function_array = [];
	seq_opt = [];

	% Penalty Parameter
	R = 0.1;
	c = 10;

	% Termination Parameters
	eps1 = 10^-3;
	eps2 = 10^-3;
	M = 100; %----------------Number of iterations for newton's method

	% Constants
	[rg, cg] = size(G);
	[rv, cv] = size(V);
	[rh, ch] = size(H);
	J = cg + cv;
	K = ch;
	
	% Initialize function evaluation counter
	nfunc_total = 0;

	F = matlabFunction(f);
	
	% Generate Penalty Function
	if(m==1)
		f = -1 * f;
	end
	P_old = f + bracket_penalty(R,G,H,V);
	p_old = matlabFunction(P_old);

	% Store the function for plotting later
	
	function_array = [function_array P_old];
	

	% Initialize variables
	low_limit = max(limits(:,1));
	up_limit = min(limits(:,2));

	% Try to come up with Monte-Carlo Points
	% r = rand(n_var, 500);
	% l = limits(:,2) - limits(:,1);
	% nums = l.*r + limits(:,1);
	% min_dist = 10^20;
	% tdist = 0;
	% for j=linspace(1,500,500)
	% 	% t = fgrad(p_old, nums(:,j)', 0.001);
	% 	tdist = 0;
	% 	point = num2cell(nums(:,j));
	% 	if(length(G)~=0)
	% 		g_func = matlabFunction(G);
	% 		tdist = tdist + sum(g_func(point{:}));
	% 	end
		
	% 	if(length(H)~=0)
	% 		h_func = matlabFunction(H);
	% 		tdist = tdist + sum(h_func(point{:}));
	% 	end
		
	% 	if(abs(tdist)<min_dist)
	% 		x_t = nums(:,j)';
	% 	end
	% end

	% Random Point
	x_t = (up_limit - low_limit).*rand(1,n_var) + low_limit;

	% Point close to desired minima for working proof // Uncomment the line below to choose initial point close to minima
	% x_t= [-1.5 1.5 1.5 -0.5 -0.5];
	seq_opt = [seq_opt; x_t];
	fprintf('\nStarting from point: ');
	fprintf('%f ',x_t);
	fprintf('\n');
	x_eval = num2cell(x_t);
	sequence_number = 1;

	% First call to Newton's Method outside loop
	fprintf('Starting Sequence: 1 ::');
	[opt, nfunc_nm] = newton_method(P_old, limits, x_t, n_var, M);
	seq_opt = [seq_opt; opt];
	nfunc_total = nfunc_total + nfunc_nm;

	% Update Penalty Parameter
	R = c*R;
	fprintf(' Point Obtained: ');
	fprintf('%f ',opt);
	fprintf('\n');
	x_opt = num2cell(opt);
	

	% Generate New Penalty Function
	P_new = f + bracket_penalty(R,G,H,V);
	p_new = matlabFunction(P_new);

	
	function_array = [function_array P_new];
	

	nfunc_total = nfunc_total + 2;
	while(abs(p_new(x_opt{:}) - p_old(x_eval{:})) > eps1 && sequence_number<15)

		fprintf('Starting Sequence: %d ::', sequence_number+1);
		x_t = opt;
		x_eval = num2cell(x_t);
		[opt, nfunc_nm] = newton_method(P_new, limits, x_t, n_var, M);
		seq_opt = [seq_opt; opt];
		% Update Penalty Parameter
		R = c*R;
		fprintf(' Point Obtained: ');
		fprintf('%f ',opt);
		fprintf('\n');
		x_opt = num2cell(opt);

		p_old = p_new;

		% Generate New Penalty Function
		P_new = f + bracket_penalty(R,G,H,V);
		p_new = matlabFunction(P_new);

		sequence_number = sequence_number + 1;

		
		function_array = [function_array P_new];
		

		nfunc_total = nfunc_total + nfunc_nm + 1;

	end

	% Display optimum point
	if (n_var~=8)
		v = F(x_opt{:});
	end
	fprintf('\nOptimum point for the function is: ');
	fprintf('%f ',opt);
	fprintf(' :: With function value: %f\n',v);
	fprintf('Total number of function evalutions :: %d\n',nfunc_total);

end