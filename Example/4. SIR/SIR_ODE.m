clear all
close all

beta = 1;
gamma = 0.1;

S = [0.99];
I = [0.01];
R = [0];

%% SI model

% n = 15;

% tspan = [0,n];
% y0 = [0.01; 0.99];

% [t,y] = ode45(@dydt, tspan, y0);

% plot(t,y,'-o')

%% SIR Model

n = 60;

tspan = [0,n];
y0 = [0.01; 0; 0.99];

[t,y] = ode45(@dydt, tspan, y0);

plot(t,y,'-o')



