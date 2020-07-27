% SPECTRUM OF SHORT PULSE
% This program uses the FFT to calculate the spectrum of a Short Pulse;
% The pulse length is varied from 4 ps to 10 ps
% It compares the FFT with the analytic expression;
% The error through omission of high frequencies at sharp edges is demonstrated
% Program checks Parseval's theorem on power.

% There are two recommended versions: an FFT of length N = 64 and N = 512.
% The first shows up clearly the discretisation. 
% The second shows the effect of increasing the number of sample in a given time.
% The total time duration is kept the same with FFT length of 64 ps.


% Minimum frequency interval 1/64 THz.
% The more steps means a higher spectral range.
% Time steps taken as 1 *(64/N) ps with N FFT frequency steps.
% fmax=(N/64)THz gives maximum spectral range.
% Nyquist frequency range -fmax/2 to +fmax/2.  


clear all;
colortog; %to ensure black on white background default 

disp('FFT analysis of short pulse in time');
disp('FFT length of 64 in 64 ps shows discretisation clearly');
disp('FFT length of 512 in 64 ps shows effect of more sample points');
cont=input('Press return to continue');
disp('FFT length N=2^M ');
M=input('set M (try 6 first then try 9; press enter for default 6)');  if isempty(M)
	M=6;
 end;	% sets up the FFT length: 
% with N=64 one can see the discrete points clearly.
% with N=512 one can see the approach to a near continuum.
% Note the larger frequency range with more samples.

N=2^M; 		% FFT length;
tn=(1:N);	% sets up a counter of FFT length;
t=tn*(64/N);	% sets the time steps in ps -overall time is 64 ps in this example;
fn=(tn-N/2-1)/N;% fn is normalised frequency with N steps from -1/2 to + 1/2;
f=fn*(N/64);	% frequency in THz with time steps of 1 ps for N=64;
% Note Normalised Nyquist frequency is 0.5 so for 1 ps time steps fmax=0.5 THz;
% Hence here fmax= 0.5*(N/64) THz = N/128;
disp('Input pulse duration ');
Tin=input('(try 10 first then try 3; press enter for default 10)  ');
disp('wait for program to run');%do not keep pressing return;
if isempty(Tin); Tin=10; end;	% sets up pulse duration in ps
Td=Tin*N/64; % number of sample points 
a=zeros(size(tn)); for n=1:Td; a(n)=1; end % sets up sampled pulse;


figure;
axis([0 64 -1.1 1.2]);
text(10,1.1,'Input pulse (sampled)');
xlabel('time in ps');ylabel('temporal amplitude');
puls1=line('Xdata',t,'Ydata',real(a),'color','r','LineStyle','+','MarkerSize',4);
pause(3);
A=(1-exp(-j*2*pi*(f+10^(-15))*Tin))./(sqrt(Tin)*j*2*pi*(f+10^(-15))); 
% analytic spectrum: 10^(-15) term prevents (zero/zero)
% sampling of the pulse means that the starting time is not exactly zero
phi=exp(j*pi*(64/N)*(f+10^(-15)));
% phase term phi corrects for the starting time by half a step setting:-
A=phi.*A;
A=A/max(A); % normalises spectrum
% the analytic spectrum has different dimensions from the DFT spectrum
% to avoid this difficulty only a relative spectrum has been plotted
 
figure;
axis([-N/128 N/128 -1 1.2]);
text(-N/135,1.1,'Analytic Frequency Spectrum (real+ : imaginary o)');
xlabel('frequency (THz)');
ylabel('relative spectral amplitude');
rl1=line('Xdata',f,'Ydata',real(A),'color','r','LineStyle','+','MarkerSize',4);
im1=line('Xdata',f,'Ydata',imag(A),'color','b','LineStyle','o','MarkerSize',4);
		% plots analytic sampled spectrum;
pause(3); 

AA=(fft(a)); 	% Matlab code for ordering the frequency +/- f about zero;
		% A is DFT of a with normalised frequency step of 1/N and time steps of 1 ;
AA=fftshift(AA);% Matlab code for ordering the frequency +/- f about zero;
		% if actual time step is 1 psec total frequency range is 10^12 Hz;
aa=ifft(fftshift(AA)); 
		% inverse fft to check that temporal signal is correct;



Paf=abs(AA.*conj(AA));	% Power spectrum 
Pafm=max(Paf);
norm= sqrt(Pafm);

figure;
axis([0 64 -1.1 1.2]); % sets scale rather than autoscale;
text(10,1.1,'Pulse Signal Reconstituted from DFT');
xlabel('time in ps'); 
ylabel('temporal amplitude');
puls2=line('Xdata',t,'Ydata',real(aa),'color','r','LineStyle','+','MarkerSize',4);
% plots DFT results;
pause(3);

figure;
axis([-N/128 N/128 -1 1.2]); % sets scale rather than autoscale;
text(-N/135,1.1,'DFT relative spectrum (real+ : imaginary o)');
xlabel('frequency (THz)'); 
ylabel('normalised spectral amplitude');
rl2=line('Xdata',f,'Ydata',real(AA/norm),'color','r','LineStyle','+','MarkerSize',4);
im2=line('Xdata',f,'Ydata',imag(AA/norm),'color','b','LineStyle','o','MarkerSize',4);
		% plots dft results;
pause(3)

figure
axis([-N/128 N/128 -0.11 0.12]); % sets scale rather than autoscale;
text(-N/135,0.12,'error-frequency (real+ : imaginary o)');
text(0.01-N/128, 0.085, 'sharp edges contain frequencies > than Nyquist limit - causes error')
xlabel('frequency (THz)'); 
ylabel('normalised spectral amplitude error');
rl2=line('Xdata',f,'Ydata',real(-A+AA/norm),'color','r','LineStyle','+','MarkerSize',4);
im2=line('Xdata',f,'Ydata',imag(-A+AA/norm),'color','b','LineStyle','o','MarkerSize',4);
		% plots error between dft and analytic results;
% Below checks on Parsevals theorem noting normalised frequency step is 1/N ; 
% (sum(Paf))/N should be same as sum(aa.*conj(aa));
tsum=sum(aa.*conj(aa))  % sum of amplitude of aa squared ;
fsum=(sum(Paf))*(1/N)   % written so as to emphasise sum 'frequencies' x step length;
disp('checks sum of amplitudes^2 in time tsum');
disp(' = sum of amplitudes^2 in frequencies fsum');
		% display shows the time and frequency sums are equal.;

run=input('do you want another run y/n ?  ','s');
if isempty(run); run='y';end;
if run=='y';spect5;end;
if run=='n';end;