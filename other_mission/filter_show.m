%产生周期方波信号并进行滤波，分别展示时域和频域的变化

% 产生周期方波信号并进行频谱分析，以及应用不同的滤波器
clear;
clc;

% 调用不同截止频率的滤波器
Hd_50 = filter_50();    % 截止频率为50 Hz的滤波器
Hd_150 = filter_100();  % 截止频率为150 Hz的滤波器

% 参数设置
Fs = 500;        % 采样频率 (与滤波器匹配)
T = 1;           % 信号持续时间 (秒)
f_square = 5;    % 方波的频率 (Hz)
t = 0:1/Fs:T-1/Fs; % 时间向量

% 产生方波信号
square_wave = square(2 * pi * f_square * t);  % 产生方波信号

% 绘制原始方波信号的时域图像
figure;
subplot(3, 2, 1);
plot(t, square_wave);
title('原始方波信号（时域）');
xlabel('时间 (s)');
ylabel('幅度');
grid on;

% 对方波进行频谱分析（FFT）
N = length(square_wave);  % 信号长度
Y = fft(square_wave);      % 进行快速傅里叶变换 (FFT)
P2 = abs(Y/N);             % 双边谱
P1 = P2(1:N/2+1);          % 单边谱
P1(2:end-1) = 2*P1(2:end-1); % 仅保留正频率部分
f = Fs*(0:(N/2))/N;        % 频率向量

% 绘制原始方波信号的频域图像
subplot(3, 2, 2);
plot(f, P1);
title('原始方波信号（频域）');
xlabel('频率(Hz)');
ylabel('幅度');
grid on;

% 应用截止频率为50 Hz的滤波器
filtered_signal_50 = filter(Hd_50, square_wave);

% 绘制截止频率为50 Hz的滤波后方波信号的时域图像
subplot(3, 2, 3);
plot(t, filtered_signal_50);
title('50Hz低通滤波器（时域）');
xlabel('时间 (s)');
ylabel('幅度');
grid on;

% 对50 Hz滤波后的信号进行频谱分析（FFT）
Y_filtered_50 = fft(filtered_signal_50);  % 进行快速傅里叶变换
P2_filtered_50 = abs(Y_filtered_50/N);    % 双边谱
P1_filtered_50 = P2_filtered_50(1:N/2+1); % 单边谱
P1_filtered_50(2:end-1) = 2*P1_filtered_50(2:end-1); % 仅保留正频率部分

% 绘制50 Hz滤波后的频域图像
subplot(3, 2, 4);
plot(f, P1_filtered_50);
title('50Hz低通滤波器（频域）');
xlabel('频率 (Hz)');
ylabel('幅度');
grid on;

% 应用截止频率为150 Hz的滤波器
filtered_signal_150 = filter(Hd_150, square_wave);

% 绘制截止频率为150 Hz的滤波后方波信号的时域图像
subplot(3, 2, 5);
plot(t, filtered_signal_150);
title('100Hz低通滤波器（时域）');
xlabel('时间 (s)');
ylabel('幅度');
grid on;

% 对150 Hz滤波后的信号进行频谱分析（FFT）
Y_filtered_150 = fft(filtered_signal_150);  % 进行快速傅里叶变换
P2_filtered_150 = abs(Y_filtered_150/N);    % 双边谱
P1_filtered_150 = P2_filtered_150(1:N/2+1); % 单边谱
P1_filtered_150(2:end-1) = 2*P1_filtered_150(2:end-1); % 仅保留正频率部分

% 绘制150 Hz滤波后的频域图像
subplot(3, 2, 6);
plot(f, P1_filtered_150);
title('100Hz低通滤波器（频域）');
xlabel('频率 (Hz)');
ylabel('幅度');
grid on;

% End of script
