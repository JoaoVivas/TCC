function [vel_x_n, vel_y_n, acc_x_n, acc_y_n] = dot_const_acc(des_x_i, des_y_i, des_x_n, des_y_n, vel_x_i, vel_y_i, dt)
    %UNTITLED5 Summary of this function goes here
    %   Detailed explanation goes here
    delta_x = (des_x_n-des_x_i);
    delta_y = (des_y_n-des_y_i);
    
    acc_x_n = 2*((delta_x/dt)-vel_x_i)/dt;
    acc_y_n = 2*((delta_y/dt)-vel_y_i)/dt;
    
    % vel_x_i
    % vel_y_i
    
    vel_x_n = vel_x_i+acc_x_n*dt;
    vel_y_n = vel_y_i+acc_y_n*dt;
end