function [I, g] = inequality_penalty( G, V, sig)

    g=[];
    g= [g,G,V];

	%bracket operator penalty
	g= g.*heaviside(-1*g);

	%inequality penalty function 
	I= sum((g+sig).^2 - sig.^2);

end