function [des_interpol, vel_interpol, acc_interpol, dir_interpol] = t_array_interpolator(dt_interpol,input_acc,input_dir, input_vi)
% initial des(i), vel(i), dt -> [step,step,...,rest] 
% acc = dv/dt; v = des/dt;
% dv = acc*dt
des_interpol = [];

vel_interpol = dt_interpol*input_acc;
vel_i = [input_vi,acumulator(vel_interpol,input_vi)];
acc_interpol = ones(1,length(dt_interpol))*input_acc;
dir_interpol = input_dir*ones(1,length(dt_interpol));

for i = 1:length(dt_interpol)
   eq = vel_i(i)*dt_interpol(i)+ input_acc*dt_interpol(i)^2/2;
   des_interpol = [des_interpol,eq]; 
end
end