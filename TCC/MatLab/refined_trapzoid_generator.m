function [dt,des,vel,a,dire] = refined_trapzoid_generator(v_i,v_f,v_d,acc,des_tot,dir)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
v_p = ((v_i^2+v_f^2)/2+acc*des_tot)^0.5;
des = [];
vel = [];
dt = [];
a = [];
dire = [];

if v_p > v_d
    des_i = (v_d^2-v_i^2)/(2*acc);
    des_f = (v_d^2-v_f^2)/(2*acc);
    des_d = des_tot-(des_i+des_f);
    
    % a = v/t; t = v/a
    % v = d/t; t = d/v
    dt_i = (v_d-v_i)/acc;
    dt_d = des_d/v_d;
%     t_d = (des_tot-((v_d^2)-(v_i^2+v_f^2)/2)/acc)/v_d
    dt_f = (v_d-v_f)/acc;
    
    vel_i = v_d-v_i;
    vel_d = 0;
    vel_f = v_f-v_d;
    
    a_i = acc;
    a_d = 0;
    a_f = -acc;
    
    if des_i ~= 0
        dt = [dt,dt_i];
        des = [des,des_i];
        vel = [vel,vel_i];
        a = [a,a_i];
        dire = [dire,dir];
    end
    if des_d ~= 0
        dt = [dt,dt_d];
        des = [des,des_d];
        vel = [vel,vel_d];
        a = [a,a_d];
        dire = [dire,dir];
    end
    if des_f ~= 0
        dt = [dt,dt_f];
        des = [des, des_f];
        vel = [vel,vel_f];
        a = [a,a_f];
        dire = [dire,dir];
    end
else
    des_i = (v_p^2-v_i^2)/(2*acc);
    des_f = (v_p^2-v_f^2)/(2*acc);
    
    dt_i = (v_d-v_i)/acc;
    dt_f = (v_d-v_f)/acc;
    
    vel_i = v_p-v_i;
    vel_f = v_f-v_p;
    
    a_i = acc;
    a_f = -acc;
    
    if des_i ~= 0
        dt = [dt,dt_i];
        des = [des,des_i];
        vel = [vel,vel_i];
        a = [a,a_i];
        dire = [dire,dir];
    end
    if des_f ~= 0
        dt = [dt,dt_f];
        des = [des, des_f];
        vel = [vel,vel_f];
        a = [a,a_f];
        dire = [dire,dir];
    end
end
end