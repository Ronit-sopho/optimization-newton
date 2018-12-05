function draw_uni( y ,x , func_name )

	figure
	plot(x, y, '-k');
	xlabel('Iteration Number');
	ylabel('Number of function evaluations in unidirection search');
	title(strcat(func_name,' Iterations Unidirection Plot'));
	print(strcat('./Presentation/Images/',func_name,'_uni'),'-dpng');

end

