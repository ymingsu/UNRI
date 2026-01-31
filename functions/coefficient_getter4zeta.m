function [abc] = coefficient_getter4zeta(alpha,beta,gamma,zeta)
%COEFFICIENT_GETTER4ZETA 此处显示有关此函数的摘要
%   此处显示详细说明
if isnumeric(alpha)&&isnumeric(beta)&&isnumeric(gamma)&&isnumeric(zeta)
    a=csc(alpha-beta).* csc(alpha-gamma).* sin(beta-zeta).* sin(gamma-zeta);
    b=-csc(alpha-beta).*sin(alpha-zeta).*csc(beta-gamma).*sin(gamma-zeta);
    c=csc(alpha-gamma).*sin(alpha-zeta).*csc(beta-gamma).*sin(beta-zeta);
elseif isnumeric(alpha)&&isnumeric(beta)&&isnumeric(gamma)&&strcmpi(zeta,'iun')
    a = 1/2*cos(beta - gamma)* csc(alpha - beta) *csc(alpha - gamma);
    b = 1/2*cos(alpha - gamma)* csc(beta - alpha) *csc(beta - gamma);
    c = 1/2*cos(alpha - beta)* csc(gamma - alpha) *csc(gamma- beta);
elseif isnumeric(zeta)&&isnumeric(beta)&&isnumeric(gamma)&&strcmpi(alpha,'iun')
    [a,b,c] = coefficient_getter4zetawhenalphaisiun(beta,gamma,zeta);
elseif isnumeric(zeta)&&isnumeric(alpha)&&isnumeric(gamma)&&strcmpi(beta,'iun')
    [b,a,c] = coefficient_getter4zetawhenalphaisiun(alpha,gamma,zeta);
elseif isnumeric(zeta)&&isnumeric(alpha)&&isnumeric(beta)&&strcmpi(gamma,'iun')
    [c,b,a] = coefficient_getter4zetawhenalphaisiun(alpha,beta,zeta);
end
abc=[a,b,c];
end
function [a,b,c] = coefficient_getter4zetawhenalphaisiun(beta,gamma,zeta)
    a=2* sec(beta-gamma).*sin(beta-zeta).*sin(gamma-zeta);%for iun
    b=-csc(2.*(beta-gamma)).*sin(2.*(gamma-zeta));% for 2nd  angle beta
    c=csc(2.*(beta-gamma)).*sin(2.*(beta-zeta));% for 3rd angle gamma
end