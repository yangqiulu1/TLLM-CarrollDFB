disp('Performs dynamic calculation of normalised rate equations');
disp('- as in appendix 4 of book.')
cont=input('Press return to continue');
% Requires parameters as below - can be changed;
clear all;
colortog; %to ensure black on white background default 
S=input('Spontaneous coupling coefficient beta =10^(-S); S = 5 default; S (>0) =  ');
if isempty(S); S=5; end; 
disp(' Gain Saturation coefficient is gainsat= gs*10^(-2)') 
gs= input('normalised gain saturation coefficient (gs: 0.1 to 100; default 2) = '); 
if isempty(gs); gs=2; end;
beta=10^(-S); 	% spontaneous coupling;
bc=1-beta;
a=0.3;		% ratio of transparency/threshold density;
Q=1000;		% ratio of electron recombination time/photon lifetime;
h=.25;		% step length in terms of photon lifetime;
e=(1/100)*gs;	% gain saturation parameter normalised;
D=2.5;		% drive value in terms of nominal threshold;
NPT=1500;	% total number of photon lifetimes required;

% Program starts
NP=300;		% number of photon lifetimes per calculation;
repeat=NPT/NP;	% number of repeats;
NT= ceil(NP/h);	% number of time steps required integer;
T=1:NT;T=h*T;
L=zeros(NT,1);M=L;

figure; 
ymax=2.7*D;			% may need to adjust ymax if light peaks too high.
axis ([0 repeat*NP 0 ymax]);	% sets up figure
title('normalised light/time (solid) ;  normalised carrier/time (dashed)');
xlabel('time/photon lifetime');
bet=num2str(1000*beta);
text(200, 1.4, 'beta x 1000 ');text(200, 1, bet);
sat=num2str(gs);
text(200, 2.4, 'gain sat x 100 ');text(200, 2, sat);
dt=num2str(D);
text(3000,2,'drive');text (4000,2,dt);

L(1)=beta;			%sets up initial light to spontaneous level;
for r=1:repeat;
for n=1:NT-1;
delt=(((M(n)-(L(n)/Q)-a)*(L(n)/(1+e*L(n))))/(1-a))-L(n)+beta*(M(n)-(L(n)/Q));
L(n+1)=L(n)+h*delt;
M(n+1)=M(n)+(h/Q)*(-(1+(bc/Q))*L(n)-M(n)*bc+D);
end;
N=M-L/Q;
TT=T+(r-1)*h*NT;

light=line('Xdata',TT,'Ydata',L,'color','r','linestyle','-');
density=line('Xdata',TT,'Ydata',N,'color','b','linestyle','--');
				% light in red and electron density in blue;
drawnow;

M(1)=M(NT);L(1)=L(NT); 		% sets up light/electrons for repeat run
end;

run=input('do you want another run y/n ?  ','s');
if isempty(run); run='y';end;
if run=='y';fpdyna;end;
%end;