function E = equality_penalty( H, tau )

	% Equality Penalty term function handle
	E = sum((H + tau).^2 - tau.^2);

end

