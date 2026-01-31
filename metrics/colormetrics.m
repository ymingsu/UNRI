function [metrics_psnr,metrics_ssim,metrics_psnr_stokes,metrics_ssim_stokes] = colormetrics(polarlist,polarlistref,anglelist,removeEdgesize,bShowPSNR)
%MONOPSNR 此处显示有关此函数的摘要
%   此处显示详细说明
if nargin<4
removeEdgesize = 15;
end
if nargin<5
bShowPSNR = true;
end
%% remove edge
polarlistref = removEdge(polarlistref,removeEdgesize);
polarlist = removEdge(polarlist,removeEdgesize);

%% get data
Amat = anglelist2Amatrix(anglelist);
anglestr = anglelist2str(anglelist);
%% gen our stokes
Stokes_our = pagemldivide(Amat,permute(polarlist,[4,1,2,3]));
Stokes_our = permute(Stokes_our,[2,3,4,1]);
ps_our = (Stokes_our(:,:,:,2)+1i*Stokes_our(:,:,:,3))./(Stokes_our(:,:,:,1)+eps);
%% gen gt stokes
Stokes_gt = pagemldivide(Amat,permute(polarlistref,[4,1,2,3]));
Stokes_gt = permute(Stokes_gt,[2,3,4,1]);
ps_gt = (Stokes_gt(:,:,:,2)+1i*Stokes_gt(:,:,:,3))./(Stokes_gt(:,:,:,1)+eps);
%% calculate metrics of anglelist
metrics_psnr = zeros(1,4);
metrics_ssim = zeros(1,4);
for imgcp_ind =1:4
%     disp(['compare,',num2str(imgcp_ind)])
    metrics_psnr(imgcp_ind) = psnr(polarlistref(:,:,:,imgcp_ind),polarlist(:,:,:,imgcp_ind));
    metrics_ssim(imgcp_ind) = ssim(polarlistref(:,:,:,imgcp_ind),polarlist(:,:,:,imgcp_ind));
end

PSNR_str = {['PSNR_',anglestr{1}],['PSNR_',anglestr{2}],['PSNR_',anglestr{3}],['PSNR_',anglestr{4}]};
if bShowPSNR
disp(PSNR_str)
disp(num2str(metrics_psnr))
disp(num2str(metrics_ssim))
end
%% calculate metrics of stokes
metrics_psnr_stokes = zeros(1,4);
metrics_ssim_stokes = zeros(1,4);
peakvaluelist = [2,1,1];
imgcp_ind = 1;
    metrics_psnr_stokes(imgcp_ind) = psnr(Stokes_gt(:,:,:,imgcp_ind),Stokes_our(:,:,:,imgcp_ind),peakvaluelist(imgcp_ind));
    metrics_ssim_stokes(imgcp_ind) = ssim(Stokes_gt(:,:,:,imgcp_ind),Stokes_our(:,:,:,imgcp_ind),"DynamicRange",peakvaluelist(imgcp_ind));
    metrics_psnr_stokes(2)=psnr(abs(ps_our),abs(ps_gt));
    metrics_ssim_stokes(2)=ssim(abs(ps_our),abs(ps_gt));
    metrics_psnr_stokes(3)=cvpsnr(ps_our,ps_gt);
    metrics_ssim_stokes(3)=cvssim(ps_our,ps_gt,'RegularizationConstants',[1+(0.01).^2 (0.03).^2 ((0.03).^2)/2]);
    metrics_psnr_stokes(4)=APSNR(1/2*angle(ps_our),1/2*angle(ps_gt));
    metrics_ssim_stokes(4)=ASSIM(1/2*angle(ps_our),1/2*angle(ps_gt));
PSNR_Stokes_str = {'PSNR_S0','PSNR_DOLP','CVPSNR_PS','PSNR_AoLP'};
if bShowPSNR
disp(PSNR_Stokes_str)
disp(num2str(metrics_psnr_stokes))
disp(num2str(metrics_ssim_stokes))
end
end

