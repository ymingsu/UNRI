function [ssimval, ssimmap] = cvssim(varargin)
%SSIM 此处显示有关此函数的摘要
%   此处显示详细说明

narginchk(2,12);

args = matlab.images.internal.stringToChar(varargin);

[A, ref, C, exponents, radius, filtSize, dataformat] = ssimComplexParseInputs_c2r(args{:});
 
% Validate ndims of A differently depending on whether or not DataFormat
% specified to preserve behavior pre introduction of DataFormat Name/Value.
if isempty(dataformat)
    if (ndims(A) > 3)
        error(message('images:ssim:supportedDimsUnformattedInput'))
    else
        dataformat = repmat('S',1,ndims(A));
    end
else
    if (sum(dataformat == 'S') > 3) || (sum(dataformat == 'S') < 2)
        error(message('images:ssim:unsupportedDataFormatSpatialDims')); 
    end
end

if isempty(A)
    ssimval = zeros(0, 'like', A);
    ssimmap = A;
    return;
end

numSpatialDims = sum(dataformat == 'S');
if numSpatialDims == 2
    gaussFilterFcn = @(X)imgaussfilt_c2r(X, radius, 'FilterSize', filtSize, 'Padding','replicate');
elseif numSpatialDims == 3
    gaussFilterFcn = @(X) spatialGaussianFilter(X, double(radius), double(filtSize), 'replicate');
else
    assert(false,'Unexpected number of spatial dimensions.');
end

[ssimval,ssimmap] = ssimalgo_c2r(A,ref,gaussFilterFcn,exponents,C,numSpatialDims);

end

function A = spatialGaussianFilter(A, sigma, hsize, padding)
[hCol,hRow,hSlc] = createSeparableGaussianKernel(sigma, hsize);

A = imfilter(A, hRow, padding, 'conv', 'same');
A = imfilter(A, hCol, padding, 'conv', 'same');
A = imfilter(A, hSlc, padding, 'conv', 'same'); 
end

function [hcol,hrow,hslc] = createSeparableGaussianKernel(sigma, hsize)

hcol = images.internal.createGaussianKernel(sigma(1), hsize(1));
hrow = reshape(hcol,1,[]);
hslc = reshape(hcol,1,1,[]);
end

