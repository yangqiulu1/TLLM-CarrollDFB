%�ο�����spontan�ļ�����spont.m

%����������������������Ԥ���岿�֡�������������������%
clear all
M=10; % ����ʲô���ֺ��ء�
NT = 2^M; % ʱ���������Ӧʱ�䴰��tw=1:1024

%����һ������������ļ��ⳡwhite_incoh��ʱ�򡿣����������ʱ�������
white_coh = sqrt(1/2)*(sqrt(10)+randn(1,NT+1)) + j*sqrt(1/2)*(sqrt(10)+randn(1,NT+1));%randn������˹���������Χ��-�ޣ�+�ޣ�
% white_coh�����߳����е�cohspon������ͬ
% ���ⳡΪsqrt(5)+i*sqrt(5)����ȥ������Ƶ��,sqrt(5)����������˻�sqrt(10)*cos(pi/4)��
% ������Ϊsqrt(1/2)(rand+i*rand)
% ����"coh+noise"������Ϊpi/4�����Ϊsqrt(10)+randn

%�������խ���˲��ĺ��������ⳡ
filte_white_coh = zeros(size(white_coh));
for r=1:NT
    filte_white_coh(r+1) = 0.94*filte_white_coh(r)+0.03*(white_coh(r+1)+white_coh(r));
    % !!!���ǹؼ����˲�ʽ�ӣ��൱�������뵥��ָ��0.94^t��������ƺ�������ѧ���á�
    % ����ʽ��ԭ������˲��������ļ��� �� ���������ļ��� ǿ��֮�� Ϊ 1�C0.94^(r) ��20200720�ܱ���
    % ��Ϊɶ��0.94��0.03����ϣ������Լ�������3dB����Լ��0.01��30dB����Լ��0.043��λ�ã��ͽ��ͼ��ࡿ
    % ������0.94��0.03����ϣ���Ӧ�����˲�����״����K=32.333..�������
end

%%
%�����������������������չʾһ��ȫ���Σ�����ͼ��ʵʱ����+����ͼ�� +  Ƶ��ͼ�������ף���������������%
figure;
fnum=gcf; %��¼ÿ��ͼ�ľ������������ͼ����ֱ����figure(fnum+1)�����ظ���

title('Display of Coherent + Noise Field with time '); % ����
xlabel('real');ylabel('imaginary');
axis([0 5 0 5]);drawnow;
%չʾ��ʽ���壬fdptչʾ�㣬fdlineչʾ��
fdpt = line('Xdata',0,'Ydata',0,'color','b','LineStyle','.','erasemode','none');
fdline = line('Xdata',0,'Ydata',0,'color','r','LineStyle','-','erasemode','xor');

for r=750:1:1000
    set(fdline,'Xdata',[0 real(white_coh(r))],'Ydata',[0 imag(white_coh(r))]);
    set(fdpt,'Xdata',real(white_coh(750:r)),'Ydata',imag(white_coh(750:r)));
    drawnow;
end
pause(2);

title('Coherent + Noise Field '); % ����
set(fdline,'Xdata',[0 sqrt(5)],'Ydata',[0 sqrt(5)]);
drawnow;
pause(3);

% Ƶ���ʾ��Ƶ���빦���ף���ͼֻ���˹����ף�
white_incoh_spec = fftshift(fft(white_coh))./NT; % �ο�ԭ���ߣ�Ҳ������NT���Ǹ���Ҷϵ����
white_incoh_spec_power = white_incoh_spec.*conj(white_incoh_spec); % ������

samplingRate = 1; % �����ʱ�䴰��tw=NT=1024s�Ļ���������Ϊ1Hz
freq = linspace(-samplingRate/2,samplingRate/2,NT+1);

figure(fnum+1);
plot(freq,10*log10(white_incoh_spec_power));
axis([-1/8 1/8 -60 20]); % ͼ��չʾ��Χ[x1 x2 y1 y1]
title('Power Spectrum');
ylabel('dB');xlabel('Normalised Frequency');
pause(3);
%������������������������������������������������������������������������������������%

%�����������������������չʾ����խ���˲��󣨷���ͼ��ʵʱ����+����ͼ�� +  Ƶ��ͼ�������ף���������������%
figure(fnum+2)
axis([0 3 0 3]);
title('Coherent + NARROW BAND Noise Field with time ');
xlabel('real'); ylabel('imaginary');
%չʾ��ʽ���壬fdptչʾ�㣬fdlineչʾ��
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

% Ƶ���ʾ��Ƶ���빦����
spon_white_spec = fftshift(fft(filte_white_coh))./NT;
spon_white_spec_power = spon_white_spec.*conj(spon_white_spec);

figure(fnum+3);
plot(freq,10*log10(spon_white_spec_power));
axis([-1/8 1/8 -60 20]); % ͼ��չʾ��Χ[x1 x2 y1 y1]
title('Filtered Power Spectrum');
ylabel('dB');xlabel('Normalised Frequency');
pause(3);