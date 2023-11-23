function [] = plot_and_save_graphs(sim_title, d_b, d_i, u_b, u_i, p_c, p_n, t_b, t_i)
path = 'results\';

%% --------------------------------- Caminho da base ---------------------------------------------
cam_b = figure('Name','Caminho da base');
set(cam_b, 'OuterPosition', [0 0 598 1200])

cam_b_ln = plot(u_b(1,:),u_b(2,:));
cam_b_ln.LineWidth = 2;

lgd = legend({'Caminho da base'},'Location', 'southoutside', 'Orientation', 'vertical');
lgd.FontSize = 10;

xlabel('Posição x [mm]')
ylabel('Posição y [mm]')
xlim([-1 11]);
ylim([-1 11]);
ax = gca;
ax.XTick = [0 2 4 6 8 10];
ax.YTick = [0 2 4 6 8 10];
ax.FontSize = 10;

saveas(gcf, char(strcat(path, sim_title, '_cam_b')), 'fig')
saveas(gcf, char(strcat(path, sim_title, '_cam_b')), 'png')

%% --------------------------------- Caminho da ponta ---------------------------------------------
cam_b = figure('Name','Caminho da ponta');
set(cam_b, 'OuterPosition', [0 0 598 1200])

hold on

cam_p_d_ln = plot(d_i(1,:),d_i(2,:),':');
cam_p_n_ln = plot(p_n(1,:),p_n(2,:),'-.');
cam_p_c_ln = plot(p_c(1,:),p_c(2,:),'--');

cam_p_d_ln.LineWidth = 2;
cam_p_n_ln.LineWidth = 2;
cam_p_c_ln.LineWidth = 2;

lgd = legend({'Caminho da ponta desejado', 'Caminho da ponta sem controle', 'Caminho da ponta com controle'},'Location', 'southoutside', 'Orientation', 'vertical');
lgd.FontSize = 10;

xlabel('Posição x [mm]')
ylabel('Posição y [mm]')
xlim([-1 11]);
ylim([-1 11]);
ax = gca;
ax.XTick = [0 2 4 6 8 10];
ax.YTick = [0 2 4 6 8 10];
ax.FontSize = 10;

saveas(gcf, char(strcat(path, sim_title, '_cam_p')), 'fig')
saveas(gcf, char(strcat(path, sim_title, '_cam_p')), 'png')
%% --------------------------------- Caminho da ponta zoom ---------------------------------------------
cam_b = figure('Name','Caminho da ponta zoom');
set(cam_b, 'OuterPosition', [0 0 598 1200])

hold on

cam_p_d_ln = plot(d_i(1,:),d_i(2,:),':');
cam_p_n_ln = plot(p_n(1,:),p_n(2,:),'-.');
cam_p_c_ln = plot(p_c(1,:),p_c(2,:),'--');

cam_p_d_ln.LineWidth = 2;
cam_p_n_ln.LineWidth = 2;
cam_p_c_ln.LineWidth = 2;

lgd = legend({'Caminho da ponta desejado', 'Caminho da ponta sem controle', 'Caminho da ponta com controle'},'Location', 'southoutside', 'Orientation', 'vertical');
lgd.FontSize = 10;

xlabel('Posição x [mm]')
ylabel('Posição y [mm]')
xlim([9 11]);
ylim([-0.5 1.5]);
ax = gca;
% ax.XTick = [0 2 4 6 8 10];
% ax.YTick = [0 2 4 6 8 10];
ax.FontSize = 10;

saveas(gcf, char(strcat(path, sim_title, '_cam_p_zoom')), 'fig')
saveas(gcf, char(strcat(path, sim_title, '_cam_p_zoom')), 'png')

%% --------------------------------- Deslocamentos ---------------------------------------------
cam_b = figure('Name','Deslocamentos');
set(cam_b, 'OuterPosition', [0 0 1200 1200])

hold on

vel_p_d_x_ln = plot(t_i, u_i(1,:));
% vel_p_d_y_ln = plot(t_i, d_i(4,:),':');
vel_p_n_x_ln = plot(t_i, p_n(1,:),'--');
% vel_p_n_y_ln = plot(t_i, p_n(4,:),':');
vel_p_c_x_ln = plot(t_i, p_c(1,:),'-.');
% vel_p_c_y_ln = plot(t_i, p_c(4,:),':');

vel_p_d_x_ln.LineWidth = 2;
% vel_p_d_y_ln.LineWidth = 2;
vel_p_n_x_ln.LineWidth = 2;
% vel_p_n_y_ln.LineWidth = 2;
vel_p_c_x_ln.LineWidth = 2;
% vel_p_c_y_ln.LineWidth = 2;

lgd = legend({'Deslocamento x da base', 'Deslocamento x da ponta sem controle de trajetória', 'Deslocamento x da ponta com controle de trajetória'},'Location', 'southoutside', 'Orientation', 'vertical');
% lgd = legend({'Velocidade da ponta desejado x', 'Velocidade da ponta desejado y', 'Velocidade da ponta sem controle x', 'Velocidade da ponta sem controle y', 'Velocidade da ponta com controle x', 'Velocidade da ponta com controle y'},'Location', 'southoutside', 'Orientation', 'horizontal');
lgd.FontSize = 10;

xlabel('Tempo [s]')
ylabel('Deslocamento [mm]')
% xlim([-1 11]);
% ylim([-1 11]);
ax = gca;
% ax.XTick = [0 2 4 6 8 10];
% ax.YTick = [0 2 4 6 8 10];
ax.FontSize = 10;

saveas(gcf, char(strcat(path, sim_title,'_des')), 'fig')
saveas(gcf, char(strcat(path, sim_title,'_des')), 'png')

%% --------------------------------- Velocidade da base ---------------------------------------------
cam_b = figure('Name','Velocidade da base');
set(cam_b, 'OuterPosition', [0 0 1200 1200])

hold on

vel_b_x_ln = plot(t_b, u_b(3,:),'-.');
vel_b_y_ln = plot(t_b, u_b(4,:),'--');

vel_b_x_ln.LineWidth = 2;
vel_b_y_ln.LineWidth = 2;

lgd = legend({'Velocidade x da base', 'Velocidade y da base'},'Location', 'southoutside', 'Orientation', 'vertical');
lgd.FontSize = 10;

xlabel('Tempo [s]')
ylabel('Velocidade [mm/s]')
% xlim([-1 11]);
% ylim([-1 11]);
ax = gca;
% ax.XTick = [0 2 4 6 8 10];
% ax.YTick = [0 2 4 6 8 10];
ax.FontSize = 10;

saveas(gcf, char(strcat(path, sim_title,'_vel_b')), 'fig')
saveas(gcf, char(strcat(path, sim_title,'_vel_b')), 'png')

%% --------------------------------- Velocidade da ponta ---------------------------------------------
cam_b = figure('Name','Velocidade da ponta');
set(cam_b, 'OuterPosition', [0 0 1200 1200])

hold on

vel_p_d_x_ln = plot(t_i, d_i(3,:));
% vel_p_d_y_ln = plot(t_i, d_i(4,:),':');
vel_p_n_x_ln = plot(t_i, p_n(3,:),'--');
% vel_p_n_y_ln = plot(t_i, p_n(4,:),':');
vel_p_c_x_ln = plot(t_i, p_c(3,:),'-.');
% vel_p_c_y_ln = plot(t_i, p_c(4,:),':');

vel_p_d_x_ln.LineWidth = 2;
% vel_p_d_y_ln.LineWidth = 2;
vel_p_n_x_ln.LineWidth = 2;
% vel_p_n_y_ln.LineWidth = 2;
vel_p_c_x_ln.LineWidth = 2;
% vel_p_c_y_ln.LineWidth = 2;

lgd = legend({'Velocidade x da ponta trajetória de entrada', 'Velocidade x da ponta sem controle de trajetória', 'Velocidade x da ponta com controle de trajetória'},'Location', 'southoutside', 'Orientation', 'vertical');
% lgd = legend({'Velocidade da ponta desejado x', 'Velocidade da ponta desejado y', 'Velocidade da ponta sem controle x', 'Velocidade da ponta sem controle y', 'Velocidade da ponta com controle x', 'Velocidade da ponta com controle y'},'Location', 'southoutside', 'Orientation', 'horizontal');
lgd.FontSize = 10;

xlabel('Tempo [s]')
ylabel('Velocidade [mm/s]')
% xlim([-1 11]);
% ylim([-1 11]);
ax = gca;
% ax.XTick = [0 2 4 6 8 10];
% ax.YTick = [0 2 4 6 8 10];
ax.FontSize = 10;

saveas(gcf, char(strcat(path, sim_title,'_vel_p')), 'fig')
saveas(gcf, char(strcat(path, sim_title,'_vel_p')), 'png')

% close all
end