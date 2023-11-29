function [g_code_x,g_code_y,g_code_v] = config_params(omega_n, zeta, acc, step_size, vel_d)
g_code_x = [0    10    10];
g_code_y = [0     0    10];
g_code_v = [1   1     0] * vel_d;

% config
% Sistema Dinamico
% x,u mm mm/s

mx =.200; % Kg
my =.200; % Kg

omega_n_x = omega_n;
omega_n_y = omega_n;

zeta_x = zeta;
zeta_y = zeta;

kx = omega_n_x^2*mx;
ky =  omega_n_y^2*my;

c_cri_x = 2*(mx*kx)^0.5;
c_cri_y = 2*(my*ky)^0.5;

bx = zeta_x*c_cri_x;
by = zeta_x*c_cri_x;

omega_d_x = omega_n_x*(1-zeta_x)^0.5;
omega_d_y = omega_n_y*(1-zeta_y)^0.5;

% Gerador de Comandos
global junction_speed max_acc max_vel jun_disv des_step_size min_x max_x min_y max_y dt_step_size
min_x = -100.0001;
max_x = 200.0001;
min_y = -100.0001;
max_y = 200.0001;

max_acc = acc;
max_vel = 5000;

junction_speed = 0;
jun_disv = 0;

des_step_size = 0.1;
dt_step_size = step_size;

global A_model B_model

A_model = [
    0       0       1       0;
    0       0       0       1;
    -kx/mx  0       -bx/mx  0;
    0       -ky/my  0       -by/my
    ];

B_model = [
    0       0       0       0;
    0       0       0       0;
    kx/mx   0       bx/mx   0;
    0       ky/my   0       by/my
    ];

% Otimizacao
global options lcon objective_fun
options = optimoptions(@fmincon, 'TolFun', 0.00001, 'MaxIter', 100000, ...
                       'MaxFunEvals', 6000, 'Display', 'iter', ...
                       'DiffMinChange', 0.0000001, 'Algorithm', 'interior-point'); %'interior-point' 'sqp'

% objective_fun = @desv_min_9;
% objective_fun = @desv_min_5;
 objective_fun = @no_obj_fun;
% objective_fun = @desv_min_runge2;
% objective_fun = @desv_min_4;
% objective_fun = @desv_min_2;

lcon=@empty_lcons;
end
