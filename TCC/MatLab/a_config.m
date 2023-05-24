
% config
clc;
clear all;
close all;
% Sistema Dinâmico

% x,u mm mm/s
mx = 0.200; % Kg
my = 0.200; % Kg
kx = 2000.48; 
ky = 2000.48;
bx = 0;
by = 0;

global A_model B_model
% A_model = [0 0 1 0;0 0 0 1;-kx/mx 0 -bx/mx 0;0 -ky/my 0 -by/my];
% B_model = [0 0 0 0;0 0 0 0;kx/mx 0 bx/mx 0;0 ky/my 0 by/my];


A_model = [0 1 0 0;-kx/mx -bx/mx 0 0;0 0 0 1;0 0 -ky/my -by/my];
B_model = [0 0 0 0;kx/mx bx/mx 0 0;0 0 0 0;0 0 ky/my by/my];

% Gerador de Comandos
global junction_speed max_acc max_vel jun_disv des_step_size min_x max_x min_y max_y dt_step_size
min_x = -100.0001;
max_x = 200.0001;
min_y = -100.0001;
max_y = 200.0001;

max_acc = 2000;
max_vel = 1000;

junction_speed = 0.1;
jun_disv = 0.1;

des_step_size = 0.1;
dt_step_size = 0.001;

% Otimização
global options nonlcon lcon objective_fun def_bounds
options = optimoptions(@fmincon, 'TolFun', 0.01, 'MaxIter', 100000, ...
                       'MaxFunEvals', 90000, 'Display', 'iter', ...
                       'DiffMinChange', 0.000001, 'Algorithm', 'interior-point'); %'interior-point' 'sqp'

% objective_fun = @(x) (x(1,:) - des_x)*(x(1,:) - des_x)'+(x(5,:) - des_y)*(x(5,:) - des_y)';
% objective_fun = @desv_min_9;
objective_fun = @desv_min_5;
% objective_fun = @desv_min_4;

% def_bounds=@fixed_bounds_9;
def_bounds=@fixed_bounds_5;
% def_bounds=@fixed_bounds_4;

lcon=@empty_lcons;

% nonlcon=@double_integrator_points_x;
% nonlcon=@double_integrator_points_x_t;
nonlcon=@double_integrator_points_runge;
% %%
% x_ub = ;
% vx_ub = ;
% x_lb = ;
% vx_lb = ;
% 
% y_ub = ;
% vy_ub = ;
% y_lb = ;
% vy_lb = ;
% 
% % Input Shaper
% 
% SEG_TIME = .000100
% INV_SEG_TIME = 1. / SEG_TIME
% 
% SPRING_FREQ=35.0
% DAMPING_RATIO=0.05
% 
% CONFIG_FREQ=40.0
% CONFIG_DAMPING_RATIO=0.1
% % Dynamic Simulation
% 
% dyn_model = @dynamic_model;
% 
% 
% % Simulation
% 
% % Grafics
% 
% %% config status
% run = true;