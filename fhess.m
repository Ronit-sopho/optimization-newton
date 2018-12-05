function hessian_penalty = fhess( P, x, del )

	if(del<1e-5)
		del = 1e-4;
	end
	l = length(x);
	x_eval = num2cell(x);
	hess_penalty = [];
	for i=linspace(1,l,l)
		di = zeros(1,l);
		di(i) = del;
		x_dip = num2cell(x + di);
		x_din = num2cell(x - di);
		row = [];
		for j = linspace(1,l,l)
			dj = zeros(1,l);
			dj(j) = del;
			x_dpp = num2cell(x + dj + di);
			x_dnn = num2cell(x - dj - di);
			x_dpn = num2cell(x + dj - di);
			x_dnp = num2cell(x - dj + di);
			if(i==j)
				row = [row (P(x_dip{:}) + P(x_din{:}) - 2*P(x_eval{:}))/(del^2)];
			else
				row = [row (P(x_dpp{:}) + P(x_dnn{:}) - P(x_dpn{:}) - P(x_dnp{:}))/(4*del*del)];
			end
		end
		hess_penalty = [hess_penalty; row];

	end
	hessian_penalty = hess_penalty;

end

