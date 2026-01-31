function [Amatrix] = anglelist2Amatrix(anglelist)
%ANGLELIST2AMATRIX 此处显示有关此函数的摘要
%   此处显示详细说明
if nargin<1
    anglelist = {0,pi/4,3*pi/4,pi/2};
end
Amatrix=zeros(length(anglelist),3);
for index =1:length(anglelist)
angle = anglelist{index};
if isnumeric(angle)
    aline = [1,cos(2*angle),sin(2*angle)]/2;
elseif strcmpi(angle,'iun')
    aline = [1,0,0]/2;
elseif strcmpi(angle,'s0')
    aline = [2,0,0]/2;
end
Amatrix(index,:)=aline;
end
end

