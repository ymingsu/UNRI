function [PSNR_angle] = APSNR(angleimg,angleimgref)
%APSNR 此处显示有关此函数的摘要
%   此处显示详细说明
angleimgtopi = mod(angleimg,pi);
angleimgreftopi = mod(angleimgref,pi);
diff0 = abs(angleimgtopi-angleimgreftopi);
diff = min(diff0,pi-diff0);
PSNR_angle = psnr(zeros(size(diff)),diff,pi);
end

