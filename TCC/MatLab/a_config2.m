
% config
clc;
clear all;
close all;
% Sistema Din�mico

% x,u mm mm/s
mx =.200; % g
my =.200; % g
kx = 200; 
ky = 200;
bx =0.01* 10000;
by =0.01* 10000;

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

max_acc = 5000;
max_vel = 1000;

junction_speed = 0.1;
jun_disv = 0.1;

des_step_size = 0.1;
dt_step_size = 0.001;

% Otimiza��o
global options nonlcon lcon objective_fun def_bounds
options = optimoptions(@fmincon, 'TolFun', 0.01, 'MaxIter', 100000, ...
                       'MaxFunEvals', 90000, 'Display', 'iter', ...
                       'DiffMinChange', 0.000001, 'Algorithm', 'interior-point'); %'interior-point' 'sqp'

% objective_fun = @(x) (x(1,:) - des_x)*(x(1,:) - des_x)'+(x(5,:) - des_y)*(x(5,:) - des_y)';
% objective_fun = @desv_min_9;
% objective_fun = @desv_min_5;
objective_fun = @no_obj_fun;
% objective_fun = @desv_min_runge2;
% objective_fun = @desv_min_4;

% def_bounds=@fixed_bounds_9;
def_bounds=@fixed_bounds_5;
% def_bounds=@fixed_bounds_2;

lcon=@empty_lcons;

% nonlcon=@double_integrator_points_x;
nonlcon=@double_integrator_points_x_t;
% nonlcon = [];
% nonlcon=@double_integrator_points;