function [Microgrid_im] = rearrange4polardemosaic(images_color,height,width)
%REARRANGE4POLARDEMOSAIC 此处显示有关此函数的摘要
%   此处显示详细说明
    Microgrid_im=zeros(height,width,3);
    [matPolar] = polarpattern();
    for idx=1:4
        [row,col] = find(matPolar(:,:,idx)==1);
        Microgrid_im(row(1):2:end,col(1):2:end,:)=images_color{idx};
    end
end

