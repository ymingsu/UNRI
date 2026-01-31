function [A, ref, C, exponents, radius, filtSize, dataformat] = ssimComplexParseInputs_c2r(varargin)

%   Copyright 2021 The MathWorks, Inc. 

validImageTypes = {'uint8','uint16','int16','single','double','dlarray'};

A = varargin{1};
validateattributes(A,validImageTypes,{'nonsparse'},'ssim','A',1);

ref = varargin{2};
validateattributes(ref,validImageTypes,{'nonsparse'},'ssim','REF',2);

if ~isequal(underlyingType(A),underlyingType(ref))
    error(message('images:validate:differentClassMatrices','A','REF'));
end

if ~isequal(size(A),size(ref))
    error(message('images:validate:unequalSizeMatrices','A','REF'));
end

% Default values for parameters
dynmRange = diff(getrangefromclass(A));
C = [];
exponents = [1 1 1];
radius = 1.5;
dataformat = '';

args_names = {'dynamicrange', 'regularizationconstants','exponents',...
              'radius','dataformat'};

for i = 3:2:nargin
    arg = varargin{i};
    if ischar(arg)
        idx = find(strncmpi(arg, args_names, numel(arg)));
        if isempty(idx)
            error(message('images:validate:unknownInputString', arg))

        elseif numel(idx) > 1
            error(message('images:validate:ambiguousInputString', arg))

        elseif numel(idx) == 1
            if (i+1 > nargin)
                error(message('images:validate:missingParameterValue'));
            end
            if idx == 1
                dynmRange = varargin{i+1};
                validateattributes(dynmRange,{'numeric'},{'positive', ...
                    'finite', 'real', 'nonempty','scalar'}, 'ssim', ...
                    'DynamicRange',i);
                dynmRange = double(dynmRange);

            elseif idx == 2
                C = varargin{i+1};
                validateattributes(C,{'numeric'},{'nonnegative','finite', ...
                    'real','nonempty','vector', 'numel', 3}, 'ssim', ...
                    'RegularizationConstants',i);
                C = double(C);

            elseif idx == 3
                exponents = varargin{i+1};
                validateattributes(exponents,{'numeric'},{'nonnegative', ...
                    'finite', 'real', 'nonempty','vector', 'numel', 3}, ...
                    'ssim','Exponents',i);
                exponents = double(exponents);

            elseif idx == 4
                radius = varargin{i+1};
                validateattributes(radius,{'numeric'},{'positive','finite', ...
                    'real', 'nonempty','scalar'}, 'ssim','Radius',i);
                radius = double(radius);
            elseif idx == 5
                dataformat = varargin{i+1};
                images.internal.qualitymetric.validateDataFormat(dataformat);
            end
        end
    else
        error(message('images:validate:mustBeString'));
    end
end

% If 'RegularizationConstants' is not specified, choose default C.
if isempty(C)
    C = [(0.01*dynmRange).^2 (0.03*dynmRange).^2 ((0.03*dynmRange).^2)/2];
end

% Manage casting and shifting integer inputs
if isa(A,'int16') % int16 is the only allowed signed-integer type for A and ref.
    % Add offset for signed-integer types to bring values in the
    % non-negative range.
    A = double(A) - double(intmin('int16'));
    ref = double(ref) - double(intmin('int16'));
elseif isinteger(A)
    A = double(A);
    ref = double(ref);
end

% Compute filter radius and size from radius Name/Value
filtRadius = ceil(radius*3); % 3 Standard deviations include >99% of the area.
filtSize = 2*filtRadius + 1;

end
