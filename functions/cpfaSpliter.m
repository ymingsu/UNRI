function [images] = cpfaSpliter(imcpfa)
%CPFASPLITER 此处显示有关此函数的摘要
%   此处显示详细说明
matPolar=polarpattern();
images=cell([1 4]);
for idx=1:4
    [row,col] = find(matPolar(:,:,idx)==1);
    images{idx}=imcpfa(row(1):2:end,col(1):2:end);
end
end

