%%
clear all
close all
clc

acc_max = 1000;
jun_disv = 0.1;
step_size = 0.1;

[filename,PathName] = uigetfile('*.gcode','Select the G-CODE file');
CommandArray = InputGcode(filename,PathName);

g_x = [0,CommandArray(1,:)];
g_y = [0,CommandArray(2,:)];

[g_des_tot,g_dir] = directionator(g_x',g_y');
g_v_d = [CommandArray(5,:)./60,0];
%p_vx(1) = 0;
%p_vy(1) = 0;
g_v = [0];
b_v = [0];
b_des = [];
b_dt = [];
b_a = [];
b_dir = [];
for i=1:(size(g_v_d,2)-1)
    g_v(i+1) = junction_speed_calc(g_dir(:,i),g_dir(:,i+1),g_v_d(i+1),jun_disv,acc_max);
    %p_vx(i+1) = p_v(i+1)*dir(1,i);
    %p_vy(i+1) = p_v(i+1)*dir(2,i);
    [vec_t,vec_des,vec_v,vec_a,vec_dir] = refined_trapzoid_generator(g_v(i),g_v(i+1),g_v_d(i),acc_max,g_des_tot(i),g_dir(:,i));
    b_dt = [b_dt,vec_t];
    b_des = [b_des,vec_des];
    b_v = [b_v,vec_v];
    b_a = [b_a,vec_a];
    b_dir = [b_dir,vec_dir];
end
%b_a(size(b_dt,2)) = 0;
%b_dir(1,size(b_dt,2)) = 0;
%b_dir(2,size(b_dt,2)) = 0;

% step_size = 1;
% Des = V*delta_t
% Vf^2 = Vi^2 + 2*acc*Des
% Des = Vi*delta_t+ acc*delta_t^2/2
%    delta_t = (v_d-v_f)/acc;

v = [];
ddes = [];
dtt = [];
a = [];
dir = [];

for i=1:size(b_dt,2)
    the_v = [];
    the_des = [];
    the_a = [];
    the_delta_t = [];
    the_vi = [];
    the_dir = [];
    
    desi = b_des(i);   
    vi = b_v(i);
    acc = b_a(i);
    
    Nsteps = round(desi/step_size)-1;
    if acc == 0
        if Nsteps > 0
            the_v = ones(1,Nsteps)*vi;
            delta_t = step_size/vi;
            the_delta_t = ones(1,Nsteps)*delta_t;
            the_des = ones(1,Nsteps)*step_size;
            last_des = desi-step_size*Nsteps;
            last_delta_t = last_des/vi;
            last_vi = vi;
            the_des = [the_des, last_des];
            the_delta_t = [the_delta_t, last_delta_t];
            the_v = [the_v, last_vi];
            the_a = ones(1,Nsteps+1)*acc; 
            the_dir = [b_dir(:,i)*ones(1,Nsteps),b_dir(:,i)];
        else
            the_des = desi;
            the_v = vi;
            the_delta_t = desi/vi;
            the_a = acc;
            the_dir = b_dir(:,i);
        end
    else
        if Nsteps > 0
            the_des = ones(1,Nsteps)*step_size;
            for j=1:Nsteps
                the_v(j) = (vi^2 + 2*acc*step_size*j).^0.5;       
            end
            the_vi = [vi,the_v(1:length(the_v)-1)];
            the_delta_t = (the_v-the_vi)/acc;
            last_des = desi-step_size*Nsteps;
            antlast_v = the_v(length(the_v));
            if antlast_v^2+2*acc*last_des <= 0
                last_v = 0;
            else
                last_v = (antlast_v^2+2*acc*last_des).^0.5;
            end
            last_delta_t = (last_v-antlast_v)/acc;
            the_des = [the_des,last_des];
            the_delta_t = [the_delta_t, last_delta_t];
            the_v = [the_v, last_v];
            the_a = ones(1,Nsteps+1)*acc; 
            the_dir = [b_dir(:,i)*ones(1,Nsteps),b_dir(:,i)];
        else
            the_des = desi;
            the_v = (vi^2+2*acc*desi).^0.5;
            the_delta_t = (the_v-vi)/acc;
            the_a = acc;
            the_dir = b_dir(:,i);
        end
        
    end
    v = [v, the_v];
    ddes = [ddes, the_des];
    dtt = [dtt, the_delta_t];
    a = [a, the_a];
    dir = [dir, the_dir];
end
dx = [0];
dy = [0];
vx = [0];
vy = [0];
ax = [];
ay = [];

for i=1:length(ddes)
   dx = [dx,ddes(i)*dir(1,i)];
   dy = [dy,ddes(i)*dir(2,i)];
   vx = [vx,v(i)*dir(1,i)];
   vy = [vy,v(i)*dir(2,i)];
   ax = [ax,a(i)*dir(1,i)];
   ay = [ay,a(i)*dir(2,i)];
end
a = [a,0];
ax = [ax,0];
ay = [ay,0];
v = [0,v];
t = [0,acumulator(dtt)];
dtt = [dtt,0];
des = acumulator(ddes);
x = acumulator(dx);
y = acumulator(dy);

points(1,:) = x;
points(2,:) = vx;
points(3,:) = y;
points(4,:) = vy;
points(5,:) = dtt;
points(6,:) = t;