%% 
clc;
clear all;
close all;
% vel_x'       |0          0         1         0|  |des_x|     |0         0     0        0| |des_xb|
%              |                                |  |     |     |                          | |      |
% vel_y'       |0          0         0         1|  |des_y|     |0        0      0        0| |des_yb|
%           =                                               +           
% acel_x'      |-kx/mx     0     -bx/mx        0|  |vel_x|     |kx/mx  bx/mx    0        0| |vel_xb|
%              |                                |  |     |     |                          | |     |
% acel_y'      |0        -ky/my      0    -by/my|  |vel_y|     |0        0    ky/my  by/my| |vel_yb|    
    
 U = [0 1 2 3 4;1 1 1 1 1;0 1 2 3 4;1 1 1 1 1];

kx=1000;
mx=0.200;
bx=10;

ky=1000;
my=0.200;
by=10;  

syms t des_x vel_x accel_x des_y vel_y accel_y
syms des_xb vel_xb accel_xb des_yb vel_yb accel_yb
%des_x =;
%vel_x =;
%des_y = ;
%vel_y = ;

%des_xb = ; 
%vel_xb = ;
%des_yb = ; 
%vel_yb = ;    
   
A = [0 0 1 0;0 0 0 1;-kx/mx 0 -bx/mx 0;0 -ky/my 0 -by/my];
B = [0 0 0 0;0 0 0 0;kx/mx 0 bx/mx 0;0 ky/my 0 by/my];
    
x = [des_x;des_y;vel_x;vel_y];
u = [des_xb;des_yb;vel_xb;vel_yb];

dx = [vel_x;vel_y;accel_x;accel_y];
F = A*x+B*u
dF = A*x+B*u-dx

q = u;
S = [des_x;des_y;vel_x;vel_y;accel_x;accel_y]                           % vetor de variáveis secundárias
J=jacobian(F,S)                            % matriz jacobiana


%% Chute inicial
s = U(:,1);

% Parâmetros de simulação
eps1=10^-4;          % tolerância de erro para as ordenadas (dy=y2-y1)
eps2=10^-4;          % tolerância de erro para as abscissas (dx=x2-x1)
N=50;                % número máximo de iterações 
S0=eval(s);          % avaliação numérica do vetor de variáveis secundárias

t_i=0;               % Tempo inicial
t_f=4;               % Tempo final
dt=1;             % incremento de integração
t=[t_i:dt:t_f].'     % tempo de simulação

for j=1:length(t)
    str=['Iteração ',num2str(j),' de ',num2str(length(t))]; disp(str);
    u=U(:,j);
        for i=1:N
            S1=S0-eval(J)\eval(F);
            teta2=S1(1);
                if norm(S1-S0)<=eps2         % tolerância em dx
%                     fprintf('Atingiu a tolerância de erro em dx com %0.0f iterações.\n', i)
                        break
                elseif norm(eval(F))<=eps1   % tolerância em dy             
%                     fprintf('Atingiu a tolerância de erro em dy com %0.0f iterações.\n', i)
                        break                    
                end
            S0=S1;
        end
Teta2(j,1)=teta2;
clc;
end

