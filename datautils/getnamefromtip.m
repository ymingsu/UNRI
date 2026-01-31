function name = getnamefromtip(path,index)
name_split = strsplit(path,'\');
name_join = strjoin(name_split(index:end),' ');
name_split2 = strsplit(name_join,'-');
name = name_split2{1};
name = strrep(name,' ','');
end