function path = genPathDir(pathpre)
%GENPATHDIR 此处显示有关此函数的摘要
%   此处显示详细说明
    for idx=1:1000
        path=fullfile(pathpre, num2str(idx));
        if checkdir(path,true,false)
            break;
        end
    end
end

