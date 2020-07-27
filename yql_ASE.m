%计算自发放大噪声Amplified Spontaneous Emission noise
%行波中的增益滤波器【基于平流波动方程，无光栅即无耦合，有g有δ】

clear all;

% 计算过程参数定义
M = 12; NT = 2^M; % FFT点数最好为2的幂，这里取2^M
L=64; %um 【会不会太短？】
N=32;%空间上分成32段计算
rep = 8; % 重复计算次数（这次作者选成腔长【是何用意？】）
nt = NT/rep; %设置值满足，所有计算结束后，得到的场时域点数等于设定的用于FFT的点数
gs=1/8; 
kappas=1; %仿gain.m，还没有光栅
aHs = 0; %仿gain.m，还没有啁啾

% 作者设置的输入 中心频偏 和 滤波器形状因子K，的重复多次运行，还挺方便，用着
center_freq = input('Default Nyquist freq range: (-0.5, 0.5), Input Normalised Offset frequency (default value 0 Hz): ');
if isempty(center_freq)
    center_freq = 0;
end
K = input('输入滤波器形状因子K (要求K>0，默认值1)：');
if isempty(K)
    K = 1;
end


% FDTD用到的参数，不变的放在循环外定义
ph = exp(j*2*pi*center_freq); %中心频率引起的时域相移【对应频域cos(2pi*center_freq)的滤波响应】【默认归一化群速度st/vg=1】
freSpan = linspace(-0.5-center_freq, 0.5-center_freq, NT); %默认带宽为(-0.5, 0.5)Hz，也就是(-pi,pi)，再加上中心频偏【这里-center_freq而不是+是为了plot的对应】
freSpan_rad = freSpan.*2*pi;

mL=exp(gs); %dfbamp里mL=exp(gs-jδs)里面的δ是输入频偏，和本程序中的center_freq定义重复，故删去
dph = exp(j*aHs*gs); % 参考p4run, 应该是啁啾项
sin_T = dph*kappas /(1 + 0.25*kappas^2);
cos_T = dph*(1- 0.25*kappas^2) /(1 + 0.25*kappas^2);
gs_half = (mL-1)/(mL+1); % 尽量少用近似【思考过程见日+0629周报P14,很乱】
%参考式7.73-7.75（和gain.m又略不同）
ma = (K+1+gs_half)/(K+1-gs_half);
mb = ph*(K-1-gs_half)/(K+1-gs_half);
mc = ph*(K-1+gs_half)/(K+1-gs_half);
%以下为近似gs/2形式的ma,mb,mc
% ma = (K+1+0.5*gs)/(K+1-0.5*gs);
% mb = ph*(K-1-0.5*gs)/(K+1-0.5*gs);
% mc = ph*(K-1+0.5*gs)/(K+1-0.5*gs);

%定义自发噪声作为输入
ff = zeros(1,N);ffn = zeros(1,N);ffo = zeros(1,N); %预定义，初始时间点，空间上所有点光为0
fr = zeros(1,N);frn = zeros(1,N);fro = zeros(1,N);
betasp = 7.019421150210290e-05; % 取了个常见值
%betasp=Bn*(gammasp_gamma)*((lambda)^2/((8*pi*A*perm))*(vg/(L*Df))); % 来自p1las1.m  参考A9.30式
rsp = sqrt(betasp); %仿dfbuni，感觉不严谨

% 以下时空行波计算（先没算反向波，利用平流方程只算了前向波）
for r=1:rep
    % 迭代式推导结果见周报0720
    % 自发辐射激励
    spnoise_input_f = rsp*sqrt(1/2)*(randn(N,nt) + j*randn(N,nt)); %参照p5spont.m，每次rep计算，每个时刻都产生一个随机数
    spnoise_input_r = rsp*sqrt(1/2)*(randn(N,nt) + j*randn(N,nt)); %前后向场用到的随机数不同
    % spnoise_input_norm = sum(spnoise_input(1).*conj(spnoise_input(1)); %归一化的结果大概约等于NT*1【吧】
    for t=1:1:nt %每一次计算经历16个时间步
        for n=2:N-1
            isp_f(n) = spnoise_input_f(n,t);
            ffn(n+1) = cos_T*(ma*ff(n)-mb*ffo(n)+isp_f(n)) + 1j*sin_T*(ma*fr(n+1)-mb*fro(n+1)) + mc*ff(n+1);
            nr=N+1-n;
            isp_r(nr) = spnoise_input_r(nr,t);
            frn(nr) = cos_T*(ma*fr(nr+1)-mb*fro(nr+1)+isp_r(nr)) + 1j*sin_T*(ma*ff(nr)-mb*ffo(nr)) + mc*ff(nr);
        end
        lightR((r-1)*nt+t) = ffn(end); %以右端面作为出光面
        ffo=ff;fro=fr;ff=ffn;fr=frn; %建立循环
    end
    light_timedomain = 10*log10(lightR((r-1)*nt+1:r*nt).*conj(lightR(((r-1)*nt+1:r*nt))));
    tspan =linspace(0,2.745165548608809,nt) ;%由预设δL范围（-0.5，0.5）算出来采样率4pif/c*L=1,f=3e8/(4pi*64e-6)=3.73e11 Hz.samplingRate=NT/tw,所以时间窗口tw=2.75e-9
    figure;
    plot(tspan,light_timedomain,'b-');%axis([0 2.8 -60 20]);
    text(0.5,-18,['number of runs to go: ',num2str(r)]);
    title('Log Output - Time (ps)');
    pause(1);
end


lightR_spec = fftshift(fft(lightR))./NT; 
lightR_spec_power = lightR_spec.*conj(lightR_spec);
figure;
plot(freSpan+center_freq,10*log10(lightR_spec_power));
%axis([-750 750 -70 10]);
title('Normalised Power Spectrum')
xlabel('Normalized detuning');ylabel('Relative power  dB')
