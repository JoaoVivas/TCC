function [] = plot_and_save_graphs(sim_title, d_b, d_i, u_b, u_i, p_c, p_n, t_b, t_i)
path = 'results\';

%% --------------------------------- Caminho controle ---------------------------------------------
cam_b = figure('Name','Caminho da base e da ponta com controle');
set(cam_b, 'OuterPosition', [0 0 700 1200])

hold on

cam_b_ln = plot(u_i(1,:),u_i(2,:),':');
cam_p_c_ln = plot(p_c(1,:),p_c(2,:),'--');

cam_b_ln.LineWidth = 3;
cam_p_c_ln.LineWidth = 3;

lgd = legend({'Caminho da base com controle', 'Caminho da ponta com controle'},'Location', 'southoutside', 'Orientation', 'vertical');
lgd.FontSize = 14;

xlabel('Posição x [mm]')
ylabel('Posição y [mm]')
xlim([0 11.5]);
ylim([-1 10.5]);
ax = gca;
ax.XTick = [0 2 4 6 8 10];
ax.YTick = [0 2 4 6 8 10];
ax.FontSize = 14;

pause(0.5);

saveas(gcf, char(strcat(path, sim_title, '_cam_c')), 'fig')
saveas(gcf, char(strcat(path, sim_title, '_cam_c')), 'png')

%% --------------------------------- Caminho sem controle ---------------------------------------------
cam_b = figure('Name','Caminho da base e da ponta sem controle');
set(cam_b, 'OuterPosition', [0 0 700 1200])

hold on

cam_p_d_ln = plot(d_i(1,:),d_i(2,:),':');
cam_p_n_ln = plot(p_n(1,:),p_n(2,:),'--');

cam_p_d_ln.LineWidth = 3;
cam_p_n_ln.LineWidth = 3;

lgd = legend({'Caminho da base sem controle', 'Caminho da ponta sem controle'},'Location', 'southoutside', 'Orientation', 'vertical');
lgd.FontSize = 14;

xlabel('Posição x [mm]')
ylabel('Posição y [mm]')
xlim([0 11.5]);
ylim([-1 10.5]);
ax = gca;
ax.XTick = [0 2 4 6 8 10];
ax.YTick = [0 2 4 6 8 10];
ax.FontSize = 14;

pause(0.5);

saveas(gcf, char(strcat(path, sim_title, '_cam_s')), 'fig')
saveas(gcf, char(strcat(path, sim_title, '_cam_s')), 'png')
%% --------------------------------- Caminho controle zoom ---------------------------------------------
cam_b = figure('Name','Caminho da ponta zoom');
set(cam_b, 'OuterPosition', [0 0 700 1200])

hold on

cam_b_ln = plot(u_i(1,:),u_i(2,:),':');
cam_p_c_ln = plot(p_c(1,:),p_c(2,:),'--');

cam_b_ln.LineWidth = 3;
cam_p_c_ln.LineWidth = 3;

lgd = legend({'Caminho da base com controle', 'Caminho da ponta com controle'},'Location', 'southoutside', 'Orientation', 'vertical');
lgd.FontSize = 14;

xlabel('Posição x [mm]')
ylabel('Posição y [mm]')
xlim([8.5 11.5]);
ylim([-0.5 2.5]);
ax = gca;
% ax.XTick = [0 2 4 6 8 10];
% ax.YTick = [0 2 4 6 8 10];
ax.FontSize = 14;

pause(0.5);

saveas(gcf, char(strcat(path, sim_title, '_cam_c_zoom')), 'fig')
saveas(gcf, char(strcat(path, sim_title, '_cam_c_zoom')), 'png')
%% --------------------------------- Caminho sem controle zoom ---------------------------------------------
cam_b = figure('Name','Caminho da ponta zoom');
set(cam_b, 'OuterPosition', [0 0 700 1200])

hold on

cam_p_d_ln = plot(d_i(1,:),d_i(2,:),':');
cam_p_n_ln = plot(p_n(1,:),p_n(2,:),'--');

cam_p_d_ln.LineWidth = 3;
cam_p_n_ln.LineWidth = 3;

lgd = legend({'Caminho da base sem controle', 'Caminho da ponta sem controle'},'Location', 'southoutside', 'Orientation', 'vertical');
lgd.FontSize = 14;

xlabel('Posição x [mm]')
ylabel('Posição y [mm]')
xlim([8.5 11.5]);
ylim([-0.5 2.5]);
ax = gca;
% ax.XTick = [0 2 4 6 8 10];
% ax.YTick = [0 2 4 6 8 10];
ax.FontSize = 14;

pause(0.5);

saveas(gcf, char(strcat(path, sim_title, '_cam_s_zoom')), 'fig')
saveas(gcf, char(strcat(path, sim_title, '_cam_s_zoom')), 'png')

%% --------------------------------- Deslocamentos controle ---------------------------------------------
cam_b = figure('Name','Deslocamentos');
set(cam_b, 'OuterPosition', [0 0 700 1200])

hold on

des_b_c_x_ln = plot(t_i, u_i(1,:),':');
des_b_c_y_ln = plot(t_i, u_i(2,:),':');

des_p_c_x_ln = plot(t_i, p_c(1,:),'--');
des_p_c_y_ln = plot(t_i, p_c(2,:),'--');

des_b_c_x_ln.LineWidth = 3;
des_b_c_y_ln.LineWidth = 3;
des_p_c_x_ln.LineWidth = 3;
des_p_c_y_ln.LineWidth = 3;

lgd = legend({'Deslocamento x da base com controle','Deslocamento y da base com controle', 'Deslocamento x da ponta com controle', 'Deslocamento y da ponta com controle'},'Location', 'southoutside', 'Orientation', 'vertical');
% lgd = legend({'Velocidade da ponta desejado x', 'Velocidade da ponta desejado y', 'Velocidade da ponta sem controle x', 'Velocidade da ponta sem controle y', 'Velocidade da ponta com controle x', 'Velocidade da ponta com controle y'},'Location', 'southoutside', 'Orientation', 'horizontal');
lgd.FontSize = 14;

xlabel('Tempo [s]')
ylabel('Deslocamento [mm]')
% xlim([-1 11]);
% ylim([-1 11]);
ax = gca;
% ax.XTick = [0 2 4 6 8 10];
% ax.YTick = [0 2 4 6 8 10];
ax.FontSize = 14;

pause(0.5);

saveas(gcf, char(strcat(path, sim_title,'_des_c')), 'fig')
saveas(gcf, char(strcat(path, sim_title,'_des_c')), 'png')
%% --------------------------------- Deslocamentos sem controle ---------------------------------------------
cam_b = figure('Name','Deslocamentos');
set(cam_b, 'OuterPosition', [0 0 700 1200])

hold on

des_b_s_x_ln = plot(t_i, d_i(1,:),':');
des_b_s_y_ln = plot(t_i, d_i(2,:),':');

des_p_s_x_ln = plot(t_i, p_n(1,:),'--');
des_p_s_y_ln = plot(t_i, p_n(2,:),'--');

des_b_s_x_ln.LineWidth = 3;
des_b_s_y_ln.LineWidth = 3;
des_p_s_x_ln.LineWidth = 3;
des_p_s_y_ln.LineWidth = 3;

lgd = legend({'Deslocamento x da base sem controle','Deslocamento y da base sem controle', 'Deslocamento x da ponta sem controle', 'Deslocamento x da ponta sem controle'},'Location', 'southoutside', 'Orientation', 'vertical');
% lgd = legend({'Velocidade da ponta desejado x', 'Velocidade da ponta desejado y', 'Velocidade da ponta sem controle x', 'Velocidade da ponta sem controle y', 'Velocidade da ponta com controle x', 'Velocidade da ponta com controle y'},'Location', 'southoutside', 'Orientation', 'horizontal');
lgd.FontSize = 14;

xlabel('Tempo [s]')
ylabel('Deslocamento [mm]')
% xlim([-1 11]);
% ylim([-1 11]);
ax = gca;
% ax.XTick = [0 2 4 6 8 10];
% ax.YTick = [0 2 4 6 8 10];
ax.FontSize = 14;

pause(0.5);

saveas(gcf, char(strcat(path, sim_title,'_des_s')), 'fig')
saveas(gcf, char(strcat(path, sim_title,'_des_s')), 'png')

%% --------------------------------- Velocidade controle ---------------------------------------------
cam_b = figure('Name','Velocidade da base');
set(cam_b, 'OuterPosition', [0 0 700 1200])

hold on

vel_b_c_x_ln = plot(t_b, u_b(3,:),':');
vel_b_c_y_ln = plot(t_b, u_b(4,:),':');

vel_p_c_x_ln = plot(t_i, p_c(3,:),'--');
vel_p_c_y_ln = plot(t_i, p_c(4,:),'--');

vel_b_c_x_ln.LineWidth = 3;
vel_b_c_y_ln.LineWidth = 3;

vel_p_c_x_ln.LineWidth = 3;
vel_p_c_y_ln.LineWidth = 3;

lgd = legend({'Velocidade x da base com controle', 'Velocidade y da base com controle', 'Velocidade x da ponta com controle', 'Velocidade y da ponta com controle'},'Location', 'southoutside', 'Orientation', 'vertical');
lgd.FontSize = 14;

xlabel('Tempo [s]')
ylabel('Velocidade [mm/s]')
% xlim([-1 11]);
% ylim([-1 11]);
ax = gca;
% ax.XTick = [0 2 4 6 8 10];
% ax.YTick = [0 2 4 6 8 10];
ax.FontSize = 14;

pause(0.5);

saveas(gcf, char(strcat(path, sim_title,'_vel_c')), 'fig')
saveas(gcf, char(strcat(path, sim_title,'_vel_c')), 'png')

%% --------------------------------- Velocidade sem controle ---------------------------------------------
cam_b = figure('Name','Velocidade da ponta');
set(cam_b, 'OuterPosition', [0 0 700 1200])

hold on

vel_b_s_x_ln = plot(t_i, d_i(3,:),':');
vel_b_s_y_ln = plot(t_i, d_i(4,:),':');

vel_p_s_x_ln = plot(t_i, p_n(3,:),'--');
vel_p_s_y_ln = plot(t_i, p_n(4,:),'--');

vel_b_s_x_ln.LineWidth = 3;
vel_b_s_y_ln.LineWidth = 3;

vel_p_s_x_ln.LineWidth = 3;
vel_p_s_y_ln.LineWidth = 3;

lgd = legend({'Velocidade x da base sem controle', 'Velocidade y da base sem controle', 'Velocidade x da ponta sem controle', 'Velocidade y da ponta sem controle'},'Location', 'southoutside', 'Orientation', 'vertical');
% lgd = legend({'Velocidade da ponta desejado x', 'Velocidade da ponta desejado y', 'Velocidade da ponta sem controle x', 'Velocidade da ponta sem controle y', 'Velocidade da ponta com controle x', 'Velocidade da ponta com controle y'},'Location', 'southoutside', 'Orientation', 'horizontal');
lgd.FontSize = 14;

xlabel('Tempo [s]')
ylabel('Velocidade [mm/s]')
% xlim([-1 11]);
% ylim([-1 11]);
ax = gca;
% ax.XTick = [0 2 4 6 8 10];
% ax.YTick = [0 2 4 6 8 10];
ax.FontSize = 14;

pause(0.5);

saveas(gcf, char(strcat(path, sim_title,'_vel_s')), 'fig')
saveas(gcf, char(strcat(path, sim_title,'_vel_s')), 'png')
end