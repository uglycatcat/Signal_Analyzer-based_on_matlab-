% 设置参数
Fs = 1000;  % 采样频率 (Hz)
t = 0:1/Fs:1;  % 时间向量 (1秒)

% 调制信号 (低频信号)
Am = 1;    % 调制信号的幅度
fm = 5;    % 调制信号的频率 (Hz)
modulating_signal = Am * sin(2 * pi * fm * t);  % 调制信号

% 载波信号 (高频信号)
Ac = 1;    % 载波信号的幅度
fc = 50;   % 载波信号的频率 (Hz)
carrier_signal = Ac * sin(2 * pi * fc * t);  % 载波信号

% 调幅信号 (AM)
mu = 0.7;  % 调制指数 (mu <= 1 表示没有过调制)
am_signal = (1 + mu * modulating_signal) .* carrier_signal;  % AM信号

% 添加噪声（可选）
noisy_am_signal = am_signal + 0.1 * randn(size(am_signal));  % 含噪声信号

% 绘制调幅信号
figure;
subplot(3, 1, 1);
plot(t, noisy_am_signal);
title('Received AM Signal (With Noise)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% 同步解调过程
local_carrier = Ac * sin(2 * pi * fc * t);  % 本地产生的载波 (与原始载波同步)
demodulated_signal = noisy_am_signal .* local_carrier;  % 与载波相乘进行混频

% 低通滤波器提取基带信号
[b, a] = butter(5, fc/(Fs/2), 'low');  % 设计低通滤波器
recovered_signal = filter(b, a, demodulated_signal);  % 滤波器提取调制信号

% 绘制解调后的信号
subplot(3, 1, 2);
plot(t, demodulated_signal);
title('Demodulated Signal (Before Filtering)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3, 1, 3);
plot(t, recovered_signal);
title('Recovered Modulating Signal (After Low-pass Filtering)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
