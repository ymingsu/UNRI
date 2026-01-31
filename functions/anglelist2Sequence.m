function [angleSequence,varargout] = anglelist2Sequence(anglelist)
%ANGLELIST2SEQUENCE 此处显示有关此函数的摘要
%   此处显示详细说明
if nargin<1
    anglelist = {0,pi/4,3*pi/4,pi/2};
end

angleSequence=zeros(4,4);
angleSequenceS1=zeros(4,4);
angleSequenceS2=zeros(4,4);
for ind =1:4
% 一个从1:4的列表中移除ind后的列表
indlist = 1:4;
indlist(ind)=[];
abc = coefficient_getter(anglelist{indlist});
% abcS1 = coefficient_getterS1(anglelist{indlist});
% abcS2 = coefficient_getterS2(anglelist{indlist});
% 在abc的位置ind插入一个0，其他数相应后移
abc = [abc(1:ind-1) 0 abc(ind:end)];
angleSequence(ind,:) = abc;

% abcS1 = [abcS1(1:ind-1) 0 abcS1(ind:end)];
% angleSequenceS1(ind,:) = abcS1;

% abcS2 = [abcS2(1:ind-1) 0 abcS2(ind:end)];
% angleSequenceS2(ind,:) = abcS2;
end
angleSequence_inf_logical0  = isinf(angleSequence);
angleSequence_inf_logical = any(angleSequence_inf_logical0,2);
angleSequence(angleSequence_inf_logical,:)=0;%[];
% angleSequenceS1(angleSequence_inf_logical,:)=0;%[];
% angleSequenceS2(angleSequence_inf_logical,:)=0;%[];
varargout{1}=zeros(size(angleSequence));%angleSequenceS1;
varargout{2}=zeros(size(angleSequence));%angleSequenceS2;
varargout{3}=angleSequence_inf_logical;
end

