function [ssimval,ssimmap]  = ASSIM(angleimg,angleimgref)
%ASSIM 此处显示有关此函数的摘要
%   此处显示详细说明
angleimgto1 = mod(angleimg,pi);
angleimgrefto1 = mod(angleimgref,pi);
[ssimval,ssimmap] =cvssim(exp(2i*angleimgto1),exp(2i*angleimgrefto1),'RegularizationConstants',[1+(0.01).^2 (0.03).^2 ((0.03).^2)/2]);
end

