% Lorentzian滤波器，形如 g(ω0)/[1+τ2(ω-ω0)2]1/2
% 参考filt1.m filt1n.m
% 如果展示界面太乱可以注释掉噪声部分

clear all;

g=1; % 以1示例

% 作者设置的输入 中心频偏 和 滤波器形状因子K，的重复多次运行，还挺方便，学习用着
center_freq = input('Default Nyquist freq range: (-0.5, 0.5), Input Normalised Offset frequency (default value 0 Hz): ');
if isempty(center_freq)
    center_freq = 0;
end
K = input('输入滤波器形状因子K (要求K>0，默认值1)：');
if isempty(K)
    K = 1;
end

% 计算过程参数定义
M = 10; NT = 2^M; % FFT点数最好为2的幂，这里取2^M
rep = 7; % 重复计算次数（filt1.m中标注是为了平均噪声）

% 计算过程[算出gainFilt，及其模平方/功率，实部，正虚部，复虚部]
ph = exp(j*2*pi*center_freq); %中心频率引起的时域相移【对应频域cos(2pi*center_freq)的滤波响应】【默认归一化群速度st/vg=1】
freSpan = linspace(-0.5-center_freq, 0.5-center_freq, NT); %默认带宽为(-0.5, 0.5)Hz，也就是(-pi,pi)，再加上中心频偏【这里-center_freq而不是+是为了plot的对应】
freSpan_rad = freSpan.*2*pi;

gainFilt = g*cos(freSpan_rad/2)./(cos(freSpan_rad/2)+j*K*sin(freSpan_rad/2)); %参见式7.62
gainFilt_power = 20*log10(abs(gainFilt)+10^(-6)); %仿原程序log里面还加了10^-6，防止出现log0【结果图显示，gainFilt的幅值最小也在0.1左右(即-20dB)，相对10^-6大一万倍】
gainFilt_real = 20*log10(real(gainFilt)+10^(-6)); %同仿10^-6
gainFilt_imagP = 20*log10(0.5*(imag(gainFilt) + abs(imag(gainFilt))) +10^(-6));  % 【虚部这两项略迷】
gainFilt_imagN = 20*log10(0.5*(-imag(gainFilt) + abs(imag(gainFilt))) +10^(-6));
%%
%随机噪声作为输入
%！！！思路--先在时域加入模为1的随机项，再FFT到频域观察，TLLM模型的g就是Lorentzian的形状
%结果对应的是gainFilt_power，是功率而非模值
ff_spec_power = zeros(1,NT);ff=zeros(1,NT); %预定义，初始时间点，空间上所有点光为0
noise_input = sqrt(1/2)*(randn(rep,NT) + j*randn(rep,NT)); %每次rep计算，每个时刻都产生一个随机数

% 以下均为时域计算，无空间场的迭代
for r=1:rep
    ff(1)=noise_input(r,1);
    for n=1:NT-1
        ff(n+1) = ((K-1)/(1+K))*ph*ff(n) + (1/(1+K))*(noise_input(r,n+1)+ph*noise_input(r,n));
        %本步迭代参考式7.64，公式中Θ=程序中ph，ff对应B，noise对应A
    end
    ff_spec = fftshift(fft(ff))./NT; %得到时域ff(1:NT)的频谱
    ff_spec_power = ff_spec.*conj(ff_spec) + ff_spec_power; %rep计算了几次就把这几次的功率都加在一起了
    if r<rep
        ff(1)=ff(NT); %居然只将第一个重写，dfbamp里是将整个ff重写【dfbamp是空间迭代，这里是时间迭代】
    end
end
ff_spec_power_norm = ff_spec_power*NT*NT/sum(sum(noise_input.*conj(noise_input)));
%上式是对场功率的归一化，乘上NT^2,除以噪声模的和
%噪声按理说说归一化的，所以sum(sum(noise_input.*conj(noise_input)))=rep*NT
%power经过了每一次rep都求和一次，所以实际上是rep*power_norm
%【就还剩一个分母上的NT不知道为何乘】总之这就是个归一化的式子2，保证中心频率处幅度为1 or 0dB

%%
% 绘图展示部分
figure;hold on;
axis([-0.5 0.5 -20 15]);
xlabel('Frequency/(Nyquist frequency range)');
ylabel('dB:net g(solid);real g.....;imag g: pos -.-. neg - - -');
title('Frequency - Gain Spectrum');
plot(freSpan+center_freq,gainFilt_power,'b',freSpan+center_freq,gainFilt_real,'r:',freSpan+center_freq,gainFilt_imagP,'g-.',freSpan+center_freq,gainFilt_imagN,'m--');
if r==rep  %说明算噪声了
    plot(freSpan+center_freq,10*log10(ff_spec_power_norm),'k');
end
hold off;

%接下来找峰值，找3dB之类的，都是以gainFilt_real为基础
[a b]=max(gainFilt_real); %找到的最大值应该就是中心峰吧，还又找了一遍
gmax_freqloc = b/2^(M-1) - 1;
gmax_g0_ratio = a - gainFilt_real(2^(M-1)); %计算最大增益gmax与0频率处增益g0的比值，单位dB，作差即求商
if gmax_g0_ratio<0.001; gmax_g0_ratio = 0; end; %差值过小就视为0dB，避免出现很多e-16之类过小数字

text(-.45, 13, ['K parameter: ',num2str(K),' offset norm. freq.: ',num2str(center_freq)]);
text(-.45, 10, ['max gain norm. frequ.:', num2str(gmax_freqloc)]);
text(.12, 10, ['g_m_a_x /g(0): ',num2str(gmax_g0_ratio),'   (dB)real']);

[c,d]=min (abs(gainFilt_real(1:b)+3)); dd=-1+d/512;   % finds left 3dB point;
[e,f]=min (abs(gainFilt_real(b+1:end)+3));fd= ((b-512)+f)/512;	 % finds right 3dB point;
text(-.4, 7, num2str(dd/2));text(-.15,7,'3 dB points');text(.3, 7, num2str(fd/2));

% ANOTHER RUN?
run=input('do you want another run y/n ?  ','s');
if isempty(run); run='n';end; %无输入就终止运行
if run=='y';yql_gainFilter;end;
clear(run);
