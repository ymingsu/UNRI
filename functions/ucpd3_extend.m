function [polarlist] = ucpd3_extend(imcpfa,colorpattern,anglelist)
%UCPD3 此处显示有关此函数的摘要
%   此处显示详细说明
sigma = 1; eps = 1e-32;
[images] = cpfaSpliter(imcpfa);
images_color = cell(1,4);
for colorid= 1:4
    images_color{colorid} = demosaick(repmat(images{colorid},[1,1,3]),colorpattern,sigma,eps);
end
[Microgrid_im] = rearrange4polardemosaic(images_color,size(imcpfa,1),size(imcpfa,2));
polarlist = umpd3_extend3(Microgrid_im,anglelist);
end

