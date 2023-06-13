%% --------------------------------- x Setup ---------------------------------------------
nonlcon = @dbi_hargraves_x4

x(1,:) = des_x;
x(2,:) = des_y;
x(3,:) = des_x;
x(4,:) = des_y;

global x_entr
x_entr = x;
%% ------------------------------------------ Bounds --------------------------------------

global min_x min_y 
global max_x max_y

N = length(x(1,:));
base = ones(1,N);

lb(1,:) = base*min_x;
lb(2,:) = base*min_y;
lb(3,:) = base*min_x;
lb(4,:) = base*min_y;

ub(1,:) = base*max_x;
ub(2,:) = base*max_y;
ub(3,:) = base*max_x;
ub(4,:) = base*max_y;
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
r_vel_x(1) = 0;
r_vel_y(1) = 0;
r_acc_x(1) = 0;
r_acc_y(1) = 0;

r_des_xb = optimal(3,:); 
r_des_yb = optimal(4,:);
r_vel_xb(1) = 0;
r_vel_yb(1) = 0;
r_acc_xb(1) = 0;
r_acc_yb(1) = 0;

for i = 1 : (length(r_t)-1)
    dt = r_t(i+1)-r_t(i);
    
    [r_vel_x(i+1),r_vel_y(i+1),r_acc_x(i+1),r_acc_y(i+1)] = dot_const_acc(...
        r_des_x(i), r_des_y(i), r_des_x(i+1), r_des_y(i+1), r_vel_x(i), r_vel_y(i), dt);

    [r_vel_xb(i+1),r_vel_yb(i+1),r_acc_xb(i+1),r_acc_yb(i+1)] = dot_const_acc(...
        r_des_xb(i), r_des_yb(i), r_des_xb(i+1), r_des_yb(i+1), r_vel_xb(i), r_vel_yb(i), dt);
end