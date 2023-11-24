% -------------------------------- Input Gcode from Gcode file --------------------------------
% [filename,PathName] = uigetfile('*.gcode','Select the G-CODE file');
% 
% CommandArray = InputGcode(filename,PathName);

% ------------------------------------ Command Generation -------------------------------------
global t_base s_base u_base
% gcode_x = [0,CommandArray(1,:)]
% gcode_y = [0,CommandArray(2,:)]
% gcode_v = [CommandArray(5,:)./60,0]

[des,vel,acc,dir,dt] = CommandGenerator(gcode_x,gcode_y,gcode_v);

t_base = [0,acumulator(dt,0)];

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

u_base(1,:) = des_x;
u_base(2,:) = des_y;
u_base(3,:) = vel_x;
u_base(4,:) = vel_y;