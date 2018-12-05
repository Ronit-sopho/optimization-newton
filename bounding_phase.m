function [lower, upper, nfunc] = bounding_phase(expression, start, last, m)

f = expression;
% initial_guess = (start+last)/3;
initial_guess = (last-start).*rand(1) + start;
flag = 0;
delta = (last-start)/25;
k = 0;
iteration = 0;
x_k = initial_guess;
nfunc = 0;

if(f(x_k - delta)>=f(x_k) && f(x_k)>=f(x_k+delta))
    delta = (-1)^m*delta;
elseif(f(x_k - delta)<=f(x_k) && f(x_k)<=f(x_k+delta))
    delta = -(-1)^m*delta;
else
    lower = x_k-delta;
    upper = x_k+delta;
    nfunc = nfunc+3;
    return
end

x_end = x_k + 2^k*delta;
x_k1 = x_k;
if (m==0)
    while(f(x_end) < f(x_k) && min(x_k, x_end)>=start && max(x_k,x_end)<=last)
        
        iteration = iteration+1;
        k = k+1;
        x_k1 = x_k;
        x_k = x_end;
        x_end = x_k + 2^k*delta;
        nfunc = nfunc+1;
        
    end
end
if (m==1)
    while(f(x_end) > f(x_k) && min(x_k, x_end)>=start && max(x_k,x_end)<=last)
        iteration = iteration+1;
        k = k+1;
        x_k1 = x_k;
        x_k = x_end;
        x_end = x_k + 2^k*delta;
        nfunc = nfunc+1;
        
    end
end

lower = max(start, min(x_k1,x_end));
upper = min(last, max(x_k1, x_end));

end

