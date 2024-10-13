%信号调幅演示

% 调制信号和载波信号参数
Fs = 1000;  % 采样频率 (Hz)
t = 0:1/Fs:1;  % 时间向量 (1秒)

% 调制信号 (低频信号)
Am = 1;  % 调制信号的幅度
fm = 5;  % 调制信号的频率 (Hz)
modulating_signal = Am * sin(2 * pi * fm * t);  % 调制信号

% 载波信号 (高频信号)
Ac = 1;  % 载波信号的幅度
fc = 50; % 载波信号的频率 (Hz)
carrier_signal = Ac * sin(2 * pi * fc * t);  % 载波信号

% 调幅信号 (AM)
mu = 0.5;  % 调制指数 (mu <= 1 表示不发生过调制)
am_signal = (1 + mu * modulating_signal) .* carrier_signal;

% 绘制结果
figure;

% 绘制调制信号
subplot(3, 1, 1);
plot(t, modulating_signal);
title('调制信号（低频）');
xlabel('时间 (s)');
ylabel('幅度');
grid on;

% 绘制载波信号
subplot(3, 1, 2);
plot(t, carrier_signal);
title('载波信号（高频）');
xlabel('时间 (s)');
ylabel('幅度');
grid on;

% 绘制调幅信号
subplot(3, 1, 3);
plot(t, am_signal);
title('调幅（AM）信号');
xlabel('时间 (s)');
ylabel('幅度');
grid on;
