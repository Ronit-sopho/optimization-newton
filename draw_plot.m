function cont_plot = draw_plot(f_arr, seq_opt, G, limits, func_name, method )

% Draws the contour plot for the functions with 2 variables and also adds a layer of constraints

cont_plot = figure;

n_seq = length(f_arr);
n_constraint = length(G);

for i=1:n_seq
	x = limits(1,1):0.5:limits(1,2);
	y = limits(2,1):0.5:limits(2,2);
	[X,Y] = meshgrid(x,y);
	f = matlabFunction(f_arr(i));
	Z = f(X,Y);
	contourf(X,Y,Z,50);
	hold on;
	for j=1:n_constraint
		g = matlabFunction(G(j));
		fimplicit(g,'--y',[limits(1,1) limits(1,2) limits(2,1) limits(2,2)],'LineWidth',3.5);
	end

	for k=1:i
		x_opt = seq_opt(1:k,1);
		y_opt = seq_opt(1:k,2);
		plot(x_opt, y_opt,'w-o','LineWidth',2);
	end
	xlabel('x1');
	ylabel('x2');
	title(strcat(func_name,' Contour Plot'));
	print(strcat('./presentation/Images/', func_name, num2str(method),'_contour_seq_',num2str(i)),'-dpng');
end

% figure
% surf(X,Y,Z);

end

