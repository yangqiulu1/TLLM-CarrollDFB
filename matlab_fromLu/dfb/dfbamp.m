disp('DFB Amplifier with unit coherent input - only at L=0.');
disp('Value of kappa x length can be set.');
disp('Input frequency can be offset by parameter delta x length.'); 
disp('Gain can be set through gain x length.');
disp('Plots build up of internal fields with time.');
disp('Once fields have settled - compares with analytic result.');
cont=input('Press return to continue');
% Plots fields after NF time steps, starting with zero fields.
% Display allows one to see build up of the internal field with time.
% Will repeat calculation 'repeat' times starting with previous fields
% This allows one to see how fields propagate inside the laser
% Solid line is forward power and dashed line is reverse power

% figure 1 gives forward and reverse power (unit input) by finite difference method. 
% repeats this for the number of repeat steps
% figure (repeat+1) gives steady state forward and reverse power (unit input) by analytic method.
% figure (repeat + 2) gives error from analytic steady state.

% Before running set kL the (kappa x length) feedback parameter, 
% set gL the gain parameter 
% and set dL the offset frequency for the input.
% set number of space steps ie number of sections to finite difference
% set number of time steps
% set repeat number 

clear all;
%colortog  % ensures black on white plotting;
% Parameters

kL=input('Coupling  kL?  [.5< kL< 4] (press enter for default 2)  ');
if isempty(kL)
   kL=2
end;	% normalised coupling coefficient default of kL=2; 
disp('    ');
disp('Beware choosing normalised gain too large so that oscillation occurs:');
disp('gL < 1/kL advised.');
gL=input('Amplitude gain gL ?  [< 2] (press enter for default 1/kL)  ');
if isempty(gL)
   gL=1/kL
end;	% normalised amplitude gain coefficient default of gL=1/kL; 

dL=input('Offset frequency dL?  [-8 < dL < +8] (press enter for default 4)  ');
if isempty(dL)
   dL=4
end;	% normalised offset frequency  coefficient default of dL=4;


N=31; 			% there are N space steps so that there N+1 field points.
NF=N+1;			% this is number of field points;
repeat=15*N;		% number of repeats of field calculations
% 'repeat' has to be sufficiently large to allow fields to settle

m=1:NF;			% counter for the field points
ks=kL/N;		% s is the space step: length normalised to kappa length. 
ms=ones(1,N);

% The next section is the analytic solution for unit input at L=0 (or m=1) 

dgL=(gL+j*dL).*(m-1)/N;
kmL=ks.*(m-1);
KL2=(dgL).^2+(kmL).^2;
KL2(1)=KL2(2)/10000;% to avoid (zero/zero) later on at KL =zero.
KL=sqrt(KL2);
a=cosh(KL);		% = 1 at KL =zero
rr=(sinh(KL)./KL);	% note problem of zero/zero at KL =zero if not tackled.
d=dgL.*rr;b=kmL.*rr;ad=1/(a(N+1)-d(N+1));
FF=a+d-(b*b(N+1)*ad);
RR=-b+((a-d)*b(N+1)*ad);
check=a.*a-d.*d-b.*b;	%should equal unity.
PFA=FF.*conj(FF);PRA=RR.*conj(RR);
SY=max(PFA)+max(PRA);

% The next section is the numerical solution for unit input at L=0 (or m=1) 

ff=zeros(NF,1);
fr=ff;			% sets up fields F(1),...F(N+1); R(1),....R(N+1).
dgc=(gL+j*dL)*ms;	% could be an array of different sections
% gain and phase in each section :taken as constant;
% use central difference approximation here
mL=(2*N+dgc)./(2*N-dgc);	% central difference approximation to exp((gL+j*dL)/N)

sint=mL.*ks;cost=mL.*sqrt(1-ks^2); % reflection matrix values
% in principle ks can vary from section to section and be an array:




tic; % remove % in front of tic and toc below to see time of calculation.

figure;
axis([1 NF 0 SY]);

FORW=line('Xdata',1,'Ydata',0,'color','c','linestyle','-','erasemode','xor');
REVE=line('Xdata',1,'Ydata',0,'color','r','linestyle','--','erasemode','xor');
rep=1;timefl=0;timeo=num2str(timefl);
time=num2str(timefl);
tmt=text(NF/2,1,time,'color','k','erasemode','background','fontsize',12);

while rep<repeat;
   ff(1)=1;
   ffn(1)=1;
   ffn(2)=cost(1)*ff(1)+j*sint(1)*fr(2);
   frn(NF)=0;
   frn(N)=cost(N)*fr(NF)+j*sint(N)*ff(N);
   
   for n=2:N;	
      ffn(n+1)=cost(n)*ff(n)+j*sint(n)*fr(n+1);
      nr=N+1-n;
      frn(nr)=cost(nr)*fr(nr+1)+j*sint(nr)*ff(nr);		% PROGRAM GUTS				   	%A						   
   end;						
   ff=ffn;fr=frn;
   
   PF=ff.*conj(ff);PR=fr.*conj(fr);
   set(FORW,'Xdata',m,'Ydata',PF); 
   set(REVE,'Xdata',m,'Ydata',PR);
   
   
   timefln=round(rep*NF/200)*200; % used to avoid too frequent text plotting;
   time=num2str(timefln);
   
   if timefln>timefl; 		% used to avoid too frequent text plotting;
      text(NF/4,1,'time','color','k','erasemode','background');
      set(tmt,'string',time);
      text(NF/10,0.95*SY, 'Power Flow - distance (solid forward;dashed reverse)','erasemode','background');
      drawnow; % gives update overplotting to see field development.
      timeo=time;timefl=timefln;
   end;	
   
   rep=rep+1;
end;
plot(m,PF,'-',m,PR,'--');
axis([1 NF 0 SY]);
xlabel('field points');ylabel('rel.power');
text(NF/4,1,'time','color','k','erasemode','background');
text(NF/2,1,time,'fontsize',12);
text(NF/10,0.95*SY, 'Power Flow - distance (solid forward;dashed reverse)','erasemode','background');
toc; % remove % in front of toc and tic above to see time of calculation.
pause(5);

figure;
plot(m,FF.*conj(FF),m,RR.*conj(RR),'--',m,abs(check),'.');
axis([1 (N+1) 0 SY]);
text(25,1.1,'unit gain')
title('Analytic Power Flow - distance (solid forward;dashed reverse)')
ylabel('relative power');xlabel('field points');
pause(5);

figure;
plot(m,(ff.*conj(ff))-FF.*conj(FF),m,(fr.*conj(fr))-RR.*conj(RR),'--');
title('Power-Error - distance (solid forward; dashed reverse)');
ylabel('net error');xlabel('field points');

% ANOTHER RUN?
run=input('do you want another run y/n ?  ','s');
if isempty(run); run='y';end;
if run=='y';dfbamp;end;
clear(run);
disp(' ');