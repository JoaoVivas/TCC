function [s] = runge_kutta(s0,u,t,dynamic_model)
    global A_model B_model
    s(:,1) = s0;
%     u(1,:) = x;
%     u(2,:) = y;
%     u(3,:) = vx;
%     u(4,:) = vy;
    
    A = A_model;
    B = B_model;
    N = length(t)-1;
    for i=1:N
        dt(i) = t(i+1)-t(i);
        uhalf = u_t_interpolator(u(:,i),u(:,i+1),dt(i),dt(i)/2);

        k1(:,i) = dynamic_model(s(:,i),u(:,i),A,B);
        k2(:,i) = dynamic_model(s(:,i)+k1(i)*dt(i)/2,uhalf,A,B);
        k3(:,i) = dynamic_model(s(:,i)+k2(i)*dt(i)/2,uhalf,A,B);
        k4(:,i) = dynamic_model(s(:,i)+k3(i)*dt(i),u(:,i+1),A,B);

        avg_dot = (k1(:,i) + 2*k2(:,i) + 2*k3(:,i) + k4(:,i))/6;
        s(:,i+1) = s(:,i) + dt(i)*avg_dot;
    end
end