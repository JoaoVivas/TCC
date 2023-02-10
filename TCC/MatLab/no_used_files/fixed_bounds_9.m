function [lb,ub] = fixed_bounds_9(x)
global min_x min_y 
global max_x max_y
global max_vel

N = length(x(1,:));
base = ones(1,N);

lb(1,:) = base*min_x;
lb(2,:) = base*-max_vel;
lb(3,:) = base*min_x; % des_ux
lb(4,:) = base*min_x; % vel_ux
lb(5,:) = base*min_y;
lb(6,:) = base*-max_vel;
lb(7,:) = base*min_y; % des_ux
lb(8,:) = base*-max_vel; % vel_uy
lb(9,:) = base*-0.0002;

ub(1,:) = base*max_x;
ub(2,:) = base*max_vel;
ub(3,:) = base*max_x; % des_ux
ub(4,:) = base*max_x; % vel_ux
ub(5,:) = base*max_y;
ub(6,:) = base*max_vel;
ub(7,:) = base*max_y; % des_ux
ub(8,:) = base*max_vel; % vel_uy
ub(9,:) = (x(9,:)+0.0002)*1.2;
end