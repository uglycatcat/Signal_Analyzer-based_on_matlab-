%gpt给出的单独更新振幅的代码
%振幅随时间t变化的曲线
% 设定参数
timeLength = 0.05;          % 采样时长，单位秒
sampleRate = 44100;         % 采样率
samples = floor(timeLength * sampleRate);  % 每帧采样点数

H = audioDeviceReader(...
    'DeviceName', '主声音捕获驱动程序', ...
    'NumChannels', 1 ,...               % 1 个通道
    'BitDepth', '16-bit integer',...     % 16位采样
    'SamplesPerFrame', samples, ...      % 每帧的采样点数
    'SampleRate', sampleRate);           % 显式设置采样率

% 创建显示窗口
figure('Name', '实时信号振幅', 'MenuBar', 'none', 'ToolBar', 'none', 'NumberTitle', 'off');
timeArray = (0:samples-1) / sampleRate;  % 计算每个采样点对应的时间（单位：秒）
axes1 = axes;                           % 创建坐标系
pic = plot(axes1, timeArray, zeros(1, samples));    % 初始化振幅随时间变化的图像
set(axes1, 'xlim', [0 max(timeArray)], 'ylim', [-0.1 0.1], 'XTick', [], 'YTick', [] );  % 设置坐标系

xlabel(axes1, '时间 (秒)');             % 横轴单位改为时间
ylabel(axes1, '振幅');                 % 保持振幅作为纵轴单位

% 启动采集和显示
drawnow;
stopLoop = false;
frameCount = 0;

while ~stopLoop
    audioIn = step(H);                  % 采样
    
    % 更新振幅图
    frameCount = frameCount + 1;
    if mod(frameCount, 5) == 0          % 每5帧更新一次
        set(pic, 'ydata', audioIn);     % 更新振幅数据
        drawnow limitrate;              % 使用 'limitrate' 平滑绘图刷新
    end
    
    % 检测键盘退出
    stopLoop = ~isempty(get(gcf, 'CurrentCharacter'));
end

release(H);  % 释放音频设备资源
