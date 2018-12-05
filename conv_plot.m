function  conv_plot( f, seq_opt, func_name, method)

	F = matlabFunction(f);
	[k,l] = size(seq_opt);
	X_d = num2cell(seq_opt);
	data = [];
	for i=1:k
		x = X_d(i,:);
		data = [data F(x{:})];
	end
	ymax = max(1,max(data));
	plot(data, '--','color',rand(1,3));
	set(gca,'xtick',1:k);
	ylim([0 max(0.1,max(data))]);
	xlim([1 k]);
	xlabel('Sequence Number');
	ylabel('Function value with sequence');
	title(strcat(func_name,' Convergence Plot'));
	hold on

	print(strcat('./Presentation/Images/',func_name,'_conv_',num2str(method)),'-dpng');
end

