function [lb,ub] = fixed_bounds_5(x)
global min_x min_y 
global max_x max_y

N = length(x(5,:));
base = ones(1,N);

lb(1,:) = base*min_x;
lb(2,:) = base*min_y;
lb(3,:) = base*min_x; % des_ux
lb(4,:) = base*min_y; % vel_ux
lb(5,:) = base*-0.0002;

ub(1,:) = base*max_x;
ub(2,:) = base*max_y;
ub(3,:) = base*max_x; 
ub(4,:) = base*max_y; 
ub(5,:) = (x(5,:)+0.0002)*1.2;
end