function name=getname(path,index)
name_split = strsplit(path,'\');
name = name_split{index};
end