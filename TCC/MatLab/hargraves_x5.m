% 
% x(1,:) = des_x;
% x(2,:) = des_y;
% x(3,:) = vel_x;
% x(4,:) = vel_y;

% x(5,:) = des_x; % des_ux
% x(6,:) = des_y; % des_ux
% x(7,:) = vel_x; % vel_ux
% x(8,:) = vel_y; % vel_uy

% x(9,:) = [0,dt];
%% --------------------------------- x Setup ----------------------------------
x(1,:) = des_x;
x(2,:) = des_y;

x(3,:) = des_x; 
x(4,:) = des_y; 
% t = t_base;
x(5,:) = t_base;

%x(1,:) = s_base(1,:);
%x(2,:) = s_base(2,:);

%x(3,:) = u_base(1,:); 
%x(4,:) = u_base(2,:); 

%%
global x_entr
x_entr = x;
%% ------------------------------------------ Bounds --------------------------------------
global min_x min_y 
global max_x max_y

N = length(x(5,:));
base = ones(1,N);

lb(1,:) = base*min_x;
lb(2,:) = base*min_y;
lb(3,:) = base*min_x;
lb(4,:) = base*min_y;
lb(5,:) = base*-0.0002;

ub(1,:) = base*max_x;
ub(2,:) = base*max_y;
ub(3,:) = base*max_x; 
ub(4,:) = base*max_y; 
ub(5,:) = (x(5,:)+0.0002)*1.2;

%% ------------------------------------------ Fmincon routine ------------------------------
optimal = [];
[A_eq,b_eq,A_ineq,b_ineq] = lcon(x);

if isempty(optimal)
         optimal=x;
end

optimal = fmincon(objective_fun, optimal, A_ineq, b_ineq,...
                      A_eq, b_eq, lb, ub, nonlcon, options);

% optimal = optimal/1.05;

r_t

r_des_x
r_des_y
r_vel_x
r_vel_y

r_des_xb
r_des_yb
r_vel_xb
r_vel_yb