function [sim_time, vec_size, d_b, d_i, u_b, u_i, p_c, p_n, t_b, t_i] = trajectory_control(gcode_x,gcode_y,gcode_v)
    %% --------------------------------- base trajectory (d) ---------------------------------------------
    global t_base
    [des,vel,acc,dir,dt] = CommandGenerator(gcode_x,gcode_y,gcode_v);

    t_base = [0,acumulator(dt,0)];

    x_del = (dir(1,:).*des);
    y_del = (dir(2,:).*des);
    des_x = [0,acumulator(x_del,0)];
    des_y = [0,acumulator(y_del,0)];

    vx_del = (dir(1,:).*vel);
    vy_del = (dir(2,:).*vel);
    vel_x = [0,acumulator(vx_del,0)];
    vel_y = [0,acumulator(vy_del,0)];

    ax = [0,(dir(1,:).*acc)];
    ay = [0,(dir(2,:).*acc)];

    d_b(1,:) = des_x;
    d_b(2,:) = des_y;
    d_b(3,:) = vel_x;
    d_b(4,:) = vel_y;
   global u_base
   u_base = d_b;
    %% --------------------------------- x Setup ---------------------------------------------
    tic
    
    nonlcon = @dbi_hargraves_x2_base;

    x(1,:) = des_x;
    x(2,:) = des_y;

    global x_entr
    x_entr = x;
    %% ------------------------------------------ Bounds --------------------------------------

    global min_x min_y 
    global max_x max_y

    N = length(x(1,:));
    base = ones(1,N);

    lb(1,:) = base*min_x;
    lb(2,:) = base*min_y;

    ub(1,:) = base*max_x;
    ub(2,:) = base*max_y;
    %% ------------------------------------------ Fmincon routine ------------------------------
    global options lcon objective_fun
    optimal = [];
    [A_eq,b_eq,A_ineq,b_ineq] = lcon(x);
    global ceq_jerk ceq_har ceq_initial
    ceq_jerk =[];
    ceq_har = [];
    ceq_initial = [];

    if isempty(optimal)
             optimal=x;
    end

    optimal = fmincon(objective_fun, optimal, A_ineq, b_ineq,...
                          A_eq, b_eq, lb, ub, nonlcon, options);

    % optimal = optimal/1.05;
    r_t = t_base;

    r_des_xb = optimal(1,:); 
    r_des_yb = optimal(2,:);
    r_vel_xb(1) = 0;
    r_vel_yb(1) = 0;
    r_acc_xb(1) = 0;
    r_acc_yb(1) = 0;

    for i = 1 : (length(r_t)-1)
        dt = r_t(i+1)-r_t(i);

        [r_vel_xb(i+1),r_vel_yb(i+1),r_acc_xb(i+1),r_acc_yb(i+1)] = dot_const_acc(...
            r_des_xb(i), r_des_yb(i), r_des_xb(i+1), r_des_yb(i+1), r_vel_xb(i), r_vel_yb(i), dt);
    end
    
    u_b(1,:) = r_des_xb;
    u_b(2,:) = r_des_yb;
    u_b(3,:) = r_vel_xb;
    u_b(4,:) = r_vel_yb;

    sim_time = toc;
    vec_size = length(t_base);
    t_b = t_base;
    %% --------------------------------- Interpolation ---------------------------------------------
    
    [u_i,t_i] = interpolation_acc_c(u_b,t_base,0.0001);
    [d_i,~] = interpolation_acc_c(d_b,t_base,0.0001);
    
    %% --------------------------------- Trajectory no control ---------------------------------------------

    s0 = [0 0 0 0];
    [p_n] = runge_kutta(s0, d_i, t_i, @dynamic_model);
    
    %% --------------------------------- Trajectory ponta with control ---------------------------------------------
   
    [p_c] = runge_kutta(s0, u_i, t_i, @dynamic_model);
    
end