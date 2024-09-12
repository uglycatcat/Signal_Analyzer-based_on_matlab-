%csdn抄来参考的，实时性很差
timeLength = 1;            % 采样时长，单位秒
samples = timeLength * 44100;  % 默认采样率44100，计算采样点数
H = audioDeviceReader(...
    'DeviceName','主声音捕获驱动程序',...
    'NumChannels', 1 ,...               % 1 个通道
    'BitDepth', '16-bit integer',...     % 16位采样
    'SamplesPerFrame', samples, ...      % 采样点数
    'SampleRate', 44100);                % 显式设置采样率
audioIn = step(H);                       % 第一次采样
figure('Name','实时频谱','MenuBar','none','ToolBar','none','NumberTitle','off');
xdata = (1:1:samples/2) / timeLength;          
axes1 = subplot(1,2,1);
axes2 = subplot(1,2,2);
pic = plot(axes1, 1:1:samples, audioIn);    % 初始化音频波形图
pic2 = bar(axes2, xdata, xdata*0, 'r');     % 初始化频谱图
set(axes1, 'xlim', [0 samples], 'ylim', [-1 1], 'XTick', [], 'YTick', [] );
set(axes2, 'xlim', [min(xdata) max(xdata)], 'ylim', [0 6], 'xscale','log', 'XTick', [1 10 100 1e3 1e4], 'YTick', [] );
xlabel(axes2, '频率 (Hz)');
xlabel(axes1, '波形');
axes2.Position = [0.040 0.48 00.92 0.48]; % 左，下，宽度，高度
axes1.Position = [0.040 0.06 0.92 0.25];

drawnow;
stopLoop = false;
frameCount = 0;

while ~stopLoop
   audioIn = step(H);                    % 采样
   ydata_fft = fft(audioIn);             % 傅里叶变换
   ydata_abs = abs(ydata_fft(1:samples/2));  % 取绝对值
   
   frameCount = frameCount + 1;
   if mod(frameCount, 5) == 0            % 每5帧更新一次
       set(pic, 'ydata', audioIn);       % 更新波形图数据
       set(pic2, 'ydata', log(ydata_abs + eps));  % 更新频谱图数据
       drawnow;                          % 刷新
   end
   
   % 检测用户按下键盘退出
   stopLoop = ~isempty(get(gcf, 'CurrentCharacter'));
end
