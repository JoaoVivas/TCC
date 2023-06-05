function [lb,ub] = fixed_bounds_2(x)
    global min_x min_y 
    global max_x max_y
    
    N = length(x(1,:));
    base = ones(1,N);
    
    lb(1,:) = base*min_x;
    lb(2,:) = base*min_y;
    
    ub(1,:) = base*max_x;
    ub(2,:) = base*max_y;
    end