function [t,des,v,a,dire] = refined_trapzoid_generator(v_i,v_f,v_d,acc,des_tot,dir)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
v_p = ((v_i^2+v_f^2)/2+acc*des_tot)^0.5;
des = [];
v = [];
t = [];
a = [];
dire = [];

if v_p > v_d
    des_i = (v_d^2-v_i^2)/(2*acc);
    des_f = (v_d^2-v_f^2)/(2*acc);
    des_d = des_tot-(des_i+des_f);
    
    t_i = (v_d-v_i)/acc;
    t_d = v_d/(des_tot-((v_d^2)-(v_i^2+v_f^2)/2)/acc);
    t_f = (v_d-v_f)/acc;
    
    a_i = acc;
    a_d = 0;
    a_f = -acc;
    
    if des_i ~= 0
        t = [t,t_i];
        des = [des,des_i];
        v = [v,v_d];
        a = [a,a_i];
        dire = [dire,dir];
    end
    if des_d ~= 0
        t = [t,t_d];
        des = [des,des_d];
        v = [v,v_d];
        a = [a,a_d];
        dire = [dire,dir];
    end
    if des_f ~= 0
        t = [t,t_f];
        des = [des, des_f];
        v = [v,v_f];
        a = [a,a_f];
        dire = [dire,dir];
    end
else
    des_i = (v_p^2-v_i^2)/(2*acc);
    des_f = (v_p^2-v_f^2)/(2*acc);
    
    t_i = (v_d-v_i)/acc;
    t_f = (v_d-v_f)/acc;
    
    a_i = acc;
    a_f = -acc;
    
    if des_i ~= 0
        t = [t,t_i];
        des = [des,des_i];
        v = [v,v_p];
        a = [a,a_i];
        dire = [dire,dir];
    end
    if des_f ~= 0
        t = [t,t_f];
        des = [des, des_f];
        v = [v,v_f];
        a = [a,a_f];
        dire = [dire,dir];
    end
end
end