%参考程序spontan文件夹下spont.m

%———————————预定义部分——————————%
clear all
M=10; % 【叫什么名字好呢】
NT = 2^M; % 时间点数，对应时间窗口tw=1:1024

%定义一：含随机噪声的激光场white_incoh【时域】，两个随机数时空零相关
white_coh = sqrt(1/2)*(sqrt(10)+randn(1,NT+1)) + j*sqrt(1/2)*(sqrt(10)+randn(1,NT+1));%randn产生高斯随机数，范围（-∞，+∞）
% white_coh与作者程序中的cohspon变量相同
% 激光场为sqrt(5)+i*sqrt(5)【已去除中心频率,sqrt(5)是振幅与初相乘积sqrt(10)*cos(pi/4)】
% 噪声场为sqrt(1/2)(rand+i*rand)
% 整体"coh+noise"场初相为pi/4，振幅为sqrt(10)+randn

%定义二：窄带滤波的含噪声激光场
filte_white_coh = zeros(size(white_coh));
for r=1:NT
    filte_white_coh(r+1) = 0.94*filte_white_coh(r)+0.03*(white_coh(r+1)+white_coh(r));
    % !!!这是关键的滤波式子，相当于在算与单边指函0.94^t卷积【！似乎见过，学着用】
    % 迭代式还原结果，滤波含噪声的激光 与 不含噪声的激光 强度之比 为 1–0.94^(r) 【20200720周报】
    % 【为啥是0.94与0.03的组合？：粗略计算这样3dB带宽约在0.01，30dB带宽约在0.043的位置，和结果图差不多】
    % 【发现0.94与0.03的组合，对应后面滤波器形状因子K=32.333..的情况】
end

%%
%——————————结果展示一：全波段（幅相图（实时快照+整体图） +  频域图（功率谱））——————%
figure;
fnum=gcf; %记录每张图的句柄，接下来画图可以直接用figure(fnum+1)避免重复；

title('Display of Coherent + Noise Field with time '); % 快照
xlabel('real');ylabel('imaginary');
axis([0 5 0 5]);drawnow;
%展示形式定义，fdpt展示点，fdline展示线
fdpt = line('Xdata',0,'Ydata',0,'color','b','LineStyle','.','erasemode','none');
fdline = line('Xdata',0,'Ydata',0,'color','r','LineStyle','-','erasemode','xor');

for r=750:1:1000
    set(fdline,'Xdata',[0 real(white_coh(r))],'Ydata',[0 imag(white_coh(r))]);
    set(fdpt,'Xdata',real(white_coh(750:r)),'Ydata',imag(white_coh(750:r)));
    drawnow;
end
pause(2);

title('Coherent + Noise Field '); % 整体
set(fdline,'Xdata',[0 sqrt(5)],'Ydata',[0 sqrt(5)]);
drawnow;
pause(3);

% 频域表示：频谱与功率谱（画图只画了功率谱）
white_incoh_spec = fftshift(fft(white_coh))./NT; % 参考原作者，也除以了NT，是傅里叶系数谱
white_incoh_spec_power = white_incoh_spec.*conj(white_incoh_spec); % 功率谱

samplingRate = 1; % 如果按时间窗口tw=NT=1024s的话，采样率为1Hz
freq = linspace(-samplingRate/2,samplingRate/2,NT+1);

figure(fnum+1);
plot(freq,10*log10(white_incoh_spec_power));
axis([-1/8 1/8 -60 20]); % 图谱展示范围[x1 x2 y1 y1]
title('Power Spectrum');
ylabel('dB');xlabel('Normalised Frequency');
pause(3);
%——————————————————————————————————————————%

%——————————结果展示二：窄带滤波后（幅相图（实时快照+整体图） +  频域图（功率谱））——————%
figure(fnum+2)
axis([0 3 0 3]);
title('Coherent + NARROW BAND Noise Field with time ');
xlabel('real'); ylabel('imaginary');
%展示形式定义，fdpt展示点，fdline展示线
fdpt = line('Xdata',0,'Ydata',0,'color','b','LineStyle','.','erasemode','none');
fdline = line('Xdata',0,'Ydata',0,'color','r','LineStyle','-','erasemode','xor');

for r=750:1:1000
    set(fdline,'Xdata',[0 real(filte_white_coh(r))],'Ydata',[0 imag(filte_white_coh(r))]);
    set(fdpt,'Xdata',real(filte_white_coh(750:r)),'Ydata',imag(filte_white_coh(750:r)));
    drawnow;
end
pause(2);

title('Coherent + NARROW BAND Noise Field ');
set(fdline,'Xdata',[0 real(filte_white_coh(end))],'Ydata',[0 imag(filte_white_coh(end))]);
drawnow;
pause(3) 

% 频域表示：频谱与功率谱
spon_white_spec = fftshift(fft(filte_white_coh))./NT;
spon_white_spec_power = spon_white_spec.*conj(spon_white_spec);

figure(fnum+3);
plot(freq,10*log10(spon_white_spec_power));
axis([-1/8 1/8 -60 20]); % 图谱展示范围[x1 x2 y1 y1]
title('Filtered Power Spectrum');
ylabel('dB');xlabel('Normalised Frequency');
pause(3);