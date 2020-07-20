% Lorentzian�˲��������� g(��0)/[1+��2(��-��0)2]1/2
% �ο�filt1.m filt1n.m
% ���չʾ����̫�ҿ���ע�͵���������

clear all;

g=1; % ��1ʾ��

% �������õ����� ����Ƶƫ �� �˲�����״����K�����ظ�������У���ͦ���㣬ѧϰ����
center_freq = input('Default Nyquist freq range: (-0.5, 0.5), Input Normalised Offset frequency (default value 0 Hz): ');
if isempty(center_freq)
    center_freq = 0;
end
K = input('�����˲�����״����K (Ҫ��K>0��Ĭ��ֵ1)��');
if isempty(K)
    K = 1;
end

% ������̲�������
M = 10; NT = 2^M; % FFT�������Ϊ2���ݣ�����ȡ2^M
rep = 7; % �ظ����������filt1.m�б�ע��Ϊ��ƽ��������

% �������[���gainFilt������ģƽ��/���ʣ�ʵ�������鲿�����鲿]
ph = exp(j*2*pi*center_freq); %����Ƶ�������ʱ�����ơ���ӦƵ��cos(2pi*center_freq)���˲���Ӧ����Ĭ�Ϲ�һ��Ⱥ�ٶ�st/vg=1��
freSpan = linspace(-0.5-center_freq, 0.5-center_freq, NT); %Ĭ�ϴ���Ϊ(-0.5, 0.5)Hz��Ҳ����(-pi,pi)���ټ�������Ƶƫ������-center_freq������+��Ϊ��plot�Ķ�Ӧ��
freSpan_rad = freSpan.*2*pi;

gainFilt = g*cos(freSpan_rad/2)./(cos(freSpan_rad/2)+j*K*sin(freSpan_rad/2)); %�μ�ʽ7.62
gainFilt_power = 20*log10(abs(gainFilt)+10^(-6)); %��ԭ����log���滹����10^-6����ֹ����log0�����ͼ��ʾ��gainFilt�ķ�ֵ��СҲ��0.1����(��-20dB)�����10^-6��һ�򱶡�
gainFilt_real = 20*log10(real(gainFilt)+10^(-6)); %ͬ��10^-6
gainFilt_imagP = 20*log10(0.5*(imag(gainFilt) + abs(imag(gainFilt))) +10^(-6));  % ���鲿���������ԡ�
gainFilt_imagN = 20*log10(0.5*(-imag(gainFilt) + abs(imag(gainFilt))) +10^(-6));
%%
%���������Ϊ����
%������˼·--����ʱ�����ģΪ1��������FFT��Ƶ��۲죬TLLMģ�͵�g����Lorentzian����״
%�����Ӧ����gainFilt_power���ǹ��ʶ���ģֵ
ff_spec_power = zeros(1,NT);ff=zeros(1,NT); %Ԥ���壬��ʼʱ��㣬�ռ������е��Ϊ0
noise_input = sqrt(1/2)*(randn(rep,NT) + j*randn(rep,NT)); %ÿ��rep���㣬ÿ��ʱ�̶�����һ�������

% ���¾�Ϊʱ����㣬�޿ռ䳡�ĵ���
for r=1:rep
    ff(1)=noise_input(r,1);
    for n=1:NT-1
        ff(n+1) = ((K-1)/(1+K))*ph*ff(n) + (1/(1+K))*(noise_input(r,n+1)+ph*noise_input(r,n));
        %���������ο�ʽ7.64����ʽ�Ц�=������ph��ff��ӦB��noise��ӦA
    end
    ff_spec = fftshift(fft(ff))./NT; %�õ�ʱ��ff(1:NT)��Ƶ��
    ff_spec_power = ff_spec.*conj(ff_spec) + ff_spec_power; %rep�����˼��ξͰ��⼸�εĹ��ʶ�����һ����
    if r<rep
        ff(1)=ff(NT); %��Ȼֻ����һ����д��dfbamp���ǽ�����ff��д��dfbamp�ǿռ������������ʱ�������
    end
end
ff_spec_power_norm = ff_spec_power*NT*NT/sum(sum(noise_input.*conj(noise_input)));
%��ʽ�ǶԳ����ʵĹ�һ��������NT^2,��������ģ�ĺ�
%��������˵˵��һ���ģ�����sum(sum(noise_input.*conj(noise_input)))=rep*NT
%power������ÿһ��rep�����һ�Σ�����ʵ������rep*power_norm
%���ͻ�ʣһ����ĸ�ϵ�NT��֪��Ϊ�γˡ���֮����Ǹ���һ����ʽ��2����֤����Ƶ�ʴ�����Ϊ1 or 0dB

%%
% ��ͼչʾ����
figure;hold on;
axis([-0.5 0.5 -20 15]);
xlabel('Frequency/(Nyquist frequency range)');
ylabel('dB:net g(solid);real g.....;imag g: pos -.-. neg - - -');
title('Frequency - Gain Spectrum');
plot(freSpan+center_freq,gainFilt_power,'b',freSpan+center_freq,gainFilt_real,'r:',freSpan+center_freq,gainFilt_imagP,'g-.',freSpan+center_freq,gainFilt_imagN,'m--');
if r==rep  %˵����������
    plot(freSpan+center_freq,10*log10(ff_spec_power_norm),'k');
end
hold off;

%�������ҷ�ֵ����3dB֮��ģ�������gainFilt_realΪ����
[a b]=max(gainFilt_real); %�ҵ������ֵӦ�þ������ķ�ɣ���������һ��
gmax_freqloc = b/2^(M-1) - 1;
gmax_g0_ratio = a - gainFilt_real(2^(M-1)); %�����������gmax��0Ƶ�ʴ�����g0�ı�ֵ����λdB���������
if gmax_g0_ratio<0.001; gmax_g0_ratio = 0; end; %��ֵ��С����Ϊ0dB��������ֺܶ�e-16֮���С����

text(-.45, 13, ['K parameter: ',num2str(K),' offset norm. freq.: ',num2str(center_freq)]);
text(-.45, 10, ['max gain norm. frequ.:', num2str(gmax_freqloc)]);
text(.12, 10, ['g_m_a_x /g(0): ',num2str(gmax_g0_ratio),'   (dB)real']);

[c,d]=min (abs(gainFilt_real(1:b)+3)); dd=-1+d/512;   % finds left 3dB point;
[e,f]=min (abs(gainFilt_real(b+1:end)+3));fd= ((b-512)+f)/512;	 % finds right 3dB point;
text(-.4, 7, num2str(dd/2));text(-.15,7,'3 dB points');text(.3, 7, num2str(fd/2));

% ANOTHER RUN?
run=input('do you want another run y/n ?  ','s');
if isempty(run); run='n';end; %���������ֹ����
if run=='y';yql_gainFilter;end;
clear(run);
