% 设定参数
timeLength = 0.05;          % 每次采样的时长，单位秒
sampleRate = 44100;         % 采样率
samples = floor(timeLength * sampleRate);  % 每帧采样点数
initialDisplayTime = 2;     % 初始显示时间，单位秒
initialDisplaySamples = initialDisplayTime * sampleRate; % 初始显示窗口的总采样点数

H = audioDeviceReader(...
    'DeviceName', '主声音捕获驱动程序', ...
    'NumChannels', 1 ,...               % 1 个通道
    'BitDepth', '16-bit integer',...     % 16位采样
    'SamplesPerFrame', samples, ...      % 每帧的采样点数
    'SampleRate', sampleRate);           % 显式设置采样率

% 创建显示窗口
figure('Name', '实时信号振幅', 'MenuBar', 'none', 'ToolBar', 'none', 'NumberTitle', 'off');
axes1 = axes;                           % 创建坐标系
pic = plot(axes1, zeros(1, initialDisplaySamples), zeros(1, initialDisplaySamples));  % 初始化振幅图
set(axes1, 'xlim', [0 initialDisplayTime], 'ylim', [-0.1 0.1], 'XTick', [], 'YTick', [] );  % 设置坐标系

xlabel(axes1, '时间 (秒)');
ylabel(axes1, '振幅');

% 创建缓冲区
buffer = zeros(1, 0);  % 初始化为空缓冲区
timeArray = zeros(1, 0);  % 初始化为空时间轴

% 启动采集和显示
drawnow;
stopLoop = false;

while ~stopLoop
    audioIn = step(H);                  % 从音频设备采集数据

    % 更新缓冲区
    buffer = [buffer, audioIn'];       % 将新数据追加到缓冲区
    
    % 更新时间轴
    newTime = (length(buffer) / sampleRate);  % 计算当前数据长度对应的时间
    timeArray = linspace(0, newTime, length(buffer)); % 更新时间轴

    % 更新振幅图
    set(pic, 'xdata', timeArray, 'ydata', buffer);  % 更新图像数据
    drawnow limitrate;                  % 使用 'limitrate' 平滑刷新
    
    % 检测键盘退出
    if ~isempty(get(gcf, 'CurrentCharacter'))
        stopLoop = true;  % 按下键盘任意键退出循环
    end
end

release(H);  % 释放音频设备资源
