function [angleSequence] = anglelist2AngleSequence(anglelist)
%ANGLELIST2ANGLESEQUENCE 此处显示有关此函数的摘要
%   此处显示详细说明
if nargin<1
    anglelist = {0,pi/4,3*pi/4,pi/2};
end
angleSequence=zeros(4,4);
for ind =1:4
indlist=1:4;
indlist(ind)=[];
indlist(4)=ind;
abc = coefficient_getter4zeta(anglelist{indlist});
abc = [abc(1:ind-1) 0 abc(ind:end)];
angleSequence(ind,:) = abc;
end

