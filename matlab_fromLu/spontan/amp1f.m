disp('Second demo of spontaneous emission shows');
clear all;
colortog  % ensures black on white background as default;

disp('   again how noise builds up with distance but now');
disp('NOISE IS FILTERED IN THIS RUN');
disp('No gain so forward field propagates as:-');
disp(' dF/dz + dF/(vg t) = Is  where');   
disp('Is is Random spontaneous emission and');
disp('    Is is proportional to P N product');
disp(' |Is|^2 = B*PN ');
disp('Noise power proportional to amplifier length');
disp('Observe noise amplitude doubles on quadrupling amplifier length');
cont=input('Press return to continue and wait for program to run');
% Normalised step length s in space and s/vg in time;
% Here vg is group velocity normalised to 1;
% s=1/16 ; Normalised length L takes values 0.5,1,2 or 4
% fmax is maximum normalised frequency range +/- 1/(2*s);
% Number of steps along amplifier is Ns;
% Number of field points along amplifier is Nf=Ns+1;


% Demonstration sets normalised lengths at 0.5,1, 2 and 4 respectively 
% PN value set to default normalised value of 1.
% Quadruple the length and observe the noise amplitude relative to the field.
% Observe noise amplitude doubling on quadrupling the length.
% Observe normalised spectrum and normalised field plots; 
% Low field amplitude varies dramatically in amplitude and phase from time to time


Fi=10; % normalised coherent input field (chosen purely illustratively);
% coherent input at central frequency so that with modelling procedure
% no phase shift is recorded as length increases;
figure;f0=gcf;  
for n=1:4						%(A)
L=2^(n-2); % runs through the various lengths, see next %(A) for end statement.
Lstr=num2str(L); % for printing length later

PN=1; %spontaneous emission fixed at default normalised setting
BPN = PN;  % default value of product of B*PN 

Ns=8*L; %Number of total steps along the laser  (<= 32)
Nf=Ns+1; % Number of field points for the laser including end fields
% Ns is also total number of insertion points of spontaneous noise in laser
fmax=4*256  ;% size of fft 1024

Fout=zeros(5*256,1); 	% vector for output fields with time;
F=zeros(1,Nf);FF=F;	% set up vectors for fields inside laser
rs=sqrt(BPN); % spontaneous noise will be rs*R where R is random
In=Fi*(0.7071+j*0.7071); % Input coherent field (phase chosen to be 45 arbitrarily).
Inr=[0 real(In)];Inim=[0 imag(In)];  % used for plotting later
RO=(randn(256,Ns)+j*randn(256,Ns))*(0.5);
for nn=1:5 						%A

% five repeats with 256 points - last 1024 giving fft
R=(randn(256,Ns)+j*randn(256,Ns))*(0.5); 	% random spontaneous array;
RN(2:256,2:Ns)=R(2:256,2:Ns)+R(1:255,1:(Ns-1));  
RN(2:256,1)=R(2:256,1)+RO(1:255,Ns);
RN(1,2:Ns)=R(1,2:Ns)+RO(256,1:(Ns-1));
RN(1,1)=R(1,1)+RO(256,Ns);
RO=R;
% This array ensures correlation of adjacent points in time and space;
% Making an array saves some time on calculation - lookup table
% Mean square |R| is unity for each element

% PROGRAM GUTS: F is field at t, FN is field at t+1;
F(1,1)=In; %coherent input field - same at all times
for t=1:256						%B
FN(1,1)=In+0.5*rs*RN(t,1); 
% half the spontaneous emission associated with section 1 loaded at front; 
for m=2:(Nf-1);						%C
FN(1,m)= F(1,m-1)+0.5*(rs*RN(t,m-1)+rs*RN(t,m));
% half the spontaneous associated with section m-1 and with m added into field at m;
FN(1,Nf)= F(1,Nf-1)+0.5*rs*RN(t,Nf-1); 
% half the spontaneous associated with final section Nf-1 added to final field at Nf;
F=FN;
Fout((nn-1)*256+t,1)=F(1,Nf);
F(1,1)=In;
end;							%C
end;							%B
end;							%A

Fo=Fout(257:1280); % selects the last fmax number of outputs ; 
Ffo=fftshift(fft(Fo)); % fft ordered to get central frequency correct
P=(Fo.*conj(Fo));
Pf=(Ffo.*conj(Ffo))/fmax;
Pav=sum(P)/fmax; % average power output;
Pfav=sum(Pf)/fmax; % average spectral power output;
Pl=10*log10(P);
Pfl=10*log10(Pf)-50;
figure(f0+n-1);
subplot(1,2,1);
xx=(1-fmax/2:1:fmax/2);
plot(xx/fmax,Pfl);
axis([-0.5 0.5 -60 15]); 
xlabel('Normalised frequency');
ylabel('dB');
text(-.45,17,'Coherent+Spont.Power v.frequ.','fontsize',9);
text(-450,10,'Laser Norm. Length');text(0,5,Lstr);
drawnow;
subplot(1,2,2);plot(real(Fo),imag(Fo),'.',Inr,Inim,'r');
hold on
plot(Inr,Inim-.06,'r',Inr,Inim+.06,'r',Inr-.06,Inim,'r',Inr+.06,Inim,'r');
% line thickening;
hold off;
axis([-9 23 -18 46]); % (may need to be changed if input field is changed)
text(-5,42,'Laser Norm. Length');text(7,35,Lstr);
text(-5,30,'NO GAIN OR LOSS');
xlabel('Real field amplitude');
ylabel('Imaginary field amplitude');
text(-8,49,'Coherent(red)+Spont.Amplitude','fontsize',9);
drawnow;
end;	
pause(2);
figure(f0);pause(2);figure(f0+1);pause(2);
figure(f0+2);pause(2);figure(f0+3);pause(2);									%(A)
