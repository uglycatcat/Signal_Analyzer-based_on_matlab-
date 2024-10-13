% 定义采样频率和时间轴
Fs = 100; % 采样频率为100 Hz
t = 0:1/Fs:10; % 时间范围为0到10秒，步长为1/Fs

% 生成周期为2的正弦信号
f1 = 1 / 2; % 周期为2，频率为1/2 Hz
y1 = sin(2 * pi * f1 * t);

% 生成周期为0.5的正弦信号
f2 = 1 / 0.5; % 周期为0.5，频率为2 Hz
y2 = sin(2 * pi * f2 * t);

% 两个信号相加
y_sum = y1 + y2;

% 计算傅里叶变换
Y1 = fft(y1);
Y2 = fft(y2);
Y_sum = fft(y_sum);

% 频率轴
N = length(t); % 信号点数
f = (0:N-1)*(Fs/N); % 频率范围

% 绘制周期为2的sin信号的频域图像
figure;
subplot(3,1,1);
plot(f, abs(Y1)/N);
title('周期为2的sin信号的频域');
xlabel('频率 (Hz)');
ylabel('幅度');
xlim([0 10]); % 限制频率范围
grid on;

% 绘制周期为0.5的sin信号的频域图像
subplot(3,1,2);
plot(f, abs(Y2)/N);
title('周期为0.5的sin信号的频域');
xlabel('频率 (Hz)');
ylabel('幅度');
xlim([0 10]);
grid on;

% 绘制两个信号相加的频域图像
subplot(3,1,3);
plot(f, abs(Y_sum)/N);
title('周期为2和0.5的sin信号相加的频域');
xlabel('频率 (Hz)');
ylabel('幅度');
xlim([0 10]);
grid on;
