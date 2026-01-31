function polarlist = umpd_extend3(mpfa,anglelist,winsize)
%UMPD 此处显示有关此函数的摘要
%   Universal Monochromatic Polarization Demosaicking
if nargin<3
winsize = 13;
end
eps = 1e-16;

[angleSequence,~,~,angleSequence_inf_logical] = anglelist2Sequence(anglelist);
mpfa4 = repmat(mpfa,[1,1,4]);
sizeraw = size(mpfa4);
mpfa4 = permute(mpfa4,[3,1,2]);
mask = maskofpol(sizeraw(1),sizeraw(2));
mask = permute(mask,[3,1,2]);
mpfa_split = mask.*mpfa4;
img_raw_hat = pagemtimes(angleSequence,mpfa_split);
Weights = sum(angleSequence,1).*sum(angleSequence,2)';
img_raw_hat_sum=squeeze(pagemtimes(Weights,img_raw_hat))./sum(Weights,'all');
%% interpolation
% 3*3 bilinear
bi_kernel = [1,2,1;2,4,2;1,2,1]/4;
img_hat_full = imfilter(img_raw_hat_sum,bi_kernel,"replicate");
%% order 2 delta
mean_delta2_kernel = -[ -1, 0,-1, 0, -1;
      0, 0, 0, 0, 0;
     -1, 0, 8, 0,-1;
      0, 0, 0, 0, 0;
      -1, 0,-1, 0, -1]/16;
mean_delta2_mk= imfilter(mpfa,mean_delta2_kernel,"replicate");
%% refine iun
scale_delta2=1;
Guide = img_hat_full-scale_delta2.*mean_delta2_mk;
polarlist = zeros(sizeraw);
    for polind = 1:4
    [polarlist(:,:,polind),~,~,~]= ...
        residual_interpolation3(Guide,squeeze(mpfa_split(polind,:,:)),squeeze(mask(polind,:,:)),eps,winsize);
    end
% end
%% post process
polarlist=clip(polarlist,0,1);
if any(angleSequence_inf_logical)
polarlist2_part = mean(polarlist(:,:,~angleSequence_inf_logical),3);
polarlist(:,:,~angleSequence_inf_logical)=repmat(polarlist2_part,[1,1,sum(~angleSequence_inf_logical)]);
end

end

