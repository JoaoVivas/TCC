function [c,ceq] = dbi_runge_kutta_x2(x)
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
    
    vel_xb(1) = 0;
    vel_yb(1) = 0;
    acc_xb(1) = 0;
    acc_yb(1) = 0;
    
    %dv = des/dt; da = dv/dt ; 
    %des = vi*t+at^2/2; a = 2*(des/t-vi)/t
    % Vf^2-Vi^2 = 2ades
    
    ceq=[x(1,1) x(2,1) t(1) u_base(1,1) u_base(2,1)];    
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
        
    end
    
    s0_base = [des_x(1);des_y(1);vel_x(1);vel_y(1)];

    [s_base] = runge_kutta(s0_base,u_base,t,@dynamic_model);

    ceq = [ceq (s_base(1,:) - x(1,:)) (s_base(2,:) - x(2,:))];
end