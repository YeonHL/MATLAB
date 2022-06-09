clear all
close all


%% 초기값

% 1월 2주차 ~ 5월 4주차 전국 확진자 수 데이터 (만 단위)
y_real = [2.7818 4.1748 9.4766 18.1104 34.0991
    61.2248 103.2066 146.1474 210.0273 281.7199
    244.2853 205.8896 145.9822 97.2307 58.9666
    38.0604 26.7036 23.7754 17.5780 12.2702];

% beta, gamma의 초기값
beta = 0.0003226189;
gamma = 1;

% 1월 2주차의 S, I, R 데이터
y0 = [2.7818; 48.6038; 5131.5167];

% 사용한 실제 데이터가 총 20주차이므로 t의 범위를 1~20으로 지정
tspan = [1:1:20];

% 초기 SIR 모델 생성
[t,y] = ode45(@(t,y) odefcn(t,y,beta,gamma), tspan, y0);

% RMSE 행렬 생성 (범위를 고정시키기 위함)
RMSE = zeros(1,20); 
RMSE_sum = 0;

% RMSE 계산
for b=1:1:20
    RMSE(b) = sqrt((y_real(b) - y(b))^2);
    RMSE_sum = RMSE_sum + 3^-(20-b) * RMSE(b);
end

% 계산 및 저장을 위한 변수의 초기값 지정
gamma_est = gamma;
gamma_save = gamma;
RMSE_save = RMSE;

% RMSE의 평균을 저장할 변수의 초기값 지정
RMSE_save_avg = RMSE_sum / 20;


%% 학습

% gamma를 1부터 2.5까지 0.01 단위로 증가
for j = 1:1:150
    
    % gamma에 따른 최적값도 구하기 위해 beta를 초기값으로 지정
    beta_est = beta;

    % beta를 바꿔가면서 최적값 찾기, 0.0003226189부터 0.0005226189까지 10^-8 단위로 이동
    for i=1:1:20000
        
        % beta_est 증가
        beta_est = beta_est + 10^-8;
    
        % beta_est가 증가했을 때의 확진자 수 구하기
        [t,y] = ode45(@(t,y) odefcn(t,y,beta_est,gamma_est), tspan, y0);
        
        % RMSE_sum을 구하기 위한 초기값 지정
        RMSE_sum = 0;

        % beta_est가 증가했을 때와의 RMSE 계산
        for b=1:1:20
            RMSE(b) = sqrt((y_real(b) - y(b))^2);
            RMSE_sum = RMSE_sum + 3^-(20-b) * RMSE(b);
        end
        
        % 오차 계산에 사용할 주차의 데이터 및 가중치 설정
        RMSE_avg = RMSE_sum / 20;
        
        % 기존에 저장한 값보다 오차가 더 적게 나타날 경우 그 값을 저장
        if RMSE_save_avg > RMSE_avg
            beta_save = beta_est;
            gamma_save = gamma_est;
            RMSE_save_avg = RMSE_avg;
        end
    end
    
    % gamma_est 증가
    gamma_est = gamma_est + 0.01;
end

%% 결과 확인

% 예측을 위한 이후의 3주까지 범위로 지정
tspan = [1:1:23];

% 앞에서 RMSE가 가장 적게 나타났던 beta와 gamma로 SIR 모델 계산
[t,y] = ode45(@(t,y) odefcn(t,y, beta_save,gamma_save), tspan, y0);
plot(t,y,'-o')
legend("I(t)",  "R(t)", "S(t)")