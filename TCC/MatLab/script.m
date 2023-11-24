%%
clear all
path = 'C:\Users\Augusto\TCC\TCC\MatLab\results\';
dir_array = dir (fullfile(path,'*'));
numel(dir_array)
%%
for ii = numel(dir_array)-1:numel(dir_array) % loop over subfolders.
    file_array = dir(fullfile(path,dir_array(ii).name,'*.fig'));
    
    for i = 1:numel(file_array)
       file_name = file_array(i).name;
       file_path = (fullfile(path,dir_array(ii).name, file_name));
       
       fig = openfig(file_path);
       
%        set(gca, 'OuterPosition', [200 200 100 100])
       title(gca, '');
       
       switch false
            case isempty(strfind(file_name, 'des'))
                y_axis = 'desocamento [mm]';
                x_axis = 'tempo [s]';
            case isempty(strfind(file_name, 'pos'))
                fig.OuterPosition = [0 0 598 1200];
                y_axis = 'posição x [mm]';
                x_axis = 'posição y [mm]';
                xlim([-1 11]);
                ylim([-1 11]);
                ax = gca;
                ax.XTick = [0 2 4 6 8 10];
                ax.YTick = [0 2 4 6 8 10];
           case isempty(strfind(file_name, 'vels'))
                y_axis = 'velocidade [mm/s]';
                x_axis = 'tempo [s]';
           case isempty(strfind(file_name, 'Viabilidade'))
                y_axis = 'viabilidade []';
                x_axis = 'numero de iterações []';
       end
       
       xlabel(gca, x_axis)
       ylabel(gca, y_axis)
%        
%        x_axis = ''
%        y_axis = ''
%        
%        case_str = strrep(file_name, ' ', '')
%        case_str = strrep(case_str, 'des.png', '')
%        case_str = strrep(case_str, 'pos.png', '')
%        case_str = strrep(case_str, 'vels.png', '')
%        case_str = strrep(case_str, 'Viabilidade.png', '')
%        case_str = strrep(case_str, 'Teste', '(Caso ')
%        
%        ttl = strcat(ttl, case_str, ')')
       
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

