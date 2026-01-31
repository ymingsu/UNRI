function [jpgFiles] = getallext(folderPath,ext)
%GETALLEXT 此处显示有关此函数的摘要
%   获取文件夹及子文件夹下的所有ext(.jpg)文件
    % 获取文件夹中的所有文件和文件夹
    contents = dir(folderPath);
    
    % 过滤出.jpg文件
    jpgFiles = {folderPath,contents(~[contents.isdir]).name};
    jpgFiles = jpgFiles(endsWith(jpgFiles, ext,'IgnoreCase',true));
    jpgFiles = cellfun(@(file) fullfile(folderPath, file),jpgFiles,'UniformOutput',false);
    % 遍历文件夹
    for i = 1:numel(contents)
        if contents(i).isdir && ~strcmp(contents(i).name, '.') && ~strcmp(contents(i).name, '..')
            % 获取子文件夹路径
            subfolderPath = fullfile(folderPath, contents(i).name);
            
            % 递归获取子文件夹下的所有.jpg文件
            subfolderJpgFiles = getallext(subfolderPath,ext);
            
            % 将子文件夹中的.jpg文件添加到结果列表中
            jpgFiles = [jpgFiles subfolderJpgFiles];
        end
    end
end


