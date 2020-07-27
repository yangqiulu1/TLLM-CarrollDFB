% SPECTRAL DISCRIMINATION OF TWO COMPLEX SINE WAVES
% This program looks at the representation of TWO sine waves
% Two lengths of FFT with same spectral range but different temporal range
% The frequency separation is too low for the shorter FFT to discriminate in frequency

% There are two recommended versions: an FFT of length N= 64 and N = 512.
% The time duration in the first is 64 ps and 512 ps in the second
% Time steps are kept at 1ps with N FFT time steps.
% fmax=1 THz gives maximum spectral range in all cases: -0.5 < f < 0.5.
% Nyquist frequency range -fmax/2 to +fmax/2. 
% The lowest frequency disrimination is therefore either (1/N) THz in this example 
% A frequency f0 = 1/128 THz  for both FFT lengths of N is considered
% Although correctly reconstituted cannot be measured in spectral domain if N = 64 

clear all;
disp(' ');
disp('two complex signals at frequencies 0.25 THz and (0.25+df) THz');
disp('FFT length of 64 cannot discriminate for df < 1/64 Thz');
disp('FFT length of 512 discriminates for df > 1/512 THz');
cont=input('Press return to continue');
disp('FFT length N=2^M  ;')
M=input('set M (try 6 first then try 9; press enter for default 6):- ');
disp('wait for program to run');%do not keep pressing return;
if isempty(M);	M=6; end;	% sets up the FFT length: 

N=2^M; 		% FFT length;
t=(1:N);	% sets up time counter of FFT length;
% sets the time steps in ps -overall time is N ps in this example;
f=(t-N/2-1)/N;% f is frequency with N steps from -1/2 THz to + 1/2 THz;
% time steps of 1 ps for all N;
% for 1 ps time steps fmax=0.5 THz;
df=input('Set offset frequency 1/256 < df< 1/64 THz: or for default value of 1/128 press return:- ');
disp('wait for program to run');%do not keep pressing return;
if isempty(df);	df=1/128; end;	% sets up frequency in THz 

ta=1:2048; ta=ta*N/2048; % gives enough points to ensure good analytic representation
a0=exp(j*2*(.25+df)*pi*ta)+exp(j*2*(.25)*pi*ta); 
% sets up approximation to two analytic complex frequencies with a positive frequency;

a= exp(j*2*(.25+df)*pi*t)+exp(j*2*(.25)*pi*t); % sampled signal at correct sampling rate

figure; 
text(N/10,2.1,'Amplitude of a beating pair of single frequency signals: analytic input','fontsize',10);
axis([0 N 0 2.2]);
xlabel('time in ps');ylabel('temporal amplitude');
rl1=line('Xdata',ta,'Ydata',abs(a0),'color','r','LineStyle','-');
pause(3);

% Analytic power spectrum of this input signal has an impulse at normalised frequency f=+2;
Paf=zeros(1,N); % sets up a set of N spectral points;

figure;
text(0.21,1.1,'Analytic Power Spectrum');
axis([0.2 0.3 -0.2 1.2]);
xlabel('frequency (THz)');
ylabel('spectral amplitude');
po1=line('Xdata',f,'Ydata',Paf,'color','r','LineStyle','o','MarkerSize',4);
f1=line('Xdata',0.25,'Ydata',1,'color','r','LineStyle','o','MarkerSize',4);
f2=line('Xdata',0.25+df,'Ydata',1,'color','r','LineStyle','o','MarkerSize',4);
if df>1/512;
text(.205, -0.1, 'spectral separation analytically can be discriminated');
end;
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

figure;axis([0 N 0 2.2]);% sets scale rather than autoscale;
text(N/10,2.1,'Reconstituted Amplitude of Sampled Complex Signal');
 
xlabel('time in ps'); 
ylabel('temporal amplitude');
rl2=line('Xdata',t,'Ydata',abs(aa),'color','r','LineStyle','o','MarkerSize',3);
		% plots DFT results;
pause(3);

fmin=min(abs(df-f));
disp(fmin);
figure;
po2=line('Xdata',f,'Ydata',Paf/Pafm,'color','r','LineStyle','o','MarkerSize',4);
		% plots dft results;
text(0.21,1.1,'Normalised DFT Power Spectrum (o)');
axis([0.2 0.3 -0.2 1.2]); % sets scale rather than autoscale;
xlabel('frequency (THz)'); 
ylabel('normalised spectral amplitude');
if df<1/N;text(.205 ,-0.05, 'spectral separation not discriminated in fft');end;
if df>1/N;text(.205 ,-0.05, 'spectral separation discriminated in fft');end;
if fmin>0; text(.205 ,-0.15, 'spectral lines not at sampling points');end;
run=input('do you want another run y/n ?  ','s');
if isempty(run); run='y';end;
if run=='y';spect3;end;

