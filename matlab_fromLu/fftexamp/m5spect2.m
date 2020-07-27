% SPECTRUM OF COMPLEX SINE WAVE TO DEMONSTRATE ALIASING
% This program looks at the representation of a sine wave with two lengths of FFT;
% The frequency is too high for the shorter FFT to give the correct result

% There are two recommended versions:-
% an FFT of length N= 64 and N = 512.
% The total time duration is kept at 64 ps for all FFT lengths.
% Minimum frequency interval 1/64 THz.
% The more steps means a higher spectral range.
% Time steps taken as 1 *(64/N) ps with N FFT frequency steps.
% fmax=(N/64)THz gives maximum spectral range.
% Nyquist frequency range -fmax/2 to +fmax/2.  
% The frequency of f0 = (9/16) THz  for both FFT lengths of N
% This exceeds the Nyquist frequency for N = 64 

clear all;
disp(' ');
disp('DFT analysis of complex signal with one (high) frequency');
disp('FFT of 64 sample points in 64 ps shows aliasing');
disp('              for frequency f0 > 0.5 THz');
disp('but FFT length of 512 shows good spectral restoration');
disp('           for same frequency f0');
cont=input('Press return to continue');
disp('FFT length N=2^M;')  
M=input('Set M (try 6 first then try 9; press enter for default 6):- ');
if isempty(M);	M=6; end;	% sets up the FFT length: 

N=2^M; 		% FFT length;
tn=(1:N);	% sets up a counter of FFT length;
t=tn*(64/N);	% sets the time steps in ps -overall time is 64 ps in this example;
fn=(tn-N/2-1)/N;% fn is normalised frequency with N steps from -1/2 to + 1/2;
f=fn*(N/64);	% frequency in THz with time steps of 1 ps for N=64;
% Note Normalised Nyquist frequency is 0.5 so for 1 ps time steps fmax=0.5 THz;
% Hence here fmax= 0.5*(N/64) THz = N/128;
disp('  ')
disp('Set input frequency 0.5 < f0 <1 THz: ');
f0=input(' or for default value of 9/16 press return:-  ');
disp('wait for program to run');%do not keep pressing return;
if isempty(f0);	f0=9/16; end;	% sets up frequency in THz 
% smallest frequency interval with 64 ps duration is 1/64 THz;
nf0=f0*64 ; % the sample point number in the frequency domain;   

ta=1:2048; ta=ta*64/2048; % gives enough points to ensure good analytic representation
a0=exp(j*2*f0*pi*ta); 
% sets up approximation to analytic complex amplitude with a positive frequency;

a= exp(j*2*f0*pi*(t-0.5)); % sampled signal at correct sampling rate

figure; 
text(10,1.2,'Complex single positive frequency input: only real part displayed','fontsize',10);
axis([0 64 -1.1 1.3]);
xlabel('time in ps');ylabel('temporal amplitude');
rl1=line('Xdata',ta,'Ydata',real(a0),'color','r','LineStyle','-');
%im1=line('Xdata',ta,'Ydata',imag(a0),'color','b','LineStyle','--'); %imaginary part if required
pause(3);

% Analytic power spectrum of this input signal has an impulse at normalised frequency f=+2;
Paf=zeros(1,N); % sets up a set of N spectral points;
if nf0<((N/2)-1);
Paf(1,N/2+1+nf0)=1; end % puts 1 the power at the correct spectral sampled point

figure;
text(-N/135,1.1,'Analytic Power Spectrum');
axis([-N/128 N/128 -1.1 1.2]);
xlabel('frequency (THz)');
ylabel('spectral amplitude');
po1=line('Xdata',f,'Ydata',Paf,'color','r','Marker','o','MarkerSize',4);
centre=line('Xdata',0,'Ydata',0,'color','b','Marker','+','MarkerSize',6);
if nf0>((N/2)-1);text(.1-N/128,0.5,'input frequency out of range');end;
pause(3); 

A=(fft(a)); 	% Matlab code for ordering the frequency +/- f about zero;
		% A is DFT of a with normalised frequency step of 1/N and time steps of 1 ;
A=fftshift(A); 	% Matlab code for ordering the frequency +/- f about zero;
		% if actual time step is 1 psec total frequency range is 10^12 Hz;
aa=ifft(fftshift(A)); 
		% inverse fft to check that temporal signal is correct;

%Aa=ones(1,N); 	% analytic white noise - spectrum of impulse;

Paf=abs(A.*conj(A));	% Power spectrum 
Pafm=max(Paf);

figure;
text(8,1.2,'Reconstituted Sampled Complex Signal: only real part displayed ','fontsize',10);
axis([0 64 -1.1 1.3]); % sets scale rather than autoscale;
xlabel('time in ps'); 
ylabel('temporal amplitude');
if nf0>((N/2)-1);text(1,1.1,'spurious reconstitution','fontsize',10);end;
if nf0<((N/2)-1);text(1,1.1,'"correctly" sampled reconstitution - ripples reduced by more samples','fontsize',10);end;
rl2=line('Xdata',t,'Ydata',real(aa),'color','r','LineStyle','-');
%im2=line('Xdata',t,'Ydata',imag(aa),'color','b','LineStyle','--');%imaginary part if required
		% plots DFT results;
pause(3);

fmin=min(abs(f-f0)); %checks if f0 is at a sampling point in frequency domain

figure;
text(-N/135,1.1,'Normalised DFT Power Spectrum (..)');
axis([-N/128 N/128 -1.1 1.2]); % sets scale rather than autoscale;
xlabel('frequency (THz)'); 
ylabel('normalised spectral amplitude');
po2=line('Xdata',f,'Ydata',Paf/Pafm,'color','r','Marker','o','MarkerSize',4);
		% plots dft results;
centre=line('Xdata',0,'Ydata',0,'color','b','Marker','+','MarkerSize',4);
if nf0>((N/2)-1);text(-0.4, -0.5,'note spurious offset frequency');end
if nf0<((N/2)-1);text(-0.4,-0.5,'note correct offset frequency');end; 
if fmin>0;
text(-N/128+.05,-0.8,'original input frequency not at sample point in frequency domain');
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
if run=='y';m5spect2;end;
if run=='n';end;
