% SPECTRUM OF COMPLEX SINE WAVE
% This program uses the FFT to calculate the spectrum of a complex sine wave;
% It compares the FFT with the analytic expression;
% Program checks Parseval's theorem on power.

% There are two recommended versions:- 
% an FFT of length N= 64 and N = 512
% The total time duration is kept at 64 ps as FFT length varies.
% The first shows up clearly the discretisation. 
% The second shows the effect of increasing the number of samples in a given time.
% Minimum frequency interval 1/64 THz.
% The more steps means a higher spectral range.
% Time steps taken as 1 *(64/N) ps with N FFT frequency steps.
% fmax=(N/64)THz gives maximum spectral range.
% Nyquist frequency range -fmax/2 to +fmax/2.  
% The chosen frequency is f0 = (1/16) THz.

clear all;
colortog; %to ensure black on white background default 

disp(' ')
disp('DFT analysis of complex signal with one frequency');
disp('FFT length of 64 shows discretisation clearly')
disp('FFT length = 512 shows effect of more sample points in given time');
cont=input('Press return to continue');
disp(' ');
disp('FFT length N=2^M ; ')
M=input('Set M (try 6 first then try 9; press enter for default 6)');
if isempty(M);	M=6; end;	% sets up the FFT length: 
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
disp(' ');
disp('input frequency f0 in THz 1/64 <f0 <0.2: ')
f0=input('or press return for default 1/16:-  ');
disp('wait for program to run');%do not keep pressing return;
  if isempty(f0);
	f0=1/16;end;
% frequency in THz;
% smallest frequency interval with 64 ps duration is 1/64 THz;
nf0=f0*64; % the sampled point number in the frequency domain;   

ta=1:2048; ta=ta*64/2048; % gives enough sample points to ensure good analytic representation
a0=exp(j*2*f0*pi*ta); 

a=exp(j*2*f0*pi*t); % sets up a sampled complex amplitude with a positive frequency;

figure;
axis([0 64 -1.1 1.2]);
text(10,1.1,'Complex (Single Frequency) Input [real(+) / imag(o)]');
xlabel('time in ps');ylabel('temporal amplitude');
rl1=line('Xdata',ta,'Ydata',real(a0),'color','r','LineStyle','-');
im1=line('Xdata',ta,'Ydata',imag(a0),'color','b','LineStyle','--');
pause(3);

% Analytic power spectrum of this input signal has unit value at input frequency f0;
% f0 not necessarily at sampling point in frequency domain
Paf=zeros(1,N); % sets up a set of N spectral points;

figure;
po1=line('Xdata',f,'Ydata',Paf,'color','g','LineStyle','.','MarkerSize',4);
poA=line('Xdata',f0,'Ydata',1,'color','r','LineStyle','o','MarkerSize',4);
centre=line('Xdata',0,'Ydata',0,'color','b','LineStyle','+','MarkerSize',4);
text(-N/135,1.1,'Analytic Power Spectrum');
axis([-N/128 N/128 -1.1 1.2]);
xlabel('frequency (THz)');
ylabel('spectral amplitude');
pause(3); 

%FFT guts of program follows

A=(fft(a)); 	% Matlab code for ordering the frequency +/- f about zero;
		% A is DFT of a with normalised frequency step of 1/N and time steps of 1 ;
A=fftshift(A); 	% Matlab code for ordering the frequency +/- f about zero;
		% if actual time step is 1 psec total frequency range is 10^12 Hz;
aa=ifft(fftshift(A)); 
		% inverse fft to check that temporal signal is correct;

Paf=abs(A.*conj(A));	% Power spectrum 
Pafm=max(Paf);

figure;
text(10,1.1,'Reconstituted Complex Signal [real(+) /  imag(o)] ');
axis([0 64 -1.1 1.2]); % sets scale rather than autoscale;
xlabel('time in ps'); 
ylabel('temporal amplitude');
rl2=line('Xdata',t,'Ydata',real(aa),'color','r','LineStyle','+','MarkerSize',4);
im2=line('Xdata',t,'Ydata',imag(aa),'color','b','LineStyle','o','MarkerSize',4);
		% plots DFT results;
pause(3);

fmin=min(abs(f-f0)); %checks if f0 is at a sampling point in frequency domain

figure;
text(-N/135,1.1,'Normalised DFT Power Spectrum (..)');
axis([-N/128 N/128 -1.1 1.2]); % sets scale rather than autoscale;
xlabel('frequency (THz)'); 
ylabel('normalised spectral amplitude');
po2=line('Xdata',f,'Ydata',Paf/Pafm,'color','r','LineStyle','o','MarkerSize',4);
		% plots dft results;
centre=line('Xdata',0,'Ydata',0,'color','b','LineStyle','+','MarkerSize',4);
if abs(f0)>0;text(-0.4,-0.5,'note offset frequency');end; 
if fmin>0;
text(-N/128+.05,-0.8,'original input frequency not at sample point in frequency domain','fontsize',10);
end;

% Below checks on Parsevals theorem noting normalised frequency step is 1/N ; 
% (sum(Paf))/N should be same as sum(aa.*conj(aa));
tsum=sum(aa.*conj(aa))  % sum of amplitude of aa squared ;
fsum=(sum(Paf))*(1/N)   % written so as to emphasise sum 'frequencies' x step length;
disp('checks sum of amplitudes^2 in time tsum');
disp(' = sum of amplitudes^2 in frequencies fsum');
disp('Note time and frequency sums are equal');
		
run=input('do you want another run y/n ?  ','s');
if isempty(run); run='y';end;
if run=='y';spect1;end;
if run=='n';end;
