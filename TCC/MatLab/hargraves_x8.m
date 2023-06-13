%% --------------------------------- x Setup ----------------------------------
nonlcon = @dbi_hargraves_x8

x(1,:) = des_x;
x(2,:) = des_y;
x(3,:) = vel_x; 
x(4,:) = vel_y; 

x(5,:) = des_xb; 
x(6,:) = des_yb; 
x(7,:) = vel_xb; 
x(8,:) = vel_yb; 

global x_entr
x_entr = x;
%% ------------------------------------------ Bounds --------------------------------------
global min_x min_y min_vx min_vy
global max_x max_y max_vx max_vy

N = length(x(5,:));
base = ones(1,N);

lb(1,:) = base*min_x;
lb(2,:) = base*min_y;
lb(3,:) = base*min_vx;
lb(4,:) = base*min_vy;

lb(5,:) = base*min_x;
lb(6,:) = base*min_y;
lb(7,:) = base*min_vx;
lb(8,:) = base*min_vy;

ub(1,:) = base*max_x;
ub(2,:) = base*max_y;
ub(3,:) = base*max_x; 
ub(4,:) = base*max_y;

ub(5,:) = base*max_x;
ub(6,:) = base*max_y;
ub(7,:) = base*max_vx; 
ub(8,:) = base*max_vy;

%% ------------------------------------------ Fmincon routine ------------------------------
optimal = [];
[A_eq,b_eq,A_ineq,b_ineq] = lcon(x);

if isempty(optimal)
         optimal=x;
end

optimal = fmincon(objective_fun, optimal, A_ineq, b_ineq,...
                      A_eq, b_eq, lb, ub, nonlcon, options);

% optimal = optimal/1.05;
r_t = t_base;

r_des_x = optimal(1,:);
r_des_y = optimal(2,:);
r_vel_x = optimal(3,:);
r_vel_y = optimal(4,:);

r_des_xb = optimal(5,:);
r_des_yb = optimal(6,:);
r_vel_xb = optimal(7,:);
r_vel_yb = optimal(8,:);
