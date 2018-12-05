function [alpha, nfunc_uni] = uni_search(F, limits, x_eval, dir)
    
% Calculate proper range of alpha
ll = (limits(:,1) - cell2mat(x_eval(:)));
ul = (limits(:,2) - cell2mat(x_eval(:)));

limits_l = [];
limits_u = [];

for i=linspace(1,length(dir), length(dir))
	if(dir(i)<0)
		limits_u = [limits_u ll(i)/dir(i)];
		limits_l = [limits_l ul(i)/dir(i)];
	else
		limits_l = [limits_l ll(i)/dir(i)];
		limits_u = [limits_u ul(i)/dir(i)];
	end
end


% Generate single variable function handle
syms a
x_new = num2cell(vpa(cell2mat(x_eval(:)) + a*dir, 3));
q = matlabFunction(vpa(F(x_new{:}),5));
low = max(0,max(limits_l));
[lower, upper, nfunc_b] = bounding_phase(q, low, max(0,min(limits_u)), 0);

[alpha,nfunc_s] = secant(q, lower, upper, 0);

nfunc_uni = nfunc_s + nfunc_b;

end