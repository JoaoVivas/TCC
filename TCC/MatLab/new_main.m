clc
clear all
% sim_title_list = {
%     'Sim ref';
%     'Sim 1A';
%     'Sim 1B';
%     'Sim 1C';
%     'Sim 1A';
%     'Sim 1B';
%     'Sim 1C';
%     'Sim 2A';
%     'Sim 2B';
%     'Sim 2C';
%     'Sim 3A';
%     'Sim 3B';
%     'Sim 3C';
%     'Sim 4A';
%     'Sim 4B';
%     'Sim 4C';
%     'Sim 5A';
%     'Sim 5B';
%     'Sim 5C';
%     };

sim_title_list = {'Simref'};

c_l = [];
c_l(1,:) =  [100; 0.5; 5000; 0.01; 100];
c_l(2,:) =  [100; 0.5; 5000; 0.01; 100];
c_l(3,:) =  [100; 0.5; 5000; 0.001; 100];
c_l(4,:) =  [100; 0.5; 5000; 100; 100];
c_l(5,:) =  [100; 0.5; 5000; 100; 100];
c_l(6,:) =  [100; 0.5; 5000; 100; 100];
c_l(7,:) =  [100; 0.5; 5000; 100; 100];
c_l(8,:) =  [100; 0.5; 5000; 100; 100];
c_l(9,:) =  [100; 0.5; 5000; 100; 100];
c_l(10,:) =  [100; 0.5; 5000; 100; 100];
c_l(11,:) =  [100; 0.5; 5000; 100; 100];
c_l(12,:) =  [100; 0.5; 5000; 100; 100];
c_l(13,:) =  [100; 0.5; 5000; 100; 100];
c_l(14,:) =  [100; 0.5; 5000; 100; 100];
c_l(15,:) =  [100; 0.5; 5000; 100; 100];
c_l(16,:) =  [100; 0.5; 5000; 100; 100];
c_l(17,:) =  [100; 0.5; 5000; 100; 100];
c_l(18,:) =  [100; 0.5; 5000; 100; 100];
c_l(19,:) =  [100; 0.5; 5000; 100; 100];

sim_time = [];
vec_size = [];
global t_b u_b
for i=1:length(sim_title_list)
   [g_code_x,g_code_y,g_code_v] = config_params(c_l(i,1), c_l(i,2), c_l(i,3), c_l(i,4), c_l(i,5));
   [sim_time(i), vec_size(i), d_b, d_i, u_b, u_i, p_c, p_n, t_b, t_i] = trajectory_control(g_code_x,g_code_y,g_code_v);
   plot_and_save_graphs(sim_title_list(i), d_b, d_i, u_b, u_i, p_c, p_n, t_b, t_i);
   pause(2);
end