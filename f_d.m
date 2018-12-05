function fd = f_d(expression, x, d)

if(d==0)
    d = 10^-3;
end
f = expression;
fd = (f(x+d) - f(x-d))/(2*d);

end

