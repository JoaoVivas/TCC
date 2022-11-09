%%
test
s0 = [x(1);y(1);vx(1);vy(1)];
s(:,1) = s0;
u(1,:) = x;
u(2,:) = y;
u(3,:) = vx;
u(4,:) = vy;

N = length(t)-1;
for i=1:N
    dt(i) = t(i+1)-t(i);
    uhalf = u_t_interpolator(u(:,i),u(:,i+1),dt(i),dt(i)/2);
    
    k1(:,i) = dynamic_model(s(:,i),u(:,i));
    k2(:,i) = dynamic_model(s(:,i)+k1(i)*dt(i)/2,uhalf);
    k3(:,i) = dynamic_model(s(:,i)+k2(i)*dt(i)/2,uhalf);
    k4(:,i) = dynamic_model(s(:,i)+k3(i)*dt(i),u(:,i+1));

    avg_dot = (k1(:,i) + 2*k2(:,i) + 2*k3(:,i) + k4(:,i))/6;
    s(:,i+1) = s(:,i) + dt(i)*avg_dot;
end

plot(u(1,:),u(2,:))
hold on
plot(s(1,:),s(2,:))