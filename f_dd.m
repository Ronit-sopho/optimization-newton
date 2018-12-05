function fdd = f_dd(expression, x, d)

f = expression;
fdd = (f(x+d) + f(x-d) -2*f(x) )/(d^2);

end

