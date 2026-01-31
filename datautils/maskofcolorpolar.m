function [channelmask] = maskofcolorpolar(pattern,m,n)
%MASKOFCOLORPOLAR 此处显示有关此函数的摘要
%   此处显示详细说明
[matRGBPolar] = rgbpolarpattern(pattern);
t_mask=repmat(matRGBPolar,[ceil(m/4) ceil(n/4) 1 1]);
channelmask=t_mask(1:m,1:n,:,:);
end

