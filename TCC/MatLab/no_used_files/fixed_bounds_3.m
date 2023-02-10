function [lb,ub] = fixed_bounds_3(x)
global min_x min_y 
global max_x max_y

N = length(x(1,:));
base = ones(1,N);

lb(1,:) = base*min_x;
lb(2,:) = base*min_y;
lb(3,:) = base*-0.0002;

ub(1,:) = base*max_x;
ub(2,:) = base*max_y;
ub(3,:) = (x(3,:)+0.0002)*1.2;
end