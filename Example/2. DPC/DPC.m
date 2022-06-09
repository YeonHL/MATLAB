clear;
close all;

n = 4; % number of receivers

G = [1 0.1 0.2 0.3; 0.2 1 0.1 0.1; 0.2 0.1 1 0.1; 0.1 0.1 0.1 1] % channel gains

max_iteration = 30;

p = ones(n,max_iteration+1); % power (initially, 1mW)
SIR = zeros(n,max_iteration);
gamma = [2 2.5 1.5 2]; % target SIRs

noise = 0.1; % mW

for iteration = 2:max_iteration+1
    for i=1:n
          SIR(i,iteration-1)=(G(i,i)*p(i,iteration-1))/(G(i,[1:i-1, i+1:n])*p([1:i-1, i+1:n],iteration-1) + noise)
          p(i,iteration)=((gamma(i)*p(i,iteration-1))/SIR(i,iteration-1))
    end
    %% IMPLEMENT DISTRIBUTED POWER CONTROL %%
end

figure(1);
plot(p')
xlabel('iteration');
ylabel('power (mW)');
legend('link 1', 'link 2', 'link 3', 'link 4');

figure(2);
plot(SIR')
xlabel('iteration');
ylabel('SIR');
legend('link 1', 'link 2', 'link 3', 'link 4');
