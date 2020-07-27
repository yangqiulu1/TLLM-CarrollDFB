% ��������ʣ����Ǹ�dfb�������޷����ķŴ���

clear;

kappaL=2;% 1
gL=0.5; %1 %'dfbamp'����Ϊ�˹�һ��ȡ��gL=1/kappaLô��������������߹�ϵ��
deltaL=4; %'dfbamp'˵�ǹ�һ��ʧг����DFB���ģ�����������ʧг��L=��-��0����ƫ���դ�����񲨳��Ķ�����
%m=16; %16����դ���ڣ�ѡ�ò���n1=3.2515;n2=3.456����m=round(kappaLg/(2*r))���㣬���ƺ��������ò�����ע��Ϳռ䲽���ԱȾͺá�
N=31; NF=1:1:N+1; %�ռ䲽��N��������NF
repeat=15*N; % number of repeats of field calculations
%����������������ã�repeat��Ҫ�÷Ŵ����в��ﵽ�ȶ�����������е�t�����Լ���15�飬��ʵʱͼ�������ȶ��Ļ��������ٶ��㼸�顿
kappas=kappaL/N; %ÿ���ռ䲽���ϵ���ϡ�����,sΪ�ռ䲽����s=L/N
rsp = 
isp = 





% ԭ���߰�mL,��Ͼ���sint/cost[��Ӧsin_T/cos_T]д����ͬԪ�صľ����ˣ����ﶼ������������
mL=exp((gL-j*deltaL)/N); %�����棬ֱ����ָ����ʽ��û�н���
%��������Ƿ������δ���飬�����ô���������ϡ�û�н���ȡ��sint=kappas
sin_T = kappas /(1 + 0.25*kappas^2);
cos_T = (1- 0.25*kappas^2) /(1 + 0.25*kappas^2);

%��ַ������cos(��-��s-jgs)=cos��cos�¡�����
A=(gL+j*deltaL).*NF;
B=kappaL.*NF;
C2=A.^2+B.^2; C=sqrt(C2);
a=cosh(C);
rr=sinh(C)./C;
d=A.*rr; b=B.*rr;
check=a.*a-d.*d-b.*b;

%��һ�����һ�ͼ�����귶Χ��ֱ�Ӱ������
ad=1/(a(N+1)-d(N+1));
FF=a+d-(b*b(N+1)*ad);
RR=-b+((a-d)*b(N+1)*ad);
PFA=FF.*conj(FF);PRA=RR.*conj(RR);
SY=max(PFA)+max(PRA);

%��ʼֵ���� δ��ֵ��0
ff=zeros(N+1,1); fr=ff;

tic;

figure;
axis([1 N+1 0 SY+1])
for rep=1:1:repeat
    ff(1) = 1;
    ffn(1) = 1;
    fr(N+1) = 0;
    frn(N+1) = 0;
    for n=1:N
        ffn(n+1) = mL*cos_T*ff(n) + j*mL*sin_T*fr(n+1);
        nr=N+1-n;
        frn(nr) = mL*cos_T*fr(nr+1) + j*mL*sin_T*ff(nr);
    end
    ff=ffn;fr=frn;
    PF=ff.*conj(ff);PR=fr.*conj(fr);
    
    drawnow;
    plot(NF,PF,'-',NF,PR,'--');
    
end
toc;
