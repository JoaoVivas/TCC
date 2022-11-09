function xdot = dynamic_model(x, u)
% x,u mm mm/s
mx = 200; % g
my = 200; % g
kx = 1000000; G
ky = 1000000;
bx = 100;
by = 100;

A = [0 0 1 0;0 0 0 1;-kx/mx 0 -bx/mx 0;0 -ky/my 0 -by/my];
B = [0 0 0 0;0 0 0 0;kx/mx 0 bx/mx 0;0 ky/my 0 by/my];

%x = [des_x;des_y;vel_x;vel_y];
%u = [des_xb;des_yb;vel_xb;vel_yb];
%dx = [vel_x;vel_y;accel_x;accel_y];
xdot = (A*x)+(B*u);
