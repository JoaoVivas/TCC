%% --------------------------------- x Setup ---------------------------------------------
nonlcon = @dbi_hargraves_x2_base

x(1,:) = des_x;
x(2,:) = des_y;

global x_entr
x_entr = x;
%% ------------------------------------------ Bounds --------------------------------------

global min_x min_y 
global max_x max_y

N = length(x(1,:));
base = ones(1,N);

lb(1,:) = base*min_x;
lb(2,:) = base*min_y;

ub(1,:) = base*max_x;
ub(2,:) = base*max_y;
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

r_des_xb = optimal(1,:); 
r_des_yb = optimal(2,:);
r_vel_xb(1) = 0;
r_vel_yb(1) = 0;
r_acc_xb(1) = 0;
r_acc_yb(1) = 0;

for i = 1 : (length(r_t)-1)
    dt = r_t(i+1)-r_t(i);

    [r_vel_xb(i+1),r_vel_yb(i+1),r_acc_xb(i+1),r_acc_yb(i+1)] = dot_const_acc(...
        r_des_xb(i), r_des_yb(i), r_des_xb(i+1), r_des_yb(i+1), r_vel_xb(i), r_vel_yb(i), dt);
end

r_des_x = u_base(1,:);
r_des_y = u_base(2,:);
r_vel_x = u_base(3,:);
r_vel_y = u_base(4,:);
