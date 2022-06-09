clear all
close all


%% 초기값

% 주당 확진자 수 실제 데이터 (만 단위)
y_real = [0.0406 0.0791 0.2415 0.4935 0.8918 1.7605 2.7055 3.5533 5.1604 7.1561 7.2485 6.0767 4.8174 3.4069 1.9929 1.3146 0.9345 0.7910 0.3234];

% beta, gamma의 초기값
beta = 0.001;
gamma = 0.01;

% 1월 2주차의 데이터
y0 = [0.0406; 0.9866; 145.361];

% 지역 데이터가 총 19주차이므로 t의 범위를 1~19으로 지정
tspan = [1:1:19];

% 초기 SIR 모델 생성
[t,y] = ode45(@(t,y) odefcn(t,y,beta,gamma), tspan, y0);

% RMSE 행렬 생성 (범위를 고정시키기 위함)
RMSE = zeros(1,19); 
RMSE_sum = 0;

% RMSE 계산
for b=1:1:19
    RMSE(b) = sqrt((y_real(b) - y(b))^2);
    RMSE_sum = RMSE_sum + 2^-(19-b) * RMSE(b);
end

% 계산 및 저장을 위한 초기값 지정
gamma_est = gamma;
gamma_save = gamma;
RMSE_save = RMSE;

% 오차 계산에 사용할 주차의 데이터 및 가중치 설정
RMSE_save_sum = RMSE_sum / 19;


%% 학습

% gamma를 1부터 2.5까지 0.01 단위로 증가
for j = 1:1:250
    
    % gamma에 따른 최적값도 구하기 위해 beta를 초기값으로 지정
    beta_est = beta;

    % beta를 바꿔가면서 최적값 찾기, 0.0003226189부터 0.0005226189까지 10^-8 단위로 이동
    for i=1:1:300
        
        % beta_est 증가
        beta_est = beta_est + 10^-3;
    
        % beta_est가 증가했을 때의 확진자 수 구하기
        [t,y] = ode45(@(t,y) odefcn(t,y,beta_est,gamma_est), tspan, y0);
        RMSE_prev = RMSE;
        RMSE_sum = 0;

        % beta_est가 증가했을 때와의 RMSE 계산
        for b=1:1:19
            RMSE(b) = sqrt((y_real(b) - y(b))^2);
            RMSE_sum = RMSE_sum + 3^-(19-b) * RMSE(b);
        end
        
        % 오차 계산에 사용할 주차의 데이터 및 가중치 설정
        RMSE_sum = RMSE_sum / 19;
        
        % 기존에 저장한 값보다 오차가 더 적게 나타날 경우 그 값을 저장
        if RMSE_save_sum > RMSE_sum
            beta_save = beta_est;
            gamma_save = gamma_est;
            RMSE_save_sum = RMSE_sum;
        end
    end
    
    % gamma_est 증가
    gamma_est = gamma_est + 0.01;
end

% 예측을 위한 이후의 3주까지 범위로 지정
tspan = [1:1:23];

% 앞에서 RMSE가 가장 적게 나타났던 beta와 gamma로 SIR 모델 계산
[t,y] = ode45(@(t,y) odefcn(t,y, beta_save,gamma_save), tspan, y0);
plot(t,y,'-o')
[y(17) y(18) y(19) y(20) y(21) y(22)]