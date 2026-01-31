function [matPolar] = polarpattern()
%POLARPATTERN 此处显示有关此函数的摘要
%   此处显示详细说明
mask1 = [1,0;0,0];
mask2 = [0,1;0,0];
mask3 = [0,0;1,0];
mask4 = [0,0;0,1];
matPolar = cat(3,mask1,mask2,mask3,mask4);
end

