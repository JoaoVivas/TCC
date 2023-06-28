%% --------------------------------- x Setup ---------------------------------------------
nonlcon = @dbi_hargraves_x2

x(1,:) = des_x;
x(2,:) = des_y;

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

r_des_x = optimal(1,:); 
r_des_y = optimal(2,:);
r_vel_x(1) = 0;
r_vel_y(1) = 0;
r_acc_x(1) = 0;
r_acc_y(1) = 0;

for i = 1 : (length(r_t)-1)
    dt = r_t(i+1)-r_t(i);
    
    [r_vel_x(i+1),r_vel_y(i+1),r_acc_x(i+1),r_acc_y(i+1)] = dot_const_acc(...
        r_des_x(i), r_des_y(i), r_des_x(i+1), r_des_y(i+1), r_vel_x(i), r_vel_y(i), dt);
end

r_des_xb = u_base(1,:);
r_des_yb = u_base(2,:);
r_vel_xb = u_base(3,:);
r_vel_yb = u_base(4,:);
r_acc_xb = ax;
r_acc_yb = ay;