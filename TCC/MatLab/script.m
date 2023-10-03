%%
clear all
path = 'C:\Users\Augusto\TCC\TCC\MatLab\results\';
dir_array = dir (fullfile(path,'*'));
numel(dir_array)
%%
for ii = 3:numel(dir_array) % loop over subfolders.
    file_array = dir(fullfile(path,dir_array(ii).name,'*.fig'));
    
    for i = 1:numel(file_array)
       file_path = (fullfile(path,dir_array(ii).name, file_array(i).name)); 
       
       open(file_path)
       WindowState = 'maximized';
       legend('Location', 'southoutside', 'Orientation', 'horizontal')

    end
end

