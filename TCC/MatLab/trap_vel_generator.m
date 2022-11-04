function [trap_points] = trap_vel_generator(gcode_points, acc_config)

x = gcode_points(1);
y = gcode_points(2);
f = gcode_points(3);

acc = acc_config
%%
vd = 30; %mm/s
acc_max = 3000; %mm/s^2
jun_disv = 0.1; %mm
% junction speed calculation
vi = 0;

v1 = [30;0];
v2 = [30;1];
v1_mod = norm(v1);
v2_mod = norm(v2);
v1_dir = v1/v1_mod;
v2_dir = v2/v2_mod;

alpha = 2*asin(norm(v1_dir+v2_dir)/2);
alpha_deg = alpha*180/pi

%alpha_rad = alpha_deg*pi/180;
%alpha = alpha_rad;
div = ((1-sin(alpha/2))/sin(alpha/2));
R = jun_disv/div;

v_jun = (acc_max*R)^0.5;

%%equations
% trap has 3 time frames
% t1 -> velocity rise
% t2 -> velocity cte
% t3 -> velocity fall

if v2_mod<=v_jun
    v_f=v2_mod;
    else
    v_f=v_jun;
end
%xf-xi = vi*t + acc*t^2/2
%xi-xf = vf*t - acc*t^2/2

%vp^2 = vi^2 + 2*acc*deltax1
%vp^2 = vf^2 + 2*acc*deltax2
%deltaxtot = deltax1+deltax2
%2*vp^2 = vi^2+vf^2+2*acc*(deltax1+deltax2)
%2*vp^2 = vi^2+vf^2+2*acc*deltaxtot
%%
clc
clear all
t_step = 0.1;
deltaxtot = ;
acc = 1;
vi = 0;
vf = 0;
vd = 1;
vp = ((vi^2+vf^2)/2+acc*deltaxtot)^0.5;
%vd^2 = vi^2 + 2*acc*deltax1
% deltax2 = vd/t2
%vd^2 = vf^2 + 2*acc*deltax3

%deltaxtot = deltax1+deltax2+deltax3

% t2 = vd/deltax2
%deltax2 = deltaxtot-(deltax1+deltax3)
% t2 = vd/(deltaxtot-(deltax1+deltax3)
% deltax1 = (vd^2-vi^2)/(2*acc)
% deltax3 = (vd^2-vf^2)/(2*acc)
% deltax1+deltax3 = (2*vd^2-(vi^2+vf^2))/(2*acc)
if vp > vd
    ti = (vd-vi)/acc;
    td = vd/(deltaxtot-((vd^2)-(vi^2+vf^2)/2)/acc);
    tf = (vd-vf)/acc;
    
    t_t = [0;ti;ti+td;ti+td+tf];
    v_t = [vi;vd;vd;vf];
    
    t1 = 0:t_step:ti;
    t2 = 0:t_step:td;
    t3 = 0:t_step:tf;
    
    v1 = vi+acc*t1;
    v2 = vd*(t2.^0);
    v3 = vd-acc*t3;
    
    t2 = t2+ti;
    t3 = t3+(ti+td);
    v = cat(2,v1,v2,v3);
    t = cat(2,t1,t2,t3);

else
    ti = (vp-vi)/acc;
    tf = (vp-vf)/acc;
    
    t_t = [0;ti;ti+tf];
    v_t = [vi;vp;vf];
    
    t1 = 0:t_step:ti;
    t3 = 0:t_step:tf;
    
    v1 = vi+acc*t1;
    v3 = vp-acc*t3;
    
    t3 = t3+ti;
    v = cat(2,v1,v3);
    t = cat(2,t1,t3);
end
% if desired velocity reach

% if acc caped


%vp^2 = vi^2 + 2*acc*deltax1
%deltax1 = (vp^2-vi^2)/(2*acc);
%deltax2 = deltaxtot-deltax1;


%deltax1 = (vd^2-vi^2)/(2*acc);
%deltax2 = vd*t;
%deltax3 = (vf^2-vd^2)/(2*acc);
%des_tot = deltax1+deltax2+deltax3

%deltax2 = des_tot-(deltax1+deltax3)


xi = 0;
x(1) = xi;
for i=1:(size(t')-1)
    dt = t(i+1)-t(i);
    x(i+1) = x(i) + v(i)*dt;
    a(i) = (v(i+1)-v(i))/dt;
end

xi_t = 0;
x_t(1) = xi_t;
size(t_t)
for i=1:(size(t_t)-1)
    dt_t = t_t(i+1)-t_t(i);
    x_t(i+1) = x_t(i) + v_t(i)*dt_t;
    a_t(i) = (v_t(i+1)-v_t(i))/dt_t;
end

a(size(t',1)) = 0;
%plot(t,v)
plot(t_t,x_t)
figure
plot(t_t,v_t)
%figure
%plot(t,x)
%figure
%plot(t,a)



%%
trap_points = [];
end
