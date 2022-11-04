function [des] = des_mesh(des_i,des_f,step_size)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
Des_t = des_f-des_i;
Nsteps = round(Des_t/step_size)-1;
des = zeros(size(Nsteps,1),1);
    if Nsteps > 0
        for i=1:Nsteps
            des(i) = (des_i+i*step_size);
        end
    end
    des(Nsteps+1) = des_f;
end

