function [x0] =  chute_inicial_runge_kutta(x)
global t_base

x(1,:) = des_x;
x(2,:) = des_y;
x(3,:) = des_x; 
x(4,:) = des_y; 
% t = t_base;
x(5,:) = t_base;

s0_base = [des_x(1);vel_x(1);des_y(1);vel_y(1)];
u_base(1,:) = des_x;
u_base(2,:) = vel_x;
u_base(3,:) = des_y;
u_base(4,:) = vel_y;

[s_base,u_base] = runge_kutta(s0_base,u_base,t_base,@dynamic_model);
figure
plot(u_base(1,:),u_base(3,:))
hold on
plot(s_base(1,:),s_base(3,:))

x0 = s_base;
