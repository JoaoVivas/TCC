%%

% vel_x'       |0          0         1         0|  |des_x|     |0         0     0        0| |des_xb|
%              |                                |  |     |     |                          | |      |
% vel_y'       |0          0         0         1|  |des_y|     |0        0      0        0| |des_yb|
%           =                                               +           
% acel_x'      |-kx/mx     0     -bx/mx        0|  |vel_x|     |kx/mx  bx/mx    0        0| |vel_xb|
%              |                                |  |     |     |                          | |     |
% acel_y'      |0        -ky/my      0    -by/my|  |vel_y|     |0        0    ky/my  by/my| |vel_yb|    
    

A = [0 0 1 0;0 0 0 1;-kx/mx 0 -bx/mx 0;0 -ky/my 0 -by/my];
B = [0 0 0 0;0 0 0 0;kx/mx 0 bx/mx 0;0 ky/my 0 by/my];
    
x = [des_x;des_y;vel_x;vel_y];
u = [des_xb;des_yb;vel_xb;vel_yb];

%dx = [vel_x;vel_y;accel_x;accel_y];
F = A*x+B*u;

% Runge-Kutta
%x(t)
%xdot = f(t,x)
%function f(t,x,u)
%A = [0 0 1 0;0 0 0 1;-kx/mx 0 -bx/mx 0;0 -ky/my 0 -by/my];
%B = [0 0 0 0;0 0 0 0;kx/mx 0 bx/mx 0;0 ky/my 0 by/my];
%x = [des_x;des_y;vel_x;vel_y];
%u = [des_xb;des_yb;vel_xb;vel_yb];
%F = A*x+B*u;
%x+1 = x+dt*F

%x(t0) = x0
dt(i) = t(i+1)-t(i);
k1(i) = f(x(i),t(i),u(i));
k2(i) = f(x(i)+k1(i)*dt(i)/2,t(i+1)/2,u(i));
k3(i) = f(x(i)+k2(i)*dt(i)/2,t(i+1)/2,u(i));
k4(i) = f(x(i)+k3(i)*dt(i),t(i+1),u(i));

avg_dot = (k1(i) + 2*k2(i) + 2*k3(i) + k4(i))/6;
x(i+1) = x(i) + dt(i)*avg_dot;