function h = normalization_eq( H, limits )

	% Normalize the equality constraints by generating 
	% 100 random points in search space and dividing by the maximum of them

	n_var = length(limits);
	r = rand(n_var, 100);
	l = limits(:,2) - limits(:,1);
	nums = l.*r + limits(:,1);

	n_h = length(H);
	h = [];
	for i=linspace(1,n_h,n_h)
		temp = [];
		h_func = matlabFunction(H);
		for j=linspace(1,100,100)
			point = num2cell(nums(:,j));
			temp = [temp h_func(point{:})];
		end
		h = [h H(i)/(max(temp))];
	end

end

