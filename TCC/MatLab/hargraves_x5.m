%% --------------------------------- x Setup ----------------------------------
nonlcon = @dbi_hargraves_x5

x(1,:) = des_x;
x(2,:) = des_y;

x(3,:) = des_x; 
x(4,:) = des_y; 

x(5,:) = t_base;

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
r_t = optimal(5,:);

r_des_x = optimal(1,:);
r_des_y = optimal(2,:);
vel_x(1) = 0;
vel_y(1) = 0;
acc_x(1) = 0;
acc_y(1) = 0;

r_des_xb = optimal(3,:);
r_des_yb = optimal(4,:);
vel_xb(1) = 0;
vel_yb(1) = 0;
acc_xb(1) = 0;
acc_yb(1) = 0;

for i = 1 : (length(r_t)-1)
    dt = r_t(i+1)-r_t(i);
    
    [vel_x(i+1),vel_y(i+1),acc_x(i+1),acc_y(i+1)] = dot_const_acc(...
        r_des_x(i), r_des_y(i), r_des_x(i+1), r_des_y(i+1), r_vel_x(i), r_vel_y(i), dt);

    [vel_xb(i+1),vel_yb(i+1),acc_xb(i+1),acc_yb(i+1)] = dot_const_acc(...
        r_des_xb(i), r_des_yb(i), r_des_xb(i+1), r_des_yb(i+1), r_vel_xb(i), r_vel_yb(i), dt);
end