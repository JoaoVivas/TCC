function [c,ceq] = dbi_hargraves_x2_base(x)
    global max_acc
    global u_base t_base
    
    t = t_base;
    
    des_x = u_base(1,:);
    des_y = u_base(2,:);
    
    vel_x = u_base(3,:);
    vel_y = u_base(4,:);
    
    % vel_x(1) = 0;
    % vel_y(1) = 0;
    acc_x(1) = 0;
    acc_y(1) = 0;
    
    des_xb = x(1,:);
    des_yb = x(2,:);
    
    vel_xb(1) = 0;
    vel_yb(1) = 0;
    acc_xb(1) = 0;
    acc_yb(1) = 0;
    
    ceq=[des_x(1) des_y(1) t(1) des_xb(1) des_yb(1)];    
    c=[];
    
    for i = 1 : (length(t)-1)
        dt = t(i+1)-t(i);
        
        % [vel_x(i+1),vel_y(i+1),acc_x(i+1),acc_y(i+1)] = dot_const_acc(...
        %     des_x(i), des_y(i), des_x(i+1), des_y(i+1), vel_x(i), vel_y(i), dt);
    
        [vel_xb(i+1),vel_yb(i+1),acc_xb(i+1),acc_yb(i+1)] = dot_const_acc(...
            des_xb(i), des_yb(i), des_xb(i+1), des_yb(i+1), vel_xb(i), vel_yb(i), dt);
        
        % c = [c max_acc-acc_xb(i) max_acc-acc_yb(i)];

        x_i = [des_x(i);des_y(i);vel_x(i);vel_y(i)];
        u_i = [des_xb(i);des_yb(i);vel_xb(i);vel_yb(i)];
        
        x_n = [des_x(i+1);des_y(i+1);vel_x(i+1);vel_y(i+1)];
        u_n = [des_xb(i+1);des_yb(i+1);vel_xb(i+1);vel_yb(i+1)];
        
        delta = hargraves(x_i,u_i,x_n,u_n,dt,@dynamic_model);

        ceq=[ceq delta'];
    end
    ceq;
end