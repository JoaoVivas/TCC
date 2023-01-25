%%

function [ c, ceq ] = double_integrator_points( x )
%%
    global A_model B_model max_acc
%     kx=1000;
%     mx=0.200;
%     bx=10;
%     
%     ky=1000;
%     my=0.200;
%     by=10;
    
%     % No nonlinear inequality constraint needed
%     MaxAccelXb = 1000; % ()
%     MaxAccelYb = 1000; % ()
    %%
 
    % Get the states / inputs out of the vector

    % Constrain initial position and velocity to be zero
            
    %x(1+i) = deslocamento_x_inicial
    %x(1+tamanho+i) = velocidade_x_inicial
    %x(1+i+2*tamanho) = deslocamento_y_inicial
    %x(1+i+3*tamanho) = velocidade_y_inicial
   
    %x(2+i) = deslocamento_x_proximo
    %x(2+tamanho+i) = velocidade_x_proximo
    %x(2+2*tamanho+i) = deslocamento_y_proximo
    %x(2+3*tamanho+i) = velocidade_y_proximo
   
ceq=[x(1,1) x(2,1) x(3,1) x(4,1) x(5,1) x(6,1) x(7,1) x(8,1)];    
%ceq=[x(2) x(2+tamanho) x(2+2*tamanho) x(2+3*tamanho) x(2+4*tamanho) x(2+5*tamanho) x(2+6*tamanho) x(2+7*tamanho)];    
   
%[ceq x(1+tamanho) x(1+2*tamanho) x(1+3*tamanho)  x(1+4*tamanho)];
c=[];
%%
for i = 1 : (length(x(9,:))-1)
    
%     x(1,:) = des_x;
%     x(2,:) = vel_x;
%     x(3,:) = des_x; % des_ux
%     x(4,:) = vel_x; % vel_ux
%     x(5,:) = des_y;
%     x(6,:) = vel_y;
%     x(7,:) = des_y; % des_ux
%     x(8,:) = vel_y; % vel_uy
%     x(9,:) = dt;

    des_x_i = x(1,i);
    vel_x_i = x(2,i);
    des_xb_i = x(3,i);
    vel_xb_i = x(4,i);
    
    des_y_i = x(5,i);
    vel_y_i = x(6,i);
    des_yb_i = x(7,i);
    vel_yb_i = x(8,i);
    
    des_x_n = x(1,i+1);
    vel_x_n = x(2,i+1);
    des_xb_n = x(3,i+1);
    vel_xb_n = x(4,i+1);
    
    des_y_n = x(5,i+1);
    vel_y_n = x(6,i+1);
    des_yb_n = x(7,i+1);
    vel_yb_n = x(8,i+1);
    
    deltaT = x(9,i+1);     
%     des_x_i = x(1+i);
%     vel_x_i = x(1+i+Np);
%     des_xb_i = x(1+i+2*Np);
%     vel_xb_i = x(1+i+3*Np);
%     
%     des_y_i = x(1+i+4*Np);
%     vel_y_i = x(1+i+5*Np);
%     des_yb_i = x(1+i+6*Np);
%     vel_yb_i = x(1+i+7*Np);
%    
%     des_x_n = x(2+i);
%     vel_x_n = x(2+i+Np);
%     des_xb_n = x(2+i+2*Np);
%     vel_xb_n = x(2+i+3*Np);
%     
%     des_y_n = x(2+i+4*Np);
%     vel_y_n = x(2+i+5*Np);
%     des_yb_n = x(2+i+6*Np);
%     vel_yb_n = x(2+i+7*Np);
%     
%     deltaT = x(2+i+8*Np)*x(1);
%     
    AccelXb = abs((vel_xb_n-vel_xb_i)/deltaT);
    AccelYb = abs((vel_yb_n-vel_yb_i)/deltaT);
    
    c = [c max_acc-AccelXb max_acc-AccelYb];
%     A = [0 1 0 0;-kx/mx -bx/mx 0 0;0 0 0 1;0 0 -ky/my -by/my];
%     B = [0 0 0 0;kx/mx bx/mx 0 0;0 0 0 0;0 0 ky/my by/my];
    
    x_i = [des_x_i;vel_x_i;des_y_i;vel_y_i];
    u_i = [des_xb_i;vel_xb_i;des_yb_i;vel_yb_i];
    
    f_i = A_model*x_i+B_model*u_i;
    
    x_n = [des_x_n;vel_x_n;des_y_n;vel_y_n];
    u_n = [des_xb_n;vel_xb_n;des_yb_n;vel_yb_n];
    
    f_n = A_model*x_n+B_model*u_n;
        
    
    % vel_x'       |0          1         0         0|  |des_x|     |0         0     0        0| |des_xb|
    %              |                                |  |     |     |                          | |      |
    % acel_x'      |-kx/mx  -bx/mx       0         0|  |vel_x|     |kx/mx  bx/mx    0        0| |vel_xb|
    %           =                                               +           
    % vel_y'       |0          0         0         1|  |des_y|     |0        0      0        0| |des_yb|
    %              |                                |  |     |     |                          | |     |
    % acel_y'      |0          0      -ky/my  -by/my|  |vel_y|     |0        0    ky/my  by/my| |vel_yb|
      
    % What the state should be at the start of the next time interval

    %x_ia = [des_x_i vel_x_i];
    %x_na = [des_x_n vel_x_n];
        
    %xc3=(x_i(3)+x_n(3))/2;
    %xc4=(x_i(4)+x_n(4))/2;
    % The time derivative of the state at the beginning of the time
    % interval

    %delta1=-k/m*des_x_i-b/m*vel_x_i+k/m*des_y_i+b/m*vel_y_i;        
       
    % The time derivative of the state at the end of the time interval
    
    %delta2=-k/m*des_x_n-b/m*vel_x_n+k/m*des_y_n+b/m*vel_y_n;
        
    x_c =(x_i+x_n)/2+deltaT*(f_i-f_n)/8;
    u_c = (u_i+u_n)/2;
    
    x_ca=-3*(x_i-x_n)/(2*deltaT)-(f_i+f_n)/4;
    
    f_c = A_model*x_c+B_model*u_c;
 %%
    
    delta = f_c-x_ca;
    
    %delta(1)=xc(2);
    %delta(2)=-k/m*xc(1)-b/m*xc(2)+k/m*xc3+b/m*xc4;

    % The end state of the time interval calculated using quadrature
    % xend = x_i + delta_time * (xdot_i + xdot_n) / 2;
    % Constrain the end state of the current time interval to be
    % equal to the starting state of the next time interval
    ceq=[ceq delta'];
end
% dtsum = Temptot - sum(x(2+8*Np:9*Np+1));
%ceq=[ceq x(1+2*Np) x(1+4*Np) x(1+6*Np) x(1+8*Np) dtsum]
% ceq=[ceq dtsum];

c = c;
ceq = ceq;

end