%% 
clc;
clear;
    % vel_x'       |0          1         0         0|  |des_x|     |0         0     0        0| |des_xb|
    %              |                                |  |     |     |                          | |      |
    % acel_x'      |-kx/mx  -bx/mx       0         0|  |vel_x|     |kx/mx  bx/mx    0        0| |vel_xb|
    %           =                                               +           
    % vel_y'       |0          0         0         1|  |des_y|     |0        0      0        0| |des_yb|
    %              |                                |  |     |     |                          | |     |
    % acel_y'      |0          0      -ky/my  -by/my|  |vel_y|     |0        0    ky/my  by/my| |vel_yb|
    
    % input variables -> [x dx d2x] [y dy d2y] 
    % system variables -> [AX] [Ay] [Bx] [By]
    
    
    
time = 0:1:4;

uv = [];

IC = [0;0;0;0];

%solver_options = odeset('RelTol',1e-5,'AbsTol',1e-5);

[t,y] = ode45(@(t,y) odes(t,y,u,time),time,IC);

y(:,1)
figure

plot(y(:,1),y(:,3))
figure
plot(u(:,1),u(:,3))
