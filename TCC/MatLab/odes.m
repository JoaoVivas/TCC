function fn = odes(t,y,u,time)

%x = [des_x;vel_x;des_y;vel_y];
%u = [des_xb;vel_xb;des_yb;vel_yb];
    
% System constants
u
time
t
u = interp1(time,u,t)
u = u.'

mx = 1; my = 1; kx = 1; ky = 1; bx = 1; by = 1;

A = [0 1 0 0;-kx/mx -bx/mx 0 0;0 0 0 1;0 0 -ky/my -by/my]
B = [0 0 0 0;kx/mx bx/mx 0 0;0 0 0 0;0 0 ky/my by/my]

A*y
B*u

fn = A*y+B*u
end

