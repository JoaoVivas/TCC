function [u,t] = interpolation_acc_c(u_init,t_init,dt_step_size)
% %%
% clc
% clear all
% 
% dt_step_size = 0.001;
% 
% t_test = [0,0.1,1,2,3,4,5];
% u_test(1,:) = [0,0.005,0.5,1.5,2.5,3.5,4];
% u_test(2,:) = [0,0,0,0,0,0,0];
% u_test(3,:) = [0,0.1,1,1,1,1,0];
% u_test(4,:) = [0,0,0,0,0,0,0];
% 
% t_init = t_test;
% u_init = u_test;

x_init = u_init(1,:);
y_init = u_init(2,:);
v_x_init = u_init(3,:);
v_y_init = u_init(4,:);

dt = [];

des_x = [];
des_y = [];

v_x = [v_x_init(1)];
v_y = [v_y_init(1)];

for i = 1:length(t_init)-1
    input_dt = t_init(i+1)-t_init(i);

    l_vx = v_x_init(i);
    l_vy = v_y_init(i);
    
    a_x = (v_x_init(i+1)-v_x_init(i))/input_dt;
    a_y = (v_y_init(i+1)-v_y_init(i))/input_dt;
    Nsteps = ceil(round(input_dt/dt_step_size, 8))-1;
    if Nsteps > 0 
        dt_interpol = [ones(1,Nsteps)*dt_step_size,input_dt-dt_step_size*Nsteps];
        dt = [dt, dt_interpol];
%         size(dt_interpol)
        
        for j = 1:length(dt_interpol)
           des_interpol_x = l_vx*dt_interpol(j)+ a_x*dt_interpol(j)^2/2;
           des_interpol_y = l_vy*dt_interpol(j)+ a_y*dt_interpol(j)^2/2;
           
           des_x = [des_x, des_interpol_x]; 
           des_y = [des_y, des_interpol_y]; 
           
           l_vx = l_vx + a_x*dt_interpol(j);
           l_vy = l_vy + a_y*dt_interpol(j);
           
           v_x = [v_x, l_vx];
           v_y = [v_y, l_vy];
        end
    else
        dt = [dt,input_dt];
        
        v_x = [v_x, v_x_init(i+1)];
        v_y = [v_y, v_y_init(i+1)];

        des_x = [des_x, x_init(i+1) - x_init(i)];
        des_y = [des_y, y_init(i+1) - y_init(i)];
    end
end

t = [0,acumulator(dt,0)];

x = [0,acumulator(des_x,0)];
y = [0,acumulator(des_y,0)];

u(1,:) = x;
u(2,:) = y;
u(3,:) = v_x;
u(4,:) = v_y;
end