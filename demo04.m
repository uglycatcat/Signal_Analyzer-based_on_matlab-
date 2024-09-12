%gpt给出的单独更新振幅的代码
%振幅随时间t变化的曲线
%滑动窗口
% 设定参数
timeLength = 0.05;          % 每次采样的时长，单位秒
sampleRate = 44100;         % 采样率
samples = floor(timeLength * sampleRate);  % 每帧采样点数
displayTime = 2;            % 显示的时间长度，单位秒
displaySamples = displayTime * sampleRate; % 显示窗口的总采样点数

H = audioDeviceReader(...
    'DeviceName', '主声音捕获驱动程序', ...
    'NumChannels', 1 ,...               % 1 个通道
    'BitDepth', '16-bit integer',...     % 16位采样
    'SamplesPerFrame', samples, ...      % 每帧的采样点数
    'SampleRate', sampleRate);           % 显式设置采样率

% 创建显示窗口
figure('Name', '实时信号振幅', 'MenuBar', 'none', 'ToolBar', 'none', 'NumberTitle', 'off');
timeArray = linspace(-displayTime, 0, displaySamples);  % 初始化时间轴，从 -displayTime 到 0 秒
axes1 = axes;                           % 创建坐标系
pic = plot(axes1, timeArray, zeros(1, displaySamples));  % 初始化振幅图
set(axes1, 'xlim', [-displayTime 0], 'ylim', [-1 1], 'XTick', [], 'YTick', [] );  % 设置坐标系

xlabel(axes1, '时间 (秒)');
ylabel(axes1, '振幅');

% 创建缓冲区
buffer = zeros(1, displaySamples);  % 初始化显示的音频缓冲区

% 启动采集和显示
drawnow;
stopLoop = false;

while ~stopLoop
    audioIn = step(H);                  % 从音频设备采集数据
    
    % 更新缓冲区：将新数据追加到缓冲区末尾，并移除旧数据
    buffer = [buffer(samples+1:end), audioIn'];  % 滑动窗口：移除前samples个点，追加新的采样点
    
    % 更新振幅图
    set(pic, 'ydata', buffer);          % 更新图像数据
    drawnow limitrate;                  % 使用 'limitrate' 平滑刷新
    
    % 检测键盘退出
    stopLoop = ~isempty(get(gcf, 'CurrentCharacter'));
end

release(H);  % 释放音频设备资源
