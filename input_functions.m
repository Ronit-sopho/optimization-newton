function [f,G,H,V,R,limits,m,n_var] = input_functions(problem_name)


    keySet = {
                'p1',...
                'p2',...
                'p3',...
                'p4',...
                'p5',...
                'test'
    };


    valueSet = [1,2,3,4,5,6];
    questions = containers.Map(keySet, valueSet);

    switch questions(problem_name)
        
        case 1 
            [f,G,H,V,R,limits,m,n_var] = p1();
            
        case 2
            [f,G,H,V,R,limits,m,n_var] = p2();
            
        case 3
            [f,G,H,V,R,limits,m,n_var] = p3();
            
        case 4
            [f,G,H,V,R,limits,m,n_var] = p4();
            
        case 5
            [f,G,H,V,R,limits,m,n_var] = p5();
            
        case 6
            [f,G,H,V,R,limits,m,n_var] = test();
            
    end

        
end