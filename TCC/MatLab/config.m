% config

% Sistema Dinâmico

global A = [];
global B = [];

% Gerador de Comandos
global junction_speed = ;
acc_max = 1000;
jun_disv = 0.1;
des_step_size = 0.1;
t_step_size = ;

% Otimização
desvio_min = @(x) (x(2:Np+1) - deslocamento_xb_entrada)*(x(2:Np+1) - deslocamento_xb_entrada)'+(x(2+4*Np:5*Np+1) - deslocamento_yb_entrada)*(x(2 + 4*Np:5*Np+1) - deslocamento_yb_entrada)';

nonlcon=@double_integrator_points;

x_ub = ;
vx_ub = ;
x_lb = ;
vx_lb = ;

y_ub = ;
vy_ub = ;
y_lb = ;
vy_lb = ;

% Input Shaper


% Simulation

% Grafics