function objective = desv_min_runge2(x)
    global x_entr t_base

    des_x = x(1,:);
    des_y = x(2,:);
    vel_x(1) = 0;
    vel_y(1) = 0;
    acc_x(1) = 0;
    acc_y(1) = 0;

    for i = 1 : (length(t_base)-1)
        dt = t_base(i+1)-t_base(i);

        delta_x = (des_x(i+1)-des_x(i));
        delta_y = (des_y(i+1)-des_y(i));

        acc_x(i+1) = 2*((delta_x/dt)-vel_x(i))/dt; 
        acc_y(i+1) = 2*((delta_y/dt)-vel_y(i))/dt;
        vel_x(i+1) = vel_x(i)+acc_x(i+1)*dt;
        vel_y(i+1) = vel_y(i)+acc_y(i+1)*dt;
    end
    
    s0_base = [des_x(1);vel_x(1);des_y(1);vel_y(1)];
    u_base(1,:) = des_x;
    u_base(2,:) = vel_x;
    u_base(3,:) = des_y;
    u_base(4,:) = vel_y;

    [s_base,u_base] = runge_kutta2(s0_base,u_base,@dynamic_model);
    objective = (s_base(1,:) - x_entr(1,:))*(s_base(1,:) - x_entr(1,:))'+(s_base(2,:) - x_entr(2,:) )*(s_base(2,:) - x_entr(2,:))';
end