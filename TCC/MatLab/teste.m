%%

vel_x2(1) = 0;
vel_y2(1) = 0;
acc_x2(1) = 0;
acc_y2(1) = 0;

t = t_base;
dt(1) = 0;

for i = 1 : (length(t)-1)
    i
    t(i)
    dt(i+1) = t(i+1)-t(i);
    [vel_x2(i+1),vel_y2(i+1),acc_x2(i+1),acc_y2(i+1)] = dot_const_acc(...
         des_x(i), des_y(i), des_x(i+1), des_y(i+1), vel_x2(i), vel_y2(i), dt(i+1));

end
%%
dt = 1;
[vel_x_f,vel_y_f,acc_x_f,acc_y_f] = dot_const_acc(...
         10.0000, 10.0000, 10.1000, 10.1000, 1, 1, dt);
%%
plot(t, vel_x2, t, vel_x)
%%
plot(t, vel_x, t, vel_y)
%%
plot(t, des_y, t, vel_y2, t, dt)
%%
plot(t, vel_x3)

%vel_x - vel_x2
%vel_y - vel_y2