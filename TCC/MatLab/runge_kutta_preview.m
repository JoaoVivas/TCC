s0_base = [des_x(1);des_y(1);vel_x(1);vel_y(1)];
u_base(1,:) = des_x;
u_base(2,:) = des_y;
u_base(3,:) = vel_x;
u_base(4,:) = vel_y;

[u_p,t_p] = interpolation_acc_c(u_base,t_base,0.0001);
[s_p] = runge_kutta(s0_base,u_p,t_p,@dynamic_model);

figure(1000)
plot(u_p(1,:),u_p(2,:))
hold on
plot(s_p(1,:),s_p(2,:))