clc, clear, close all

L = @(x1, x2, lambda, nu) -x1+x2.^2+lambda*(x1.^2+x2.^2-4)+nu*(x1+x2-2);

x = [0, 2; 0.5, 1.5; 1, 1; 1.5, 0.5; 2, 0; 
    -9999, -9999; -9999, -2; -9999, -1; -9999, 0; -9999, 1; -9999, 2;
    -9999, 9999; -2, 9999; -1, 9999; 0, 9999; 1, 9999; 2, 9999;
    9999, 9999; 9999, 2; 9999, 1; 9999, 0; 9999, -1; 9999, -2;
    9999, -9999; 2, -9999; 1, -9999; 0, -9999; -1, -9999; -2, -9999];

lambda_nu = [
    0, 0; 0, 1; 0, 2; 0, 9999;
    1, 0; 1, 1; 1, 2; 1, 9999;
    2, 0; 2, 1; 2, 2; 2, 9999;
    9999, 0; 9999, 1; 9999, 2; 9999, 9999];

L_values = zeros(height(x),height(lambda_nu));

for i = 1:height(L_values)
    for j = 1:width(L_values)
        L_values(i, j) = L(x(i,1), x(i, 2), lambda_nu(j, 1), lambda_nu(j, 2));
    end
end

p_star = min(max(L_values, [], 2));
d_star = max(min(L_values));
