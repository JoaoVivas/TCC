%% 
clc;
clear all;
close all;

global t_base

a_config2
base_command

initial_guess = false;

runge_kutta_x2
runge_kutta_x4
hargraves_x2
hargraves_x5

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

s0_base = [des_x(1);des_y(1);vel_x(1);vel_y(1)];
u_base(1,:) = des_x;
u_base(2,:) = des_y;
u_base(3,:) = vel_x;
u_base(4,:) = vel_y;

[s_base,u_base] = runge_kutta(s0_base,u_base,t_base,@dynamic_model);

figure(1000)
plot(u_base(1,:),u_base(2,:))
hold on
plot(s_base(1,:),s_base(2,:))

%x(1,:) = s_base(1,:);
%x(2,:) = s_base(2,:);

%x(3,:) = u_base(1,:); 
%x(4,:) = u_base(2,:); 

%%
global x_entr
x_entr = x;

%% ------------------------------------------ Fmincon routine ------------------------------
optimal = [];
[lb,ub] = def_bounds(x);
[A_eq,b_eq,A_ineq,b_ineq] = lcon(x);

if isempty(optimal)
         optimal=x;
end

optimal = fmincon(objective_fun, optimal, A_ineq, b_ineq,...
                      A_eq, b_eq, lb, ub, nonlcon, options);

% optimal = optimal/1.05;

%% --------------------------------------- Result Plots -----------------------------------------
figure(1)
plot(r_des_x,r_des_y,r_des_xb,r_des_yb)
title ('x_y da ponta otimiada e base otimizada')
legend('ponta','base')

figure(2)
plot(r_t,r_des_x,r_t,r_des_y,r_t,r_des_xb,r_t,r_des_yb)
title ('x_y(t) ponta e base otimizada')
legend('x da ponta',' y da ponta ','x da base ', 'y da base')

figure(3)
plot(r_t,r_vel_x,r_t,r_vel_y,r_t,r_vel_xb,r_t,r_vel_yb)
title ('vx_vy(t) ponta e base otimizada')
legend('vx da ponta',' vy da ponta ','vx da base ', 'vy da base')