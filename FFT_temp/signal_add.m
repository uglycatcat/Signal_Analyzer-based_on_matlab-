% 定义时间轴
t = 0:0.01:10; % 0到10秒，步长为0.01

% 生成周期为2的正弦信号
f1 = 1 / 2; % 周期为2，所以频率为1/2
y1 = sin(2 * pi * f1 * t);

% 生成周期为0.5的正弦信号
f2 = 1 / 0.5; % 周期为0.5，所以频率为1/0.5
y2 = sin(2 * pi * f2 * t);

% 两个信号相加
y_sum = y1 + y2;

% 绘制周期为2的正弦信号
figure;
subplot(3,1,1);
plot(t, y1);
title('周期为2的sin信号');
xlabel('时间 (秒)');
ylabel('幅度');
grid on;

% 绘制周期为0.5的正弦信号
subplot(3,1,2);
plot(t, y2);
title('周期为0.5的sin信号');
xlabel('时间 (秒)');
ylabel('幅度');
grid on;

% 绘制两个信号相加的结果
subplot(3,1,3);
plot(t, y_sum);
title('周期为2和0.5的sin信号相加的结果');
xlabel('时间 (秒)');
ylabel('幅度');
grid on;
