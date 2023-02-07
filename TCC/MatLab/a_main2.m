% %% 
% clc;
% clear all;
% close all;
% a_config
% if exist('run','var') == 1
%     a_config
% end
% Input Gcode from Gcode file
% a_config
% [filename,PathName] = uigetfile('*.gcode','Select the G-CODE file');
filename = 'Gcode_teste.gcode';
PathName = '.\';
CommandArray = InputGcode(filename,PathName);

%Command Generation

gcode_x = [0,CommandArray(1,:)];
gcode_y = [0,CommandArray(2,:)];
gcode_v = [CommandArray(5,:)./60,0];

[des,vel,acc,dir,dt] = CommandGenerator(gcode_x,gcode_y,gcode_v);


% t = [0,acumulator(dt,0)];
% des_ac = acumulator(des);
% vel_ac = acumulator(vel);

x_del = (dir(1,:).*des);
y_del = (dir(2,:).*des);
des_x = [0,acumulator(x_del,0)];
des_y = [0,acumulator(y_del,0)];

vx_del = (dir(1,:).*vel);
vy_del = (dir(2,:).*vel);
vel_x = [0,acumulator(vx_del,0)];
vel_y = [0,acumulator(vy_del,0)];

ax = [0,(dir(1,:).*acc)];
ay = [0,(dir(2,:).*acc)];


% acc_ac = [0, acc];
% plot(des_x,des_y)
% figure
% plot(t,vx,t,vy)

% Fmincon Otimizer
% 
% x(1,:) = des_x;
% x(2,:) = vel_x;
% x(3,:) = des_x; % des_ux
% x(4,:) = vel_x; % vel_ux
% x(5,:) = des_y;
% x(6,:) = vel_y;
% x(7,:) = des_y; % des_ux
% x(8,:) = vel_y; % vel_uy
% x(9,:) = [0,dt];
global t_base
t_base = [0,acumulator(dt,0)];

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

plot(u_base(1,:),u_base(3,:))
hold on
plot(s_base(1,:),s_base(3,:))
%%
global x_entr
x_entr = x;

optimal = [];
[lb,ub] = def_bounds(x);
[A_eq,b_eq,A_ineq,b_ineq] = lcon(optimal);

if isempty(optimal)
         optimal=x;
end

optimal = fmincon(objective_fun, optimal, A_ineq, b_ineq,...
                      A_eq, b_eq, lb, ub, nonlcon, options);


% optimal = optimal/1.05;
figure
plot(optimal(1,:),optimal(2,:),optimal(3,:),optimal(4,:))
figure
plot(optimal(5,:),optimal(1,:),optimal(5,:),optimal(2,:))
figure
plot(optimal(5,:),optimal(3,:),optimal(5,:),optimal(4,:))
% plot(optimal(1,:), optimal(5,:), optimal(3,:), optimal(7,:))

%% Input Shaper
% 
% % %% Dynamic Simulation
% [s_base,u_base] = runge_kutta(s0_base,u_base,t_base,@dynamic_model);
% 
% 
% plot(u_base(1,:),u_base(2,:))
% hold on
% plot(s_base(1,:),s_base(2,:))
% 
% 
% s0 = [x(1);y(1);vx(1);vy(1)];
% s(:,1) = s0;
% u(1,:) = x;
% u(2,:) = y;
% u(3,:) = vx;
% u(4,:) = vy;
% 
% N = length(t)-1;
% for i=1:N
%     dt(i) = t(i+1)-t(i);
%     uhalf = u_t_interpolator(u(:,i),u(:,i+1),dt(i),dt(i)/2);
%     
%     k1(:,i) = dynamic_model(s(:,i),u(:,i));
%     k2(:,i) = dynamic_model(s(:,i)+k1(i)*dt(i)/2,uhalf);
%     k3(:,i) = dynamic_model(s(:,i)+k2(i)*dt(i)/2,uhalf);
%     k4(:,i) = dynamic_model(s(:,i)+k3(i)*dt(i),u(:,i+1));
% 
%     avg_dot = (k1(:,i) + 2*k2(:,i) + 2*k3(:,i) + k4(:,i))/6;
%     s(:,i+1) = s(:,i) + dt(i)*avg_dot;
% end
% %% Graphical Results
% 
% 
% plot(u(1,:),u(2,:))
% hold on
% plot(s(1,:),s(2,:))
