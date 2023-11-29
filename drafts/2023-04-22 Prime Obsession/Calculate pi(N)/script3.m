clc,clear,close all

primes1 = primes(10^9);
num1 = numel(primes1);
disp('done')

for i = 10^9+1:2:20^9
    isp = all(rem(i, primes1(primes1<=sqrt(i))));
    num1 = num1+isp;
end
