%用于整流检波解调的演示

% 设置参数
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
mu = 0.5;  % 调制指数 (mu <= 1 表示没有过调制)
am_signal = (1 + mu * modulating_signal) .* carrier_signal;  % AM信号

% 添加噪声（可选）
noisy_am_signal = am_signal + 0.1 * randn(size(am_signal));  % 含噪声的AM信号

% 绘制AM信号
figure;
subplot(3, 1, 1);
plot(t, noisy_am_signal);
title('接收到的AM信号（有噪声）');
xlabel('时间 (s)');
ylabel('幅度');
grid on;

% 整流 (取绝对值)
rectified_signal = abs(noisy_am_signal);  % 对信号进行整流（取绝对值）

% 低通滤波提取调制信号
[b, a] = butter(5, fm/(Fs/2), 'low');  % 设计低通滤波器
recovered_signal = filter(b, a, rectified_signal);  % 滤波器提取调制信号

% 绘制整流后的信号
subplot(3, 1, 2);
plot(t, rectified_signal);
title('整流信号');
xlabel('时间 (s)');
ylabel('幅度');
grid on;

% 绘制解调后的信号
subplot(3, 1, 3);
plot(t, recovered_signal);
title('恢复的调制信号（低通滤波后）');
xlabel('时间 (s)');
ylabel('幅度');
grid on;
