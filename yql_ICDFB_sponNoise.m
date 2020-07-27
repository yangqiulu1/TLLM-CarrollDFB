% 程序包含κ，这是个dfb而不是无反馈的放大器

clear;

kappaL=2;% 1
gL=0.5; %1 %'dfbamp'里是为了归一化取得gL=1/kappaL么？【不理解这两者关系】
deltaL=4; %'dfbamp'说是归一化失谐【看DFB耦合模理论这里就是失谐δL=β-β0，是偏离光栅布拉格波长的度量】
%m=16; %16个光栅周期，选用材料n1=3.2515;n2=3.456，按m=round(kappaLg/(2*r))计算，【似乎本程序用不到，注意和空间步长对比就好】
N=31; NF=1:1:N+1; %空间步数N；场点数NF
repeat=15*N; % number of repeats of field calculations
%【看完整个程序觉得，repeat是要让放大器行波达到稳定，这就是运行的t，所以计算15遍，从实时图看，不稳定的话还可以再多算几遍】
kappas=kappaL/N; %每个空间步长上的耦合【！】,s为空间步长，s=L/N
rsp = 
isp = 





% 原作者把mL,耦合矩阵sint/cost[对应sin_T/cos_T]写成相同元素的矩阵了，这里都当作常数处理
mL=exp((gL-j*deltaL)/N); %复增益，直接用指数形式，没有近似
%增益耦合是否符合尚未检验，仅适用纯折射率耦合。没有近似取成sint=kappas
sin_T = kappas /(1 + 0.25*kappas^2);
cos_T = (1- 0.25*kappas^2) /(1 + 0.25*kappas^2);

%差分方法检查cos(ω-δs-jgs)=cosθcosβ【？】
A=(gL+j*deltaL).*NF;
B=kappaL.*NF;
C2=A.^2+B.^2; C=sqrt(C2);
a=cosh(C);
rr=sinh(C)./C;
d=A.*rr; b=B.*rr;
check=a.*a-d.*d-b.*b;

%这一段是找绘图的坐标范围，直接搬过来的
ad=1/(a(N+1)-d(N+1));
FF=a+d-(b*b(N+1)*ad);
RR=-b+((a-d)*b(N+1)*ad);
PFA=FF.*conj(FF);PRA=RR.*conj(RR);
SY=max(PFA)+max(PRA);

%初始值定义 未赋值均0
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
