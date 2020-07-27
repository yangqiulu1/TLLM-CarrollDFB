%�����Է��Ŵ�����Amplified Spontaneous Emission noise
%�в��е������˲���������ƽ���������̣��޹�դ������ϣ���g�Цġ�

clear all;

% ������̲�������
M = 12; NT = 2^M; % FFT�������Ϊ2���ݣ�����ȡ2^M
L=64; %um ���᲻��̫�̣���
N=32;%�ռ��Ϸֳ�32�μ���
rep = 8; % �ظ�����������������ѡ��ǻ�����Ǻ����⣿����
nt = NT/rep; %����ֵ���㣬���м�������󣬵õ��ĳ�ʱ����������趨������FFT�ĵ���
gs=1/8; 
kappas=1; %��gain.m����û�й�դ
aHs = 0; %��gain.m����û�����

% �������õ����� ����Ƶƫ �� �˲�����״����K�����ظ�������У���ͦ���㣬����
center_freq = input('Default Nyquist freq range: (-0.5, 0.5), Input Normalised Offset frequency (default value 0 Hz): ');
if isempty(center_freq)
    center_freq = 0;
end
K = input('�����˲�����״����K (Ҫ��K>0��Ĭ��ֵ1)��');
if isempty(K)
    K = 1;
end


% FDTD�õ��Ĳ���������ķ���ѭ���ⶨ��
ph = exp(j*2*pi*center_freq); %����Ƶ�������ʱ�����ơ���ӦƵ��cos(2pi*center_freq)���˲���Ӧ����Ĭ�Ϲ�һ��Ⱥ�ٶ�st/vg=1��
freSpan = linspace(-0.5-center_freq, 0.5-center_freq, NT); %Ĭ�ϴ���Ϊ(-0.5, 0.5)Hz��Ҳ����(-pi,pi)���ټ�������Ƶƫ������-center_freq������+��Ϊ��plot�Ķ�Ӧ��
freSpan_rad = freSpan.*2*pi;

mL=exp(gs); %dfbamp��mL=exp(gs-j��s)����Ħ�������Ƶƫ���ͱ������е�center_freq�����ظ�����ɾȥ
dph = exp(j*aHs*gs); % �ο�p4run, Ӧ���������
sin_T = dph*kappas /(1 + 0.25*kappas^2);
cos_T = dph*(1- 0.25*kappas^2) /(1 + 0.25*kappas^2);
gs_half = (mL-1)/(mL+1); % �������ý��ơ�˼�����̼���+0629�ܱ�P14,���ҡ�
%�ο�ʽ7.73-7.75����gain.m���Բ�ͬ��
ma = (K+1+gs_half)/(K+1-gs_half);
mb = ph*(K-1-gs_half)/(K+1-gs_half);
mc = ph*(K-1+gs_half)/(K+1-gs_half);
%����Ϊ����gs/2��ʽ��ma,mb,mc
% ma = (K+1+0.5*gs)/(K+1-0.5*gs);
% mb = ph*(K-1-0.5*gs)/(K+1-0.5*gs);
% mc = ph*(K-1+0.5*gs)/(K+1-0.5*gs);

%�����Է�������Ϊ����
ff = zeros(1,N);ffn = zeros(1,N);ffo = zeros(1,N); %Ԥ���壬��ʼʱ��㣬�ռ������е��Ϊ0
fr = zeros(1,N);frn = zeros(1,N);fro = zeros(1,N);
betasp = 7.019421150210290e-05; % ȡ�˸�����ֵ
%betasp=Bn*(gammasp_gamma)*((lambda)^2/((8*pi*A*perm))*(vg/(L*Df))); % ����p1las1.m  �ο�A9.30ʽ
rsp = sqrt(betasp); %��dfbuni���о����Ͻ�

% ����ʱ���в����㣨��û�㷴�򲨣�����ƽ������ֻ����ǰ�򲨣�
for r=1:rep
    % ����ʽ�Ƶ�������ܱ�0720
    % �Է����伤��
    spnoise_input_f = rsp*sqrt(1/2)*(randn(N,nt) + j*randn(N,nt)); %����p5spont.m��ÿ��rep���㣬ÿ��ʱ�̶�����һ�������
    spnoise_input_r = rsp*sqrt(1/2)*(randn(N,nt) + j*randn(N,nt)); %ǰ�����õ����������ͬ
    % spnoise_input_norm = sum(spnoise_input(1).*conj(spnoise_input(1)); %��һ���Ľ�����Լ����NT*1���ɡ�
    for t=1:1:nt %ÿһ�μ��㾭��16��ʱ�䲽
        for n=2:N-1
            isp_f(n) = spnoise_input_f(n,t);
            ffn(n+1) = cos_T*(ma*ff(n)-mb*ffo(n)+isp_f(n)) + 1j*sin_T*(ma*fr(n+1)-mb*fro(n+1)) + mc*ff(n+1);
            nr=N+1-n;
            isp_r(nr) = spnoise_input_r(nr,t);
            frn(nr) = cos_T*(ma*fr(nr+1)-mb*fro(nr+1)+isp_r(nr)) + 1j*sin_T*(ma*ff(nr)-mb*ffo(nr)) + mc*ff(nr);
        end
        lightR((r-1)*nt+t) = ffn(end); %���Ҷ�����Ϊ������
        ffo=ff;fro=fr;ff=ffn;fr=frn; %����ѭ��
    end
    light_timedomain = 10*log10(lightR((r-1)*nt+1:r*nt).*conj(lightR(((r-1)*nt+1:r*nt))));
    tspan =linspace(0,2.745165548608809,nt) ;%��Ԥ���L��Χ��-0.5��0.5�������������4pif/c*L=1,f=3e8/(4pi*64e-6)=3.73e11 Hz.samplingRate=NT/tw,����ʱ�䴰��tw=2.75e-9
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
