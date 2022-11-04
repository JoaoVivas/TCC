function [ v_f ] = junction_speed_calc(dir_1,dir_2,v2,jun_disv,acc_max)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
alpha = 2*asin(norm(dir_1+dir_2)/2);

div = ((1-sin(alpha/2))/sin(alpha/2));
R = jun_disv/div;

v_jun = (acc_max*R)^0.5;

if v2<=v_jun
    v_f=v2;
    else
    v_f=v_jun;
end
end

