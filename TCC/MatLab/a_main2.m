%% 
clc;
clear all;
close all;

a_config2
base_command

initial_guess = false;
%%
runge_kutta_preview
%%
tic
hargraves_base_x2
toc
% runge_kutta_base_x2
% runge_kutta_x2
% runge_kutta_x4
% hargraves_x2
% hargraves_x4 % roda mais ou menos mas foge da curva mesmo com a fun��o de otimiza��o
% hargraves_x3 % horrivel
% hargraves_x5 % horrrivel

%% --------------------------------------- Result Plots -----------------------------------------
figure(1)
plot(r_des_x,r_des_y,r_des_xb,r_des_yb)
title ('Resultado x_y da ponta e base')
legend('ponta','base')

figure(2)
plot(r_t,r_des_x,r_t,r_des_y,r_t,r_des_xb,r_t,r_des_yb)
title ('Resultado x_y(t) ponta e base')
legend('x da ponta',' y da ponta ','x da base ', 'y da base')

figure(3)
plot(r_t,r_vel_x,r_t,r_vel_y,r_t,r_vel_xb,r_t,r_vel_yb)
title ('Resultado vx_vy(t) ponta e base')
legend('vx da ponta',' vy da ponta ','vx da base ', 'vy da base')
%% --------------------------------------- Runge Kutta Result --------------------------------
r_s0 = [0 0 0 0];
r_base(1,:) = r_des_xb;
r_base(2,:) = r_des_yb;
r_base(3,:) = r_vel_xb;
r_base(4,:) = r_vel_yb;

[u,t] = interpolation_acc_c(r_base,t_base,0.0001);
figure(101)
plot(r_base(1,:), r_base(2,:))
figure(102)
plot(t_base,r_base(3,:))
figure(103)
plot(u(1,:),u(2,:))
figure(104)
plot(t,u(3,:))
[r_s_base] = runge_kutta(r_s0, u, t, @dynamic_model);

figure(1001)
plot(r_s_base(1,:),r_s_base(2,:),u(1,:),u(2,:))
title ('x_y da ponta otimiada e base otimizada')
legend('ponta','base')

max_ceq_defect = max(ceq_har)
max_ceq_jerk = max(ceq_jerk)
%%
figure(2000) 
plot(t,u(3,:))
figure(2001)
plot(t_base,r_base(3,:))
