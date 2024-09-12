%gpt给出的单独更新振幅的代码
%振幅随采样点变化的曲线
% 设定参数
timeLength = 0.05;          % 采样时长，单位秒，缩短采样时间
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
xdata = (1:samples);          
axes1 = axes;                   % 创建坐标系
pic = plot(axes1, 1:samples, zeros(1, samples));    % 初始化音频振幅图
set(axes1, 'xlim', [0 samples], 'ylim', [-0.1 0.1], 'XTick', [], 'YTick', [] );  % 设置坐标系

xlabel(axes1, '时间 (samples)');
ylabel(axes1, '振幅');

% 启动采集和显示
drawnow;
stopLoop = false;
frameCount = 0;

while ~stopLoop
    audioIn = step(H);                    % 采样
    
    % 更新振幅图
    frameCount = frameCount + 1;
    if mod(frameCount, 5) == 0            % 每5帧更新一次
        set(pic, 'ydata', audioIn);       % 更新振幅图数据
        drawnow limitrate;                % 使用 'limitrate' 平滑绘图刷新
    end
    
    % 检测键盘退出
    stopLoop = ~isempty(get(gcf, 'CurrentCharacter'));
end

release(H);  % 释放音频设备资源
