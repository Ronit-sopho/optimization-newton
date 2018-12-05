function [optima, nfunc_std] = steepest_descent( F, limits, initial_value, num_var, M )

	eps1 = 10^-3;
	eps2 = 10^-3;
	grad_new = fgrad(F, initial_value, abs(min(initial_value)*0.01));

	dir_steep = -1 * grad_new;
	x_eval = num2cell(initial_value);
	k=0;
	nfunc_std = num_var*2;
	nfunc_uni = 0;

	while(norm(grad_new)>eps1 && k<=M)
		[alpha, nfunc_u] = uni_search(F, limits, x_eval, dir_steep);
		nfunc_uni = nfunc_uni + nfunc_u;
		
		x_old = cell2mat(x_eval(:));
		x_new = (cell2mat(x_eval(:)) + alpha*dir_steep)';
		x_eval = num2cell(x_new);
		grad_old = grad_new;
		grad_new = fgrad(F, x_new, abs(min(x_new)*0.01));
		dir_steep = -1 * grad_new;

		if(abs(transpose(grad_new)*grad_old) < eps2)
			break;
		end

		if((norm(x_new - x_old')/norm(x_old)) < eps1)
       		break;
    	end
    	k = k+1;
    	nfunc_std = nfunc_std + num_var*2;
    end

    optima = reshape(cell2mat(x_eval),[1,num_var]);
    nfunc_std = nfunc_std + nfunc_uni;


end