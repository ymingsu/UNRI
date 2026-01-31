function [output,varargout] = residual_interpolation3(guide, mosaic, mask, eps,winsize,F,H)

if nargin <5
winsize=13;
end
% parameters for guided upsampling
h = winsize;
v = winsize;

if nargin <6
% Laplacian
F = -[ -1, 0,-1, 0, -1;
      0, 0, 0, 0, 0;
     -1, 0, 8, 0,-1;
      0, 0, 0, 0, 0;
      -1, 0,-1, 0, -1]/16;
end
if nargin <7
H = [1/4, 1/2, 1/4;
     1/2,  1 , 1/2;
     1/4, 1/2, 1/4];
end

lap_input = imfilter(mosaic, F, 'replicate');
lap_guide = imfilter(guide.*mask, F, 'replicate');

% residual interpolation
[tentative,dif] = guidedfilter_MLRI_wei(guide, mosaic, mask, lap_guide, lap_input, mask, h, v, eps);
tentative = clip(tentative,0,1);
residual0 = mask.*(mosaic-tentative);

% Bilinear interpoaltion
residual = imfilter(residual0, H, 'replicate');
output = residual + tentative;
varargout{1} = dif;
varargout{2} = residual0;
varargout{3} = tentative;
end
