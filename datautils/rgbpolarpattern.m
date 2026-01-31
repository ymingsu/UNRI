function [matRGBPolar] = rgbpolarpattern(pattern)
%RGBPOLARPATTERN 此处显示有关此函数的摘要
%   此处显示详细说明
if nargin<1
    pattern= 'gbrg';
end
[matRGB,~] = rgbpattern(pattern);
matPolar = polarpattern();
matRGBPolar=zeros(4,4,3,4);
    for p=1:4
        for c=1:3
            matRGBPolar(:,:,c,p)=kron(matRGB(:,:,c),matPolar(:,:,p));
        end
    end
end

