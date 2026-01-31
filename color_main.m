close all;
clear;
% clearvars -except dataname anglelist Panglelist datanamelist pali dni colorpattern;

anglelist = {pi/2,pi/4,3*pi/4,0}; %eari pattern;A1
% anglelist = {0,pi/4,3*pi/4,pi/2}; %npid pattern;A2
% anglelist = {pi/4,3*pi/4,pi/2,0};% icpc pattern;A3
% anglelist = {0,pi/3,pi*2/3,'iun'};%A4
% anglelist = {0,pi/3,pi*2/3,0};%A5
dataname = 'TIPColor';%'TIPColor';%'TokyoTech';%
colorpattern = 'rggb';
% disp(['current dataset is ',dataname]);
anglestr = anglelist2str(anglelist);
angleallstr = strjoin(anglestr,'');
kind=['color-',colorpattern,'-',angleallstr];
rawdir = fullfile('D:\Dataset\Mosaicked\',dataname,kind,'\raw');
ext = '.png';
pngsFiles = getallext(rawdir,ext)';
edgesize = 15;

methodname = 'UNRI';
disp(['current method is ',methodname,' dataname is ',dataname,' anglelist is ',angleallstr ]);
outroot=fullfile('D:\Result\DemosackingEval\',methodname,kind);
outparent=fullfile(outroot,dataname);
output_path = genPathDir(outparent);
output_path_cell = strsplit(output_path,'\');

% riqa
riqapath = fullfile(outroot, [strjoin(output_path_cell(4:7),'-'), '_riqa.csv']);
datainitr={'IMG_Name','MethodName',...
    ['PSNR_',anglestr{1}],['PSNR_',anglestr{2}],['PSNR_',anglestr{3}],['PSNR_',anglestr{4}],...
    'PSNR_S0','PSNR_DOLP','CVPSNR_PS','PSNR_AoLP',...
    ['SSIM_',anglestr{1}],['SSIM_',anglestr{2}],['SSIM_',anglestr{3}],['SSIM_',anglestr{4}],...
    'SSIM_S0','SSIM_DOLP','CVSSIM_PS','SSIM_AoLP'};
writecell(datainitr,riqapath,'WriteMode','overwrite');
laststr = anglestr{4};
timesum=0;
sigma = 1; eps = 1e-32;
disp('start')
disp(datetime)
% for imgind = 1:2
parfor imgind =1:length(pngsFiles)%5%1%
%% load data
% disp(num2str(imgind))
rawpath = pngsFiles{imgind};
[~,name0,nativeext]=fileparts(rawpath);
gtpath = strrep(rawpath,'raw','gt');
gtpath = strrep(gtpath,'mosaicked',laststr);
imcpfa = im2double(imread(rawpath));
t1=tic;
% polarlist = ucpd3(imcpfa,colorpattern,anglelist,colormethod);
polarlist = ucpd3_extend(imcpfa,colorpattern,anglelist);
t2=toc(t1);
timesum=timesum+t2;
%% imgs save
imwrite(polarlist(:,:,:,1),fullfile(output_path,strrep([name0,nativeext],'mosaicked',anglestr{1})));
imwrite(polarlist(:,:,:,2),fullfile(output_path,strrep([name0,nativeext],'mosaicked',anglestr{2})));
imwrite(polarlist(:,:,:,3),fullfile(output_path,strrep([name0,nativeext],'mosaicked',anglestr{3})));
imwrite(polarlist(:,:,:,4),fullfile(output_path,strrep([name0,nativeext],'mosaicked',anglestr{4})));
%% compare restoration
pathlist = cellfun(@(x)strrep(gtpath,['_',laststr],['_',x]),anglestr,'UniformOutput',false);
img_gts = cellfun(@(x)im2double(imread(x)),pathlist,'UniformOutput',false);

img_gtlist = cat(4, img_gts{:});
[metrics_psnr,metrics_ssim,metrics_psnr_stokes,metrics_ssim_stokes] = ...
    colormetrics(polarlist,img_gtlist,anglelist,edgesize,false);

name = getitemname(rawpath);
datacrp = {name,methodname,metrics_psnr,metrics_psnr_stokes,metrics_ssim,metrics_ssim_stokes};
writecell(datacrp,riqapath,'WriteMode','append');
end
disp('done')
disp(datetime)
%% show mean average
[~,~] = showthismean(riqapath,anglelist);
