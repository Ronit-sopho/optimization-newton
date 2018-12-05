function [optimum, nfunc_nm] = newton_method( f, limits, initial_value, num_var, M)

% f: function expression for calculating hessian's
% F: MATLAB function handle for evaluating values

% Get the function handle

F = matlabFunction(f);

% Initialize function evaluation count to zero
nfunc_nm = 0;
nfunc_uni = 0;

ini_guess = num2cell(initial_value);

eps1 = 10^-3;
eps2 = 10^-2;
k = 0;


% Draw convergence Plot
% Collect data on unidirection function evaluations
n_uni = [];
k_uni = [];

% Step 2
grad = fgrad(F, initial_value, 0.001);

% Gradient function evaluations
nfunc_nm = nfunc_nm+2*num_var;

x_eval = ini_guess;
x_new = initial_value;

while(norm(grad)>eps1 && k<=M)
    
    
    del = min(x_new)*0.001;
    hess = fhess(F, x_new, del);

    % Hessian function evaluations
    nfunc_nm = nfunc_nm + (2*num_var^2+1);

    % check for singualrity
    sing = det(hess);
    flag=0;
    if(sing>eps)
        inv_hess = inv(hess);
    else
        flag=1;
        inv_hess = hess;
    end
    
    %grad_old = grad_handle(x_eval{:});
    grad_old = grad;
    % Check for positive semi-definiteness
    eigen_vector = eig(inv_hess);
    eigen_values = transpose(eigen_vector);
    if(any(eigen_values<0) || flag==1)
        % Check descent direction condition
        calc = transpose(grad_old) * hess * grad_old;
        if(calc<0 || flag==1)
            % Restart required
            % disp('Non-descent direction detected for newtons method, code will now try, steepest descent');
            % Switch over to steepest descent method and get the new point
            [optimum, nfunc_std] = steepest_descent( F, limits, x_new, num_var, M );
            nfunc_nm = nfunc_nm + nfunc_std;
            return;
        end
    end
    
    % Direction is ensured to be descent direction
    dir = -1 * hess\grad_old;
    
    % Perform unidirectional search along x_new
    [alpha,nfunc_u] = uni_search(F, limits, x_eval, dir);

    n_uni = [n_uni nfunc_u];
    k_uni = [k_uni k];
    
    % Get the new point
    x_old = cell2mat(x_eval(:));
    x_new = x_old + alpha*dir;
    x_new(x_new==0)=eps;
    x_eval = num2cell(x_new);
    x_new = x_new';
    
    k=k+1;

    % New gradient function evaluations;
    nfunc_nm  = nfunc_nm + (2*num_var);
    nfunc_uni = nfunc_uni + nfunc_u;

    % Check Termination Condition 1
    % Linear Independency Check between old and new direction
    del = min(x_new)*0.01;
    grad_new = fgrad(F, x_new, del);
    if(abs(transpose(grad_new)*grad_old) < eps2)
    	break;
    end
    
    % Check Termination condition 2
    % Check if new point is very different from old point
    x_new - x_old';
    if((norm(x_new - x_old')/norm(x_old)) < eps1)
        break;
    end

    grad = grad_new;
    
end

optimum = reshape(cell2mat(x_eval),[1,num_var]);
nfunc_nm = nfunc_nm + nfunc_uni;

    
end

