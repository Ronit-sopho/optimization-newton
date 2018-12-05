function grad_penalty = fgrad( P, x, del )

	if(del<1e-5)
		del = 1e-4;
	end
	l = length(x);
	grad_penalty = [];
	for i=linspace(1,l,l)
		d = zeros(1,l);
		d(i) = del;
		x_d1 = num2cell(x + d);
		x_d2 = num2cell(x - d);
		
		grad_penalty = [grad_penalty (P(x_d1{:}) - P(x_d2{:}))/(2*del)];
	end
	grad_penalty = grad_penalty';

end

