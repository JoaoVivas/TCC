function [c,ceq] = dbi_runge_kutta_x2(x)
    global A_model B_model max_acc
    global u_base t_base

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
    
    ceq=[des_x(1) des_y(1) t(1) des_xb(1) des_yb(1)];   
    c=[];
    
    for i = 1 : (length(t)-1)
        dt = t(i+1)-t(i);

        [vel_x(i+1),vel_y(i+1),acc_x(i+1),acc_y(i+1)] = dot_const_acc(...
            des_x(i), des_y(i), des_x(i+1), des_y(i+1), vel_x(i), vel_y(i), dt)

        [vel_xb(i+1),vel_yb(i+1),acc_xb(i+1),acc_yb(i+1)] = dot_const_acc(...
            des_xb(i), des_yb(i), des_xb(i+1), des_yb(i+1), vel_xb(i), vel_yb(i), dt)
        
        % c = [c max_acc-acc_xb(i) max_acc-acc_yb(i)];
    end
    
    s0_base = [des_x(1);des_y(1);vel_x(1);vel_y(1)];

    [s_base] = runge_kutta(s0_base,u_base,t,@dynamic_model);

    ceq = [ceq (s_base(1,:) - x(1,:)) (s_base(2,:) - x(2,:))];
end