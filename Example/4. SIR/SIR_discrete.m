clear all
close all

beta = 1;
gamma = 0.1;

n = 60;

S = zeros(1,n);
I = zeros(1,n);
R = zeros(1,n);

S(1) = 0.99;
I(1) = 0.01;
% R(1) = 0

for i=1:n-1
    I(i+1) = (beta * S(i) - gamma + 1) * I(i);
    R(i+1) = gamma * I(i) + R(i);
    S(i+1) = S(i) + I(i) + R(i) - I(i+1) - R(i+1);
end

t = [1 : 1 : n];

plot (t,S)
hold on
plot (t,I)
plot (t,R)
title('SIR Model');
xlabel('t')
ylabel('')
legend("S(t)","I(t)","R(t)")
