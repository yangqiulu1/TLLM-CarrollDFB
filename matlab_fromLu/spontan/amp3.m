clear all;
%colortog  % ensures black on white background as default;

disp('Fourth demonstration varies the gain rather than length');
disp('Model amplifier has total quantum inversion using equation:-');
disp(' dF/dz + dF/(vg t) = g F + Is   ');
disp('    where Is is spontaneous excitation.');   
disp('Here stimulated field gain g is proportional to P N product.'); 
disp('No stimulated absorption because of maximum inversion');
disp('Random spontaneous emission power is also proportional to P N');
disp('Gain increases with PN product so ');
disp('     spontaneous power increases also with PN.')
cont=input('Press return to continue and wait for program to run');
% DEMONSTRATES LIMITING NOISE TO SIGNAL RATIO AT HIGH GAINS 
% |Is|^2 = B*PN while g=A*PN;

% Normalised step length s in space and s/vg in time;
% Here vg is group velocity normalised to 1;
% s=1/16 ; Normalised length L takes values 0.5,1,2 or 4
% fmax is maximum normalised frequency range +/- 1/(2*s);
% Number of steps along amplifier is Ns;
% Number of field points along amplifier is Nf=Ns+1;


% Demonstration sets normalised lengths at 0.5,1, 2 and 4 respectively 
% PN value set to default normalised value of 1.
% 20 % noise added to input field amplitude
% Observe normalised spectrum and normalised field plots; 
% Observe noise and coherent power increase together;
% Observe that (noise+coherent fields)/field gain remain similar
% Low field amplitude varies dramatically in amplitude and phase from time to time;
 
Fi=5; % normalised coherent input field (chosen purely illustratively);
% coherent input at central frequency so that with modelling procedure
% no phase shift is recorded as length increases;
figure;f0=gcf;  
for n=1:3						%O
PN=2^(n-2); % runs through the various lengths, 
Lstr=num2str(PN); % for printing length later

L=2; % Default value of Length
A=1;B=1;% default values of normalised gain and spontaneous emission parameters
g=A*PN; BPN=B*PN;
gL=g*L;% gain length product


Ns=8*L; %Number of total steps along the laser  (<= 32)
Nf=Ns+1; % Number of field points for the laser including end fields
% Ns is also total number of insertion points of spontaneous noise in laser
fmax=4*256  ;% size of fft 1024

Fout=zeros(5*256,1); 	% vector for output fields with time;
F=zeros(1,Nf);FF=F;	% set up vectors for fields inside laser
rs=sqrt(BPN); % spontaneous noise will be rs*R where R is random
In=Fi*(0.7071+j*0.7071); % Input coherent field (phase chosen to be 45 arbitrarily).
Inr=[0 real(In)];Inim=[0 imag(In)];  % used for plotting later

Ag=exp(gL); 		% net field gain along length of amplifier
Ags=(1+0.5*(gL/Ns))/(1-0.5*(gL/Ns));  	% field gain per step

for nn=1:5 						%A
% five repeats with 256 points - last 1024 giving fft

R=(randn(256,Ns)+j*randn(256,Ns))*(.7071); 	% random spontaneous array;
% Array ensures 'no' correlation for all time and space;
% making an array saves some time on calculation - lookup table
% Mean square |R| is unity for each element

% PROGRAM GUTS: F is field at t, FN is field at t+1;
F(1,1)=In; 
%coherent input field same at all times + random noise.
for t=1:256						%B
FN(1,1)=In+0.5*rs*R(t,1); 
% half the spontaneous emission associated with section 1 loaded at front; 
for m=2:(Nf-1);						%C
FN(1,m)= Ags*F(1,m-1)+0.5*(rs*R(t,m-1)+rs*R(t,m));
% half the spontaneous associated with section m-1 and with m added into field at m;
FN(1,Nf)= Ags*F(1,Nf-1)+0.5*rs*R(t,Nf-1); 
% half the spontaneous associated with final section Nf-1 added to final field at Nf;
F=FN;

% add uncertainty in measurement as a random number at the end
% uncertainty independent of gain 
% uncertainty taken arbitrarily as 2*(randn+j*randn)

Fout((nn-1)*256+t,1)=F(1,Nf)+2*(randn+j*randn);
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
axis([-0.5 0.5 -60 60]); 
xlabel('Normalised frequency');
ylabel('dB');
text(-0.45,63,'Coherent+Spont.Power v. frequ.','fontsize',9);
text(-450,10,'PN product');text(0,5,Lstr);
drawnow;
subplot(1,2,2);plot(real(Fo/Ag),imag(Fo/Ag),'.',Inr,Inim,'r');
hold on
plot(Inr,Inim-.05,'r',Inr,Inim+.05,'r',Inr-.05,Inim,'r',Inr+.05,Inim,'r');
% line thickening;
hold off;
axis([-1 7 -2 14]); % (may need to be changed if input field is changed)
text(-.5,13,'PN product');
text(1,11.5,Lstr);
text(-.5,8,'Amplitude Gain =')
text(0,7, 'exp(2 x PN product)');
xlabel('Real field amplitude/gain');
ylabel('Imaginary field amplitude/gain');
text(-0.5,14.5,'Coherent(red)+Spont.Amplitude','fontsize',9);
drawnow;
end;							%O
pause(2);
figure(f0);pause(2);figure(f0+1);pause(2);
figure(f0+2);							%(A)

% uncertainty in initial measurement added in as 'noise'
% Magnitude of uncertainty chosen to show that gain reduces uncertainty;
% However gain adds in noise;
% Observe normalised spectrum and normalised field plots; 
% Observe noise and coherent power increase together;
% Observe that (noise+coherent fields)/field gain remain similar
% Observe that field varies randomly in amplitude and phase with time;