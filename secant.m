function [optima,nfunc] = secant(expression, start, last, m)

e = 10^-3;
f = expression;
a = start;
b = last;
nfunc = 0;
iter = 0;

if (m==1)
    if(f_d(f,a,0.01*a) * f_d(f,b,0.01*b) < 0)
        fda = f_d(f,a,0.01*a);
        fdb = f_d(f,b,0.01*b);
        z = b - ((fdb)*(b-a)/(fdb-fda));
        nfunc= nfunc+4;
        while(abs(f_d(f,z,0.01*z))>e)
            t = f_d(f,z,0.01*z);
            if (t>0)
                a= z;
            elseif (t<0)
                b = z;
            end
            fda = f_d(f,a,0.01*a);
            fdb = f_d(f,b,0.01*b);
            z = b - ((fdb)*(b-a)/(fdb-fda));
            nfunc = nfunc+4;
        end
    end
end
if (m==0)
 
    if(f_d(f,a,0.01*a) * f_d(f,b,0.01*b) < 0)
        fda = f_d(f,a,0.01*a);
        fdb = f_d(f,b,0.01*b);
        z = b - ((fdb)*(b-a)/(fdb-fda));
        nfunc = nfunc+4;
        iter = iter+1;
        while(abs(f_d(f,z,0.01*z))>e && z>start && z<last && iter<1e+3)
            t = f_d(f,z,0.01*z);
            if (t<0)
                a= z;
            elseif (t>0)
                b = z;
            end
            fda = f_d(f,a,0.01*a);
            fdb = f_d(f,b,0.01*b);
            z = b - ((fdb)*(b-a)/(fdb-fda));
            nfunc = nfunc+4;
            iter= iter+1;
             
        end
    else
        if(f(a)>f(b))
            z = b;
        else
            z = a;
        end
    end
end

optima = z;
end

