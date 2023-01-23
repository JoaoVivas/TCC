%% 
if exist('run','var') == 1
    a_config
end
%% Input Gcode from Gcode file
 
% [filename,PathName] = uigetfile('*.gcode','Select the G-CODE file');
filename = 'Gcode_teste.gcode';
PathName = 'C:\Users\JoaoVivas\JoaoVivas\TCC\MatLab\';
CommandArray = InputGcode(filename,PathName);

%Command Generation

gcode_x = [0,CommandArray(1,:)];
gcode_y = [0,CommandArray(2,:)];
gcode_v = [CommandArray(5,:)./60,0];

[x,y,vx,vy,t] = CommandGenerator(gcode_x,gcode_y,gcode_v);

%% Fmincon Otimizer

x(1,:) = des_x;
x(2,:) = vel_x;
x(3,:) = des_x; % des_ux
x(4,:) = vel_x; % vel_ux
x(5,:) = des_y;
x(6,:) = vel_y;
x(7,:) = des_y; % des_ux
x(8,:) = vel_y; % vel_uy
x(9,:) = t;

optimal = [];
[lb,ub] = def_bounds(x);
[A_eq,b_eq,A_ineq,b_ineq] = lcon(optimal);

if isempty(optimal)
         optimal=x;
end

optimal = fmincon(objective_fun, optimal, A_ineq, b_ineq,...
                      A_eq, b_eq, lb, ub, nonlcon, options);

%% Input Shaper

%% Dynamic Simulation
[s,u] = runge_kutta(s0,u,t,dynamic_model);


s0 = [x(1);y(1);vx(1);vy(1)];
s(:,1) = s0;
u(1,:) = x;
u(2,:) = y;
u(3,:) = vx;
u(4,:) = vy;

N = length(t)-1;
for i=1:N
    dt(i) = t(i+1)-t(i);
    uhalf = u_t_interpolator(u(:,i),u(:,i+1),dt(i),dt(i)/2);
    
    k1(:,i) = dynamic_model(s(:,i),u(:,i));
    k2(:,i) = dynamic_model(s(:,i)+k1(i)*dt(i)/2,uhalf);
    k3(:,i) = dynamic_model(s(:,i)+k2(i)*dt(i)/2,uhalf);
    k4(:,i) = dynamic_model(s(:,i)+k3(i)*dt(i),u(:,i+1));

    avg_dot = (k1(:,i) + 2*k2(:,i) + 2*k3(:,i) + k4(:,i))/6;
    s(:,i+1) = s(:,i) + dt(i)*avg_dot;
end
%% Graphical Results


plot(u(1,:),u(2,:))
hold on
plot(s(1,:),s(2,:))
