%产生Chrip信号
t = linspace(0, 1, 300);                   % 采样率是44100HZ
ychirp=chirp(t,1000,300,5000);
plot(ychirp);
 