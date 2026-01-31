function abc = coefficient_getter(alpha,beta,gamma)
%AGETTER 此处显示有关此函数的摘要
%   此处显示详细说明
if isnumeric(alpha)&&isnumeric(beta)&&isnumeric(gamma)
    a = 1/2*cos(beta - gamma)* csc(alpha - beta) *csc(alpha - gamma);
    b = 1/2*cos(alpha - gamma)* csc(beta - alpha) *csc(beta - gamma);
    c = 1/2*cos(alpha - beta)* csc(gamma - alpha) *csc(gamma- beta);
elseif strcmpi(alpha,'iun')%alpha=='iun'
    a=1;b=0;c=0;
elseif strcmpi(beta,'iun')%beta=='iun'
    a=0;b=1;c=0;
elseif strcmpi(gamma,'iun')%gamma=='iun'
    a=0;b=0;c=1;
elseif strcmpi(alpha,'s0')%alpha=='s0'
    a=1/2;b=0;c=0;
elseif strcmpi(beta,'s0')%beta=='s0'
    a=0;b=1/2;c=0;
elseif strcmpi(gamma,'s0')%gamma=='s0'
    a=0;b=0;c=1/2;
end
abc = [a,b,c]*2;
end

