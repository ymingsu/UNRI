function name = getitemname(path)
%GETITEMNAME 此处显示有关此函数的摘要
%   此处显示详细说明
name_split = strsplit(path,'\');
name0 = name_split{end};
name_cell = strsplit(name0,'_');
name = name_cell{1};
end

