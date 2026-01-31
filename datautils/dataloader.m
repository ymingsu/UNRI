function [png0Files,png45Files,png90Files,png135Files,varargout] = dataloader(dataname)
%DATALOADER 此处显示有关此函数的摘要
%   此处显示详细说明
if nargin<1
    dataname = 'VMV';
end
if strcmpi(dataname,'TokyoTech')
    gtdirpath = 'D:\Datasets\TokyoTech\png';
    ext = '45.png';
    png45Files = getallext(gtdirpath,ext)';
    png0Files = cellfun(@(x)strrep(x,'45.png','0.png'),png45Files,'UniformOutput',false);
    png90Files = cellfun(@(x)strrep(x,'45.png','90.png'),png45Files,'UniformOutput',false);
    png135Files = cellfun(@(x)strrep(x,'45.png','135.png'),png45Files,'UniformOutput',false);
    namecell = cellfun(@(x)getname(x,5),png45Files,'UniformOutput',false);
elseif strcmpi(dataname,'OLCPDNet')
    gtdirpath = 'D:\Datasets\OLCPDNet\OL';
    ext = '.png';
    pngsFiles = getallext(gtdirpath,ext)';
    searchtext = 'gt_45';
    png45Filesind = cellfun(@(x)contains(x,searchtext),pngsFiles);
    png45Files=pngsFiles(png45Filesind);
    png0Files = cellfun(@(x)strrep(x,searchtext,'gt_0'),png45Files,'UniformOutput',false);
    png90Files = cellfun(@(x)strrep(x,searchtext,'gt_90'),png45Files,'UniformOutput',false);
    png135Files = cellfun(@(x)strrep(x,searchtext,'gt_135'),png45Files,'UniformOutput',false);
    namecell = cellfun(@(x)getname(x,5),png45Files,'UniformOutput',false);
elseif strcmpi(dataname,'VMV')
    gtdirpath = 'D:\Datasets\VMV-dataset\png';
    ext = '45.png';
    png45Files = getallext(gtdirpath,ext)';
    png0Files = cellfun(@(x)strrep(x,'45.png','0.png'),png45Files,'UniformOutput',false);
    png90Files = cellfun(@(x)strrep(x,'45.png','90.png'),png45Files,'UniformOutput',false);
    png135Files = cellfun(@(x)strrep(x,'45.png','135.png'),png45Files,'UniformOutput',false);
    namecell = cellfun(@(x)getname(x,5),png45Files,'UniformOutput',false);
elseif strcmpi(dataname,'TIP')||strcmpi(dataname,'TIPmono')
    gtdirpath = 'D:\Datasets\TIP_raw_dataset\TIP_dataset';
    ext = '45-G.bmp';
    png45Files = getallext(gtdirpath,ext)';
    png0Files = cellfun(@(x)strrep(x,'45-G.bmp','0-G.bmp'),png45Files,'UniformOutput',false);
    png90Files = cellfun(@(x)strrep(x,'45-G.bmp','90-G.bmp'),png45Files,'UniformOutput',false);
    png135Files = cellfun(@(x)strrep(x,'45-G.bmp','135-G.bmp'),png45Files,'UniformOutput',false);
    namecell = cellfun(@(x)getnamefromtip(x,5),png45Files,'UniformOutput',false);
elseif strcmpi(dataname,'TIPColor')
    gtdirpath = 'D:\Datasets\TIPperPolarChannalDataset\data1\test';
    ext = '45.png';
    png45Files = getallext(gtdirpath,ext)';
    png0Files = cellfun(@(x)strrep(x,'45.png','0.png'),png45Files,'UniformOutput',false);
    png90Files = cellfun(@(x)strrep(x,'45.png','90.png'),png45Files,'UniformOutput',false);
    png135Files = cellfun(@(x)strrep(x,'45.png','135.png'),png45Files,'UniformOutput',false);
    namecell = cellfun(@(x)getnamefromtip(x,6),png45Files,'UniformOutput',false);
end
varargout{1}=namecell;
end