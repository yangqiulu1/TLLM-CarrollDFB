
disp('Plots normalised light-drive characteristics for rate equations');
disp('- as in appendix 4 of book.');
cont=input('Press return to continue');
% Parameters for normalised light current characteristic
clear all;
colortog; %to ensure black on white background default 
S=input('Spontaneous coupling coefficient beta =10^(-S); S = 5 default; S (>0) =  ');
if isempty(S); S=5; end; 
disp(' Gain Saturation coefficient is gainsat= gs*10^(-2)') 
gs= input('normalised gain saturation coefficient (gs: 0.1 to 10; default 2) = '); 
if isempty(gs); gs=2; end;
beta=10^(-S); 	% spontaneous coupling;
a=0.3;		%ratio of transparency/threshold carrier density;
Q=1000;		% ratio of effective carrier recombination time/photon lifetime; 
e=(1/100)*gs;

Lmax=1.5;	% value of maximum normalised light output; 
L=beta/10:(Lmax/200):Lmax+beta/10;
U=L+e*(1-a)*L.^2;
V=L+beta*(1-a)*(1+e*L);
N=U./V;
D=L+N*(1-beta);

figure;plot(0,0,D,L,'r',D,N,'b');
xlabel('Normalised drive');
ylabel('Normalised light output');
title('Light-drive (red); Carrier-drive (blue)')
bet=num2str(1000*beta);
text(0.5, .8, 'beta x 1000'); text(0.5, 0.7, bet);
sat=num2str(gs);
text(0.5, 1.4, 'gain sat x 100');text(0.5, 1.3, sat);

run=input('do you want another run y/n ?  ','s');
if isempty(run); run='y';end;
if run=='y';fpstat;end;
%end;