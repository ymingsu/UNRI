close all;
% clear;
clearvars -except dataname anglelist Panglelist datanamelist pali dni bForceUpdate;
% anglelist = {pi/2,pi/4,3*pi/4,0}; %eari pattern;A1
% anglelist = {0,pi/4,3*pi/4,pi/2}; %npid pattern;A2
% anglelist = {pi/4,3*pi/4,pi/2,0};% icpc pattern;A3
% anglelist = {0,pi/3,pi*2/3,'iun'};%A4
anglelist = {0,pi/3,pi*2/3,0};%A5

dataname = 'TokyoTech';%%'TokyoTech';%'TIP'%
anglestr = anglelist2str(anglelist);
angleallstr = strjoin(anglestr,'');

[png0Files,png45Files,png90Files,png135Files,namecell] = dataloader(dataname);

kind=['mono',angleallstr];%color%mono
savedirparentpath = 'D:\Dataset\Mosaicked';
savepath = fullfile(savedirparentpath,dataname,kind);
checkdir(savepath,true,false);
gtsavepath = fullfile(savepath,'gt');
checkdir(gtsavepath,true,false);
rawsavepath = fullfile(savepath,'raw');
checkdir(rawsavepath,true,false);
if ~exist('bForceUpdate','var')
    bForceUpdate = false;
end
bHaveMosaicked =  length(getallext(rawsavepath,'.png'))==length(png0Files);
if  ~bHaveMosaicked||bForceUpdate
    disp('Mosaicking')
    parfor index =1:length(png0Files)%1%
%         disp(num2str(index))
        png0 = png0Files{index};
        png45 = png45Files{index};
        png90 = png90Files{index};
        png135 = png135Files{index};
        img0 = im2double(imread(png0));
        img45 = im2double(imread(png45));
        img90 = im2double(imread(png90));
        img135 = im2double(imread(png135));
        imgall = cat(4,img0,img45,img90,img135);
        % sizeimgall = size(imgall)
        % 将imgall的四个维度的顺序调整为[4,1,2,3]
        imgall = permute(imgall,[4,1,2,3]);
        % sizeimgallpermute = size(imgall)
        Amat = anglelist2Amatrix({0,pi/4,pi/2,3*pi/4});
        Stokes = pagemldivide(Amat,imgall);
        % sizeStokes = size(Stokes)
        [Amatrix] = anglelist2Amatrix(anglelist);
        imgallnew = pagemtimes(Amatrix,Stokes);
%         sizeimgallnew = size(imgallnew);
        if size(imgallnew,4)>1
            imgallnewgreen = squeeze(imgallnew(:,:,:,2));
        else
            imgallnewgreen = squeeze(imgallnew(:,:,:,1));
        end
        sizeimgallnewgreen = size(imgallnewgreen);
        [mask] = maskofpol(sizeimgallnewgreen(2),sizeimgallnewgreen(3));
        mask = permute(mask,[3,1,2]);
        img_mosaicked = squeeze(sum(mask.*imgallnewgreen,1));
        item_name = namecell{index};
        mosaickedpath = fullfile(rawsavepath,[item_name,'_mosaicked.png']);
        imwrite(img_mosaicked,mosaickedpath);
        anglestr = anglelist2str(anglelist);
        for iind =1:4
            a1path = fullfile(gtsavepath, [item_name, '_', anglestr{iind}, '.png']);
            imwrite(squeeze(imgallnewgreen(iind,:,:)),a1path);
        end
    end
else
    disp('skip Mosaicked')
end