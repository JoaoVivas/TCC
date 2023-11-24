clc
clear all
sim_title_list = {
    'Sim ref';
    'Sim 1A';
    'Sim 1B';
    'Sim 2A';
    'Sim 2B';
    'Sim 3A';
    'Sim 3B';
    'Sim 4A';
    'Sim 4B';
    'Sim 5A';
    'Sim 5B';
    };

% sim_title_list = {'Simref'};

c_l = [];
c_l(1,:) =  [100; 0.5; 5000; 0.005; 100];
c_l(2,:) =  [50; 0.5; 5000; 0.005; 100];
c_l(3,:) =  [200; 0.5; 5000; 0.005; 100];
c_l(4,:) =  [100; 0; 5000; 0.005; 100];
c_l(5,:) =  [100; 1; 5000; 0.005; 100];
c_l(6,:) =  [100; 0.5; 1000; 0.005; 100];
c_l(7,:) =  [100; 0.5; 10000; 0.005; 100];
c_l(8,:) =  [100; 0.5; 5000; 0.01; 100];
c_l(9,:) =  [100; 0.5; 5000; 0.001; 100];
c_l(10,:) =  [100; 0.5; 5000; 0.005; 50];
c_l(11,:) =  [100; 0.5; 5000; 0.005; 200];

sim_time = [];
vec_size = [];
global t_b u_b

for i=1:length(sim_title_list)
   [g_code_x,g_code_y,g_code_v] = config_params(c_l(i,1), c_l(i,2), c_l(i,3), c_l(i,4), c_l(i,5));
   [sim_time(i), vec_size(i), d_b, d_i, u_b, u_i, p_c, p_n, t_b, t_i] = trajectory_control(g_code_x,g_code_y,g_code_v);
   plot_and_save_graphs(sim_title_list(i), d_b, d_i, u_b, u_i, p_c, p_n, t_b, t_i);
   pause(1);
   close all
   pause(5);
end

%%
% resp = struct('Caso', {}, 'TempoDeSimulacao', {}, 'TamanhoDoVetor', {});
% 
% for i=1:length(sim_title_list)
% resp(i).Caso = char(sim_title_list(i));
% resp(i).TempoDeSimulacao = sprintf('%.2f',sim_time(i));
% resp(i).TamanhoDoVetor = vec_size(i);
% end
% 
% resp