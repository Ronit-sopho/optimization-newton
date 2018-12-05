function [opt, function_array, seq_opt, nfunc_total] = MoM(f, G, H, V, R, limits, m, n_var)

	
	% Plotting Semantics
	function_array = [];
	seq_opt = [];

	% Termination Parameters
	eps1 = 10^-3;
	eps2 = 10^-3;
	M = 100;      %----------------Number of iterations

	% Constants
	[rg, cg] = size(G);
	[rv, cv] = size(V);
	[rh, ch] = size(H);
	J = cg + cv;
	K = ch;
	
	% Set Multipliers
	sig = zeros(1,J);
	tau = zeros(1,K);

	% Initialize function evaluation counter
	nfunc_total = 0;

	F = matlabFunction(f);
	[I,g] = inequality_penalty(G, V, sig);
	E = equality_penalty(H, tau);
	
	% Penalty Function
	if(m==1)
		f = -1 * f;
	end
	P_old = f + R*I + R*E;
	p_old = matlabFunction(P_old);

	% Store the function for plotting later
	function_array = [function_array P_old];
	

	% Initialize variables
	low_limit = max(limits(:,1));
	up_limit = min(limits(:,2));

	% Some point close to desired minima for working proof
    % x_t= [-1.5 1.5 1.5 -0.5 -0.5];

    % Random Initial Point
	x_t = (up_limit - low_limit).*rand(1,n_var) + low_limit;

	seq_opt = [seq_opt; x_t];
	fprintf('\nStarting from point: ');
	fprintf('%f ',x_t);
	fprintf('\n');
	x_eval = num2cell(x_t);
	sequence_number = 1;
    
	% First call to the newtons method
	fprintf('Starting Sequence: 1 ::');
	[opt, nfunc_nm] = newton_method(P_old, limits, x_t, n_var, M);
	seq_opt = [seq_opt; opt];
	x_opt = num2cell(opt);
	fprintf(' Point obtained: ');
	fprintf('%f ', opt);
	fprintf('\n');
	nfunc_total = nfunc_total + nfunc_nm;

	% Change the penalty function parameters
	if(~isempty(H))
		h_handle = matlabFunction(H);
		tau = h_handle(x_eval{:}) + tau;
	end

	if(~isempty(G))
		g_handle = matlabFunction(g);
		sig = g_handle(x_opt{:}) + sig;
     end
	
    % Generate New Penalty function
	[I,g] = inequality_penalty(G, V, sig);
	E = equality_penalty(H, tau);
	P_new = f + R*I + R*E;
	p_new = matlabFunction(P_new);

	
	function_array = [function_array P_new];
	

	nfunc_total = nfunc_total + 2;
	% Run till termination condition is met
	while(abs(p_new(x_opt{:}) - p_old(x_eval{:})) > eps1 && sequence_number<15)

		fprintf('Starting Sequence: %d ::', sequence_number+1);
		x_t = opt;
		x_eval = num2cell(x_t);

		% Call Newtons Method
		[opt, nfunc_nm] = newton_method(P_new, limits, x_t, n_var, M);
		seq_opt = [seq_opt; opt];
		fprintf(' Point obtained: ');
		fprintf('%f ',opt);
		fprintf('\n');
		x_opt = num2cell(opt);

		% Update Penalty parameters
		if(~isempty(H))
			h_handle = matlabFunction(H);
			tau = h_handle(x_eval{:}) + tau;
           	nfunc_total = nfunc_total + 1;
		end

		if(~isempty(G))
			g_handle = matlabFunction(g);
			sig = g_handle(x_eval{:}) + sig;
           	nfunc_total = nfunc_total + 1;
		end

		% Generate new penalty function for next sequence
		p_old = p_new;
		[I, g] = inequality_penalty(G, V, sig);
		E = equality_penalty(H, tau);
		P_new = f + R*I + R*E;
		p_new = matlabFunction(P_new);
		
		% Increase sequence counter
		sequence_number = sequence_number + 1;

		
		function_array = [function_array P_new];
		

		nfunc_total = nfunc_total + nfunc_nm + 1;

	end

	% Display the optimum point
	if (n_var~=8)
		v = F(x_opt{:});
	end
	fprintf('\nOptimum point for the function is: ');
	fprintf('%f ',opt);
	fprintf(' :: With function value: %f\n',v);
	fprintf('Total number of function evalutions :: %d\n',nfunc_total);

	% Calculate optima from fmincon
	% x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options)
	% x = fmincon(F, x_t, [],[],[],[],limits(:,1), limits(:,2), matlabFunction(G))

end