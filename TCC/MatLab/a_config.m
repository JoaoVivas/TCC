%% config
clc;
clear all;
close all;
% Sistema Dinâmico

% x,u mm mm/s
mx = 200; % g
my = 200; % g
kx = 1000000; 
ky = 1000000;
bx = 1000;
by = 1000;

global A_model B_model
A_model = [0 0 1 0;0 0 0 1;-kx/mx 0 -bx/mx 0;0 -ky/my 0 -by/my];
B_model = [0 0 0 0;0 0 0 0;kx/mx 0 bx/mx 0;0 ky/my 0 by/my];

% Gerador de Comandos
global junction_speed max_acc max_vel jun_disv des_step_size min_x max_x min_y max_y dt_step_size
min_x = -0.0001;
max_x = 200.0001;
min_y = -0.0001;
max_y = 200.0001;

max_acc = 1000;
max_vel = 1000;

junction_speed = 0.1;
jun_disv = 0.1;

des_step_size = 0.1;
dt_step_size = 0.01;

% Otimização
global options nonlcon lcon objective_fun def_bounds
options = optimoptions(@fmincon, 'TolFun', 0.0000000001, 'MaxIter', 100000, ...
                       'MaxFunEvals', 700000, 'Display', 'iter', ...
                       'DiffMinChange', 0.0001, 'Algorithm', 'sqp');

% objective_fun = @(x) (x(1,:) - des_x)*(x(1,:) - des_x)'+(x(5,:) - des_y)*(x(5,:) - des_y)';
objective_fun = @desv_min;
def_bounds=@fixed_bounds;
lcon=@empty_lcons;
nonlcon=@double_integrator_points;
%%
x_ub = ;
vx_ub = ;
x_lb = ;
vx_lb = ;

y_ub = ;
vy_ub = ;
y_lb = ;
vy_lb = ;

% Input Shaper

% Dynamic Simulation

dyn_model = @dynamic_model;


% Simulation

% Grafics

%% config status
run = true;