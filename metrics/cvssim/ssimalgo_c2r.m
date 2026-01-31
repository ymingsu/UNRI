function [ssimval,ssimmap] = ssimalgo_c2r(A,ref,gaussFilterFcn,exponents,C,numSpatialDims)

%   Copyright 2021 The MathWorks, Inc. 

% Weighted-mean and weighted-variance computations
mux2 = gaussFilterFcn(A);
muy2 = gaussFilterFcn(ref);
muxy = (mux2.*conj(muy2)+muy2.*conj(mux2))/2;
mux2 = mux2.*conj(mux2);
muy2 = muy2.*conj(muy2);

% Clamp to zero. Floating point math sometimes makes this negative
sigmax2 = max(gaussFilterFcn(A.*conj(A)) - mux2,0);
sigmay2 = max(gaussFilterFcn(ref.*conj(ref)) - muy2,0);

% sigmaxy = max((gaussFilterFcn(A.*conj(ref)) + gaussFilterFcn(ref.*conj(A)))/2 - muxy,0);
sigmaxy = max(gaussFilterFcn((A.*conj(ref)+ref.*conj(A))/2) - muxy,0);
% muxy=abs(muxy);
% Compute SSIM index
if (C(3) == C(2)/2) && isequal(exponents(:),ones(3,1))
    % Special case: Equation 13 from [1]
    num = (2*muxy + C(1)).*(2*sigmaxy + C(2));
    den = (mux2 + muy2 + C(1)).*(sigmax2 + sigmay2 + C(2));
    if (C(1) > 0) && (C(2) > 0)
        ssimmap = num./den;
    else
        % Need to guard against divide-by-zero if either C(1) or C(2) is 0.
        isDenNonZero = (den ~= 0);
        ssimmap = ones(size(A));
        ssimmap(isDenNonZero) = num(isDenNonZero)./den(isDenNonZero);
    end

else
    % General case: Equation 12 from [1]
    % Luminance term
    if (exponents(1) > 0)
        num = 2*muxy + C(1);
        den = mux2 + muy2 + C(1);
        ssimmap = guardedDivideAndExponent(num,den,C(1),exponents(1));
    else
        ssimmap = ones(size(A), 'like', A);
    end

    % Contrast term
    sigmaxsigmay = [];
    if (exponents(2) > 0)
        sigmaxsigmay = sqrt(sigmax2.*sigmay2);
        num = 2*sigmaxsigmay + C(2);
        den = sigmax2 + sigmay2 + C(2);
        ssimmap = ssimmap.*guardedDivideAndExponent(num,den,C(2),exponents(2));
    end

    % Structure term
    if (exponents(3) > 0)
        num = sigmaxy + C(3);
        if isempty(sigmaxsigmay)
            sigmaxsigmay = sqrt(sigmax2.*sigmay2);
        end
        den = sigmaxsigmay + C(3);
        ssimmap = ssimmap.*guardedDivideAndExponent(num,den,C(3),exponents(3));
    end

end

ssimval = mean(ssimmap,1:numSpatialDims);

end

% -------------------------------------------------------------------------
function component = guardedDivideAndExponent(num, den, C, exponent)

if C > 0
    component = num./den;
else
    component = ones(size(num),'like',num);
    isDenNonZero = (den ~= 0);
    component(isDenNonZero) = num(isDenNonZero)./den(isDenNonZero);
end

if exponent~=floor(exponent) 
    % This deviates from the authors implementation. Raising a negative
    % value to non integer exponents result in complex values. Clamp this
    % to 0 to workaround this edge case.
    component = max(component,0);
end

if(exponent ~= 1)
    component = component.^exponent;
end

end