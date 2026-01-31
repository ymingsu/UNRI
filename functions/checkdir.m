function [bIsCreated]=checkdir(path,bCreateIfNotExist,bShowAlarm)
%CHECKDIR 此处显示有关此函数的摘要
%   此处显示详细说明
if nargin<2
    bCreateIfNotExist=true;
    bShowAlarm=true;
elseif nargin<3
    bShowAlarm=true;
end
bIsCreated=false;
if ~exist(path,"dir")
    if bShowAlarm
    assert(bCreateIfNotExist,'PathDir is not Exist');
    end
    if bCreateIfNotExist
        bIsCreated=mkdir(path);
    end
end

