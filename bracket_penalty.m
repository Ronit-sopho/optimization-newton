function B = bracket_penalty( R, G, H, V )

	
	B = [];
	B = [B,G,V];

	% bracket operator penalty
	B = B.*heaviside(-1*B);
	B = [B, H];
	
	% penalty function 
	B= R*sum((B).^2);


end

