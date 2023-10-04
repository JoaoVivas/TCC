%%
clear all
path = 'C:\Users\Augusto\TCC\TCC\MatLab\results\';
dir_array = dir (fullfile(path,'*'));
numel(dir_array)
%%
for ii = 4:4 %numel(dir_array) % loop over subfolders.
    file_array = dir(fullfile(path,dir_array(ii).name,'*.fig'));
    
    for i = 1:numel(file_array)
       file_name = file_array(i).name;
       file_path = (fullfile(path,dir_array(ii).name, file_name));
       
       fig = openfig(file_path)
       
       ttl = get(get(gca, 'title'), 'string')
       
       ttl = strrep(ttl, 'Resultado x_y(t)', '');
       ttl = strrep(ttl, 'Resultado vx_vy(t)', '');
       ttl = strrep(ttl, 'Resultado x_y da', '');
       ttl = strrep(ttl, 'Viabilidade x num_f Teste', '');
       
       ttl = strrep(ttl, '1', '');
       ttl = strrep(ttl, '2', '');
       ttl = strrep(ttl, '3', '');
       ttl = strrep(ttl, '4', '');
       ttl = strrep(ttl, '5', '');
       
       case_str = strrep(file_name, ' ', '')
       case_str = strrep(case_str, 'des.png', '')
       case_str = strrep(case_str, 'pos.png', '')
       case_str = strrep(case_str, 'vels.png', '')
       case_str = strrep(case_str, 'Viabilidade.png', '')
       case_str = strrep(case_str, 'Teste', '(Caso ')
       
       ttl = strcat(ttl, case_str, ')')
       
       set(gca,'FontSize',20)
       set(findall(gca, 'Type', 'Line'),'LineWidth',3);
       %ax = get(fig,'children')
       % get handles to the elements in the axes: a single line plot here
       %h = get(ax,'children')
       % manipulate desired properties of the line, e.g. line width
       %set(h,'LineWidth',3);
       lgd = legend('Location', 'southoutside', 'Orientation', 'horizontal');
       lgd.FontSize = 16;
       new_file_path = strrep(file_path, '.fig', '.png');
       saveas(gcf, new_file_path)
    end
end

