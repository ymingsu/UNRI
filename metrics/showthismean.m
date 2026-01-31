function [mean_crp,mean_ave_crp] = showthismean(csvpath,anglelist,bshow)
%SHOWTHISMEAN 此处显示有关此函数的摘要
%   此处显示详细说明
if nargin<3
bshow = true;
end
if nargin<2
anglelist = {pi/2,pi/4,3*pi/4,0}; %eari pattern
end
csvdata = readtable(csvpath);
if (height(csvdata)~=40)&&(height(csvdata)~=50)
    disp(['this csv is not 40 or 50 images, real number is ',num2str(height(csvdata))])
%     continue
end
mean_crp=mean(table2array(csvdata(:,3:end)),'omitnan');
anglestr = anglelist2str(anglelist);
angleallstr = strjoin(anglestr,'');
if strcmp(angleallstr, '0601200')
mean_ave_crp = [mean(mean_crp(2:4)),mean_crp(5:8),mean(mean_crp(10:12)),mean_crp(13:16)];
else
mean_ave_crp = [mean(mean_crp(1:4)),mean_crp(5:8),mean(mean_crp(9:12)),mean_crp(13:16)];
end
PSNR_data_str = {'PSNR_AVE','PSNR_S0','PSNR_DOLP','CVPSNR_PS','PSNR_AoLP'};
if bshow
disp(PSNR_data_str)
disp(num2str(mean_ave_crp(1:5)))
disp(num2str(mean_ave_crp(6:end)))
end
end

