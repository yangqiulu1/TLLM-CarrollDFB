% SPECTRUM OF UNIT IMPULSE
% This program uses the FFT to calculate the spectrum of a UNIT IMPULSE;
% In the continuum, the unit impulse has an infinite value at one point
% It is zero elsewhere but has a unit area underneath the impulse. 
% In the sampled version the unit impulse has a unit value at one of sample point.
% It is zero elswhere. The area is then one unit of the step length.
% It compares the FFT with the analytic expression;
% Program checks Parseval's theorem on power.

% There are two recommended versions: an FFT of length N= 64 and N = 512.
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

disp('FFT analysis of unit impulse in time')
disp('FFT length of 64 in 64 ps shows discretisation clearly')
disp('FFT length of 512 in 64 ps shows effect of more sample points');
cont=input('Press return to continue');
disp(' ');
disp('FFT length N=2^M set M ');
M=input('try 6 first then try 9; press enter for default 6:  ');  if isempty(M)
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
disp('Input pulse position: ')
tin=input('try 1 first then try 2; or press enter for default 1 ');
disp('wait for program to run');%do not keep pressing return;
if isempty(tin); tin=1; end;	% sets up input pulse position in ps
 
t0=1+(tin-1)*(N/64); 	% sample point number at which impulse appears;
a=zeros(size(tn)); a(t0)=1; % sets up sampled impulse;

figure;axis([0 64 -1.1 1.2]);
if tin==1;text(10,1.1,'Input impulse (sampled) at start');end;
if tin==2;text(10,1.1,'Input impulse (sampled) not at start');end;
xlabel('time in ps');ylabel('temporal amplitude');
puls1=line('Xdata',t,'Ydata',real(a),'color','r','Marker','+','MarkerSize',4);
pause(3);

% Analytic spectrum of this input impulse exp(-j*2*pi*f*(tin-1));
% First pulse is at sample point 1, so tin-1 not tin appears as offset time of impulse

A=exp(-j*2*pi*f*(tin-1)); 

figure;
axis([-N/128 N/128 -1.1 1.2]);
text(-N/135,1.1,'Analytic Frequency Spectrum (real+ imaginary o)');
xlabel('frequency (THz)');
ylabel('spectral amplitude');
rl1=line('Xdata',f,'Ydata',real(A),'color','r','Marker','+','MarkerSize',4);
im1=line('Xdata',f,'Ydata',imag(A),'color','b','Marker','o','MarkerSize',4);
pause(3); 

AA=(fft(a)); 	% Matlab code for ordering the frequency +/- f about zero;
		% A is DFT of a with normalised frequency step of 1/N and time steps of 1 ;
AA=fftshift(AA);% Matlab code for ordering the frequency +/- f about zero;
		% if actual time step is 1 psec total frequency range is 10^12 Hz;
aa=ifft(fftshift(AA)); 
		% inverse fft to check that temporal signal is correct;



Paf=abs(AA.*conj(AA));	% Power spectrum 
Pafm=max(Paf);

figure;
axis([0 64 -1.1 1.2]); % sets scale rather than autoscale;
text(10,1.1,'Reconstituted Pulse Signal');
xlabel('time in ps'); 
ylabel('temporal amplitude');
puls2=line('Xdata',t,'Ydata',real(aa),'color','r','Marker','+','MarkerSize',4);
		% plots DFT results;
pause(3);

figure;
axis([-N/128 N/128 -1.1 1.2]); % sets scale rather than autoscale;
text(-N/135,1.1,'DFT spectrum (real+ imaginary o)');xlabel('frequency (THz)'); 
ylabel('relative spectral amplitude');
rl1=line('Xdata',f,'Ydata',real(AA),'color','r','Marker','+','MarkerSize',4);
im1=line('Xdata',f,'Ydata',imag(AA),'color','b','Marker','o','MarkerSize',4);
		% plots dft results;

% Below checks on Parsevals theorem noting normalised frequency step is 1/N ; 
% (sum(Paf))/N should be same as sum(aa.*conj(aa));
tsum=sum(aa.*conj(aa))  % sum of amplitude of aa squared ;
fsum=(sum(Paf))*(1/N)   % written so as to emphasise sum 'frequencies' x step length;
disp('checks sum of amplitudes^2 in time tsum');
disp(' = sum of amplitudes^2 in frequencies fsum');
		% display shows the time and frequency sums are equal.;

run=input('do you want another run y/n ?  ','s');
if isempty(run); run='y';end;
if run=='y';m5spect4;end;
if run=='n';end;
