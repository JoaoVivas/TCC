function [c,ceq] = dbi_hargraves_x2(x)
    %%
    % clc
    % clear all
    % %%
    global A_model B_model max_acc
    global u_base t_base
    
    % x(1,:) = [0,1,2,3,4,5];
    % x(2,:) = [0,1,2,3,4,5];
    % x(3,:) = [0,1,2,3,4,5]; 
    % x(4,:) = [0,1,2,3,4,5]; 
    % x(5,:) = [0,2,3,4,5,6];
    
    t = t_base;
    
    des_x = x(1,:);
    des_y = x(2,:);
    
    vel_x(1) = 0;
    vel_y(1) = 0;
    acc_x(1) = 0;
    acc_y(1) = 0;
    
    des_xb = u_base(1,:);
    des_yb = u_base(2,:);
    vel_xb = u_base(3,:);
    vel_yb = u_base(4,:);
    
    vel_xb(1) = 0;
    vel_yb(1) = 0;
    acc_xb(1) = 0;
    acc_yb(1) = 0;
    
    %dv = des/dt; da = dv/dt ; 
    %des = vi*t+at^2/2; a = 2*(des/t-vi)/t
    % Vf^2-Vi^2 = 2ades
    
    ceq=[des_x(1) des_y(1) t(1) des_xb(1) des_yb(1)];    
    c=[];
    %t=[t t(length(t))];
    %des_x=[des_x des_x(length(des_x))];
    
    %des_y=[des_y des_y(length(des_y))];
    
    
    %des_xb=[des_xb des_xb(length(des_xb))];
    
    %=[des_yb des_yb(length(des_yb))];
    
    for i = 1 : (length(t)-1)
        dt = t(i+1)-t(i);
        
        delta_x = (des_x(i+1)-des_x(i));
        delta_y = (des_y(i+1)-des_y(i));
        
        acc_x(i+1) = 2*((delta_x/dt)-vel_x(i))/dt; 
        acc_y(i+1) = 2*((delta_y/dt)-vel_y(i))/dt;
        vel_x(i+1) = vel_x(i)+acc_x(i+1)*dt;
        vel_y(i+1) = vel_y(i)+acc_y(i+1)*dt;
    
        % delta_xb = (des_xb(i+1)-des_xb(i));
        % delta_yb = (des_yb(i+1)-des_yb(i));
        
        % acc_xb(i+1) = 2*((delta_xb/dt)-vel_xb(i))/dt;
        % acc_yb(i+1) = 2*((delta_yb/dt)-vel_yb(i))/dt;
        % vel_xb(i+1) = vel_xb(i)+acc_xb(i+1)*dt;
        % vel_yb(i+1) = vel_yb(i)+acc_yb(i+1)*dt;
    
        %AccelXb = abs((vel_xb(i+1)-vel_xb(i))/dt);
        %AccelYb = abs((vel_yb(i+1)-vel_yb(i))/dt);
             
        % vel_x(i)=(des_x(i+1)-des_x(i))/dt;
        % vel_y(i)=(des_y(i+1)-des_y(i))/dt;
        
        % vel_x(i+1)=(des_x(i+2)-des_x(i+1))/dt;
        % vel_y(i+1)=(des_y(i+2)-des_y(i+1))/dt;
        
        % vel_xb(i)=(des_xb(i+1)-des_xb(i))/dt;
        % vel_yb(i)=(des_yb(i+1)-des_yb(i))/dt;
        
        % vel_xb(i+1)=(des_xb(i+2)-des_xb(i+1))/dt;
        % vel_yb(i+1)=(des_yb(i+2)-des_yb(i+1))/dt;
       
    %     c = [c max_acc-AccelXb max_acc-AccelYb];
        
        x_i = [des_x(i);des_y(i);vel_x(i);vel_y(i)];
        u_i = [des_xb(i);des_yb(i);vel_xb(i);vel_yb(i)];
        
        f_i = A_model*x_i+B_model*u_i;
        
        x_n = [des_x(i+1);des_y(i+1);vel_x(i+1);vel_y(i+1)];
        u_n = [des_xb(i+1);des_yb(i+1);vel_xb(i+1);vel_yb(i+1)];
        
        f_n = A_model*x_n+B_model*u_n;
        
        x_c =(x_i+x_n)/2+dt*(f_i-f_n)/8;
        u_c = (u_i+u_n)/2;
        
        x_ca=-3*(x_i-x_n)/(2*dt)-(f_i+f_n)/4;
        
        f_c = A_model*x_c+B_model*u_c;
        
        delta = f_c-x_ca;
        ceq=[ceq delta'];
    end
    c=[];
    ceq;
    end