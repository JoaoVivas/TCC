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
% hargraves_base_x2
% runge_kutta_base_x2
% runge_kutta_x2
% runge_kutta_x4
 hargraves_x2
% hargraves_x4 % roda mais ou menos mas foge da curva mesmo com a função de otimização
% hargraves_x3 % horrivel
% hargraves_x5 % horrrivel

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
%% --------------------------------------- Runge Kutta Result --------------------------------
r_s0 = [0 0 0 0];
r_base(1,:) = r_des_xb;
r_base(2,:) = r_des_yb;
r_base(3,:) = r_vel_xb;
r_base(4,:) = r_vel_yb;

[r_s_base] = runge_kutta(r_s0, r_base, t_base, @dynamic_model);

figure(1001)
plot(r_s_base(1,:),r_s_base(2,:),r_base(1,:),r_base(2,:))
title ('x_y da ponta otimiada e base otimizada')
legend('ponta','base')

