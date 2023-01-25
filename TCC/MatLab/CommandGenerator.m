function [des,vel,acc,dir,dt] = CommandGenerator(gcode_x,gcode_y,gcode_v)
global jun_disv max_acc dt_step_size
[gcode_des,gcode_dir] = directionator(gcode_x',gcode_y');

vector_v = [0];
input_vel = [];
input_des = [];
input_dt = [];
input_acc = [];
input_dir = [];

vel = [];
des = [];
dt = [];
acc = [];
dir = [];

for i=1:(size(gcode_v,2)-1)
    vector_v(i+1) = junction_speed_calc(gcode_dir(:,i),gcode_dir(:,i+1),gcode_v(i+1),jun_disv,max_acc);
    [vec_t,vec_des,vec_v,vec_a,vec_dir] = refined_trapzoid_generator(vector_v(i),vector_v(i+1),gcode_v(i),max_acc,gcode_des(i),gcode_dir(:,i));
    input_dt = [input_dt,vec_t];
    input_des = [input_des,vec_des];
    input_vel = [input_vel,vec_v];
    input_acc = [input_acc,vec_a];
    input_dir = [input_dir,vec_dir];
end
input_vi = [0,acumulator(input_vel,0)];
for i = 1:length(input_dt)
    Nsteps = ceil(input_dt(i)/dt_step_size)-1;
    if Nsteps > 0 
        dt_interpol = [ones(1,Nsteps)*dt_step_size,input_dt(i)-dt_step_size*Nsteps];
        dt = [dt, dt_interpol];
        [des_interpol, vel_interpol, acc_interpol, dir_interpol] = t_array_interpolator(dt_interpol, input_acc(i), input_dir(:,i), input_vi(i));
        acc = [acc, acc_interpol];
        vel = [vel, vel_interpol];
        des = [des, des_interpol];
        dir = [dir, dir_interpol];
    else
        dt = [dt,input_dt(i)];
        acc = [acc, input_acc(i)];
        vel = [vel, input_vel(i)];
        des = [des, input_des(i)];
        dir = [dir, input_dir(:,i)];
    end
end
end