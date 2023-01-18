function xdot = dynamic_model(x, u, A, B)
%x = [des_x;des_y;vel_x;vel_y];
%u = [des_xb;des_yb;vel_xb;vel_yb];
%dx = [vel_x;vel_y;accel_x;accel_y];
xdot = (A*x)+(B*u);
