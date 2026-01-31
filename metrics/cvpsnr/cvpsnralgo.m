function [peaksnr, snr] = cvpsnralgo(A, ref, peakval,hasBatchDim,logFcn)
%   [PEAKSNR,SNR] = PSNRALGO(A, REF, PEAKVAL) uses PEAKVAL as the peak signal value
%   for calculating the peak signal-to-noise ratio.

%   Copyright 2020 The MathWorks, Inc.

if ~hasBatchDim
   dimsToReduce = 1:ndims(A); 
else
   dimsToReduce = 1:ndims(A)-1;
end

if isempty(A) % If A is empty, ref must also be empty
    peaksnr = zeros(0, 'like', A);
    snr     = zeros(0, 'like', A);
    return;
end

if isinteger(A)
    A = double(A);
    ref = double(ref);
end

sizeA = size(A);
err = sum((A-ref).*conj(A-ref),dimsToReduce) ./ prod(sizeA(dimsToReduce));

peaksnr = 10*logFcn(peakval.^2./err);

if nargout > 1
    if isinteger(ref)
        ref = double(ref);
    end
    snr = 10*logFcn(mean(abs(ref).^2,dimsToReduce)./err);
end

end
