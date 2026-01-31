function [anglestr] = anglelist2str(anglelist)
%ANGLELIST2STR 此处显示有关此函数的摘要
%   % 将anglelist从弧度转换成角度并保留两位小数后作为文件名
if nargin<1
    anglelist = {0,pi/4,3*pi/4,pi/2};
end
anglestr=cell(length(anglelist),1);
for index =1:length(anglelist)
angle = anglelist{index};
if isnumeric(angle)
    angleInDegrees = round(rad2deg(angle), 2);
    aline = num2str(angleInDegrees);
elseif strcmpi(angle,'iun')
    aline = 'iun';
elseif strcmpi(angle,'s0')
    aline = 's0';
end
anglestr{index}=aline;
end
end

