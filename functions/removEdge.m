function [dest_img] = removEdge(img,edgesize)
%UNTITLED3 此处提供此函数的摘要
%   此处提供详细说明
if nargin<2
    edgesize=15;
end
if edgesize<0
    edgesize=-edgesize;
end

if length(size(img))==2
dest_img=img(1+edgesize:end-edgesize,1+edgesize:end-edgesize);
elseif length(size(img))==3
dest_img=img(1+edgesize:end-edgesize,1+edgesize:end-edgesize,:);
elseif length(size(img))==4
dest_img=img(1+edgesize:end-edgesize,1+edgesize:end-edgesize,:,:);
end
end