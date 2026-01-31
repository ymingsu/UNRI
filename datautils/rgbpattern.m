function [matRGB,matG] = rgbpattern(pattern)
%RGBPATTERN 此处显示有关此函数的摘要
%   此处显示详细说明
if nargin<1
pattern = 'gbrg';
end
matRGB=zeros(2,2,3);
matG=zeros(2,2,2);
switch pattern
    case 'rggb'
        matRGB(:,:,1)=[1 0;0 0];
        matRGB(:,:,2)=[0 1;1 0];
        matRGB(:,:,3)=[0 0;0 1];
        matG(:,:,1)=[0 1;0 0];%Gr
        matG(:,:,2)=[0 0;1 0];%Gb
    case 'bggr'
        matRGB(:,:,1)=[0 0;0 1];
        matRGB(:,:,2)=[0 1;1 0];
        matRGB(:,:,3)=[1 0;0 0];
        matG(:,:,2)=[0 1;0 0];%Gb
        matG(:,:,1)=[0 0;1 0];
    case 'grbg'
        matRGB(:,:,1)=[0 1;0 0];
        matRGB(:,:,2)=[1 0;0 1];
        matRGB(:,:,3)=[0 0;1 0];
        matG(:,:,1)=[1 0;0 0];%Gr
        matG(:,:,2)=[0 0;0 1];%Gb
    otherwise %case 'gbrg'
        matRGB(:,:,1)=[0 0;1 0];
        matRGB(:,:,2)=[1 0;0 1];
        matRGB(:,:,3)=[0 1;0 0];
        matG(:,:,1)=[0 0;0 1];%Gr
        matG(:,:,2)=[1 0;0 0];%Gb
end
end

