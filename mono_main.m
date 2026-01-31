close all;
clearvars -except dataname anglelist Panglelist datanamelist pali dni;


% anglelist = {pi/2,pi/4,3*pi/4,0}; %eari pattern;A1
% anglelist = {0,pi/4,3*pi/4,pi/2}; %npid pattern;A2
% anglelist = {pi/4,3*pi/4,pi/2,0};% icpc pattern;A3
% anglelist = {0,pi/3,pi*2/3,'iun'};%A4
anglelist = {0,pi/3,pi*2/3,0};%A5

dataname = 'TIP';%%'TokyoTech';%'TIP'%
% disp(['current dataset is ',dataname]);
anglestr = anglelist2str(anglelist);
angleallstr = strjoin(anglestr,'');
rawdir = fullfile('D:\Dataset\Mosaicked\',dataname,['mono',angleallstr],'\raw');
ext = '.png';
pngsFiles = getallext(rawdir,ext)';
edgesize = 15;

methodname = 'UNRI';
disp(['current method is ',methodname,' current dataname is ',dataname,' current anglelist is ',angleallstr ]);
outroot=fullfile('D:\Result\DemosackingEval\',methodname,['mono',angleallstr]);
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

winsize = 13;
% disp(['winsize on the RI step is ', num2str(winsize)]);
disp('start')
disp(datetime)
timesum=0;
% for imgind = 1:2
for imgind = 1:length(pngsFiles)
%% load data
% disp(num2str(imgind))
rawpath = pngsFiles{imgind};
[~,name0,nativeext]=fileparts(rawpath);
gtpath = strrep(rawpath,'raw','gt');
gtpath = strrep(gtpath,'mosaicked',laststr);
mpfa = im2double(imread(rawpath));
t1=tic;
polarlist = umpd_extend3(mpfa,anglelist,winsize);
t2=toc(t1);
timesum=timesum+t2;
%% imgs save
imwrite(polarlist(:,:,1),fullfile(output_path,strrep([name0,nativeext],'mosaicked',anglestr{1})));
imwrite(polarlist(:,:,2),fullfile(output_path,strrep([name0,nativeext],'mosaicked',anglestr{2})));
imwrite(polarlist(:,:,3),fullfile(output_path,strrep([name0,nativeext],'mosaicked',anglestr{3})));
imwrite(polarlist(:,:,4),fullfile(output_path,strrep([name0,nativeext],'mosaicked',anglestr{4})));
%% compare restoration
pathlist = cellfun(@(x)strrep(gtpath,['_',laststr],['_',x]),anglestr,'UniformOutput',false);
img_gts = cellfun(@(x)im2double(imread(x)),pathlist,'UniformOutput',false);

img_gtlist = cat(3, img_gts{:});
[metrics_psnr,metrics_ssim,metrics_psnr_stokes,metrics_ssim_stokes] = ...
    monometrics(polarlist,img_gtlist,anglelist,edgesize,false);
%% save metrics
name = getitemname(rawpath);
datacrp = {name,methodname,metrics_psnr,metrics_psnr_stokes,metrics_ssim,metrics_ssim_stokes};
writecell(datacrp,riqapath,'WriteMode','append');
end
disp('done')
disp(datetime)
%% show mean average
[a,b] = showthismean(riqapath,anglelist);