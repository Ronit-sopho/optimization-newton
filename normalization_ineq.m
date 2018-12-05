function g = normalization_ineq( G, limits )

	% Normalize the equality constraints by generating 
	% 100 random points in search space and dividing by the maximum of them

	n_var = length(limits);
	r = rand(n_var, 100);
	l = limits(:,2) - limits(:,1);
	nums = l.*r + limits(:,1);

	n_g = length(G);
	g = [];
	for i=linspace(1,n_g,n_g)
		temp = [];
		g_func = matlabFunction(G(i));
		for j=linspace(1,100,100)
			point = num2cell(nums(:,j));
			temp = [temp g_func(point{:})];
		end
		g = [g G(i)/(max(temp))];
	end

end

