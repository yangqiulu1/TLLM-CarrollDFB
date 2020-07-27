% DEMONSTRATES VALUE OF SPECTRAL LIMITING
% This program calculate FFT spectrum of 'well' spectrally limited pulse;
% It compares the FFT with the analytic expression ;
% Checks on Parseval's theorem;

% The number of points is limited to N=64 in a time T=N=64 to show the discretization;
% The normalised time step is 1 so that the normalised frequency step is 1/N;
% A real time step of 1 ps with N FFT frequency step is fmax=(10^3/N) GHz;
% Nyquist frequency range -fmax/2 to +fmax/2 
% Normalisation here to fmax so normalised frequency runs from -0.5 to +0.5;

% The pulse = 0.5*(1 + cos(2*pi*(F*t))); for t=-Np/2 to +Np/2  Np < N/2 where F*Np=1;
% The analytic Fourier spectrum in frequency f is given from;
% Aa=A1+A2+A3
% A1= 0.5*Np*sin(pi*f*Np)./(pi*f*Np);
% A2=0.25*Np*sin(pi*(f-F)*Np)./(pi*(f-F)*Np);
% A3=0.25*Np*sin(pi*(f+F)*Np)./(pi*(f+F)*Np); 

clear all;
colortog; %to ensure black on white background default

disp('Demonstration to show value of spectral limiting');
disp(' to improve temporal accuracy in use of FFT');
disp('demo. uses only FFT with N=64  with normalised time and frequency');
cont=input('Press return to continue');

M=6; % sets up the FFT length;
N=2^M; % FFT length;
disp('Pulse duration in steps?  ');
Np=input('even only  [4<= duration < 52] (or press enter for default 14)  ');  
disp('wait for program to run');%do not keep pressing return;

if isempty(Np)
   Np=14;
end;	% gives pulse duration with default of Np=13;
disp('wait while program runs: pulse duration:-');
disp(Np);
F=1/Np;
t=1:N; 
t=(t-N/2-1); % t is normalised time about zero as a reference;
f=t/N; % sets up normalised frequency to run from -1/2 to +(1/2)-(1/N);
% f is the normalised frequency with spectral steps of 1/N;
a=zeros(1,N); % sets up input amplitude vector against normalised time;

for n=1:Np;
   a(1,n+N/2-Np/2)=0.5*(1 + cos(2*pi*(F*(n-1-Np/2))));
end;			% sets up a cosine input pulse of Np steps.;



A=fftshift(fft(a)); % Matlab code for ordering the frequency +/- f about zero;
% A is DFT of a with normalised frequency steps of 1/N and time steps of 1 ;
% if actual time step is 1 psec total frequency range is 10^12 Hz;
aa=ifft(fftshift(A)); % inverse fft to check that pulse shape is correct;

d=10^(-16);	% miniscule number to avoid division by zero in next line; 
A1=0.5*Np*sin(pi*(f-d)*Np)./(pi*(f-d)*Np); 
A2=0.25*Np*sin(pi*(f-F-d)*Np)./(pi*(f-F-d)*Np);
A3=0.25*Np*sin(pi*(f+F-d)*Np)./(pi*(f+F-d)*Np); 
Aa=A1+A2+A3;
Pa=abs(Aa.*Aa);
Pam=max(Pa);
figure;f0=gcf;
axis([-.5 .5 0 1.2]);
text(-.48,1.1,'Pulse Input (o) and Normalised Analytic Power Spectrum (+) at points shown','fontsize',10);
xlabel('Normalised frequency & time scale'); 
amp1=line('Xdata',t/N,'Ydata',a,'color','r','Marker','o','MarkerSize',5);
pow1=line('Xdata',f,'Ydata',Pa/Pam,'color','b','Marker','+','MarkerSize',5);
% plots analytic result;
pause(3);


Paf=abs(A.*A);
Pafm=max(Paf);
figure(f0+1);
axis([-.5 .5 0 1.2]); 
text(-0.48,1.1,'Reconstituted Pulse (o) and Normalised FFT Power Spectrum (+) at points shown','fontsize',10);
xlabel('Normalised frequency & time scale ');
amp2=line('Xdata',t/N,'Ydata',aa,'color','r','Marker','o','MarkerSize',5);
pow2=line('Xdata',f,'Ydata',Paf/Pafm,'color','b','Marker','+','MarkerSize',5);
% plots dft results;
pause(3);

figure(f0+2);
plot(f,abs((Paf-Pa)/Pam),'Marker','o'); % plots fractional error in power spectrum;
title('Fractional Error in Calculated Power Spectrum'); % autoscaled;
xlabel('Normalised frequency');
% Note fractional error significantly less than for pulse with poor spectral limitation.;

% Check on Parsevals theorem noting frequency step is 1/N ; 
% (sum(Paf))/N should be same as sum(a.*a);
tsum=sum(a.*a);
fsum=(sum(Paf))*(1/N); % written so as to emphasise sum 'frequencies' x step length
disp('tsum=');disp(tsum);
disp('wait while program runs');
disp('fsum=');disp(fsum);
% display checks that these two are equal.;
% total energy in default example given is comparable to pulse in spect1.;
disp('checks sum of amplitudes^2 in time tsum');
disp(' = sum of amplitudes^2 in frequencies fsum');
% display checks that these two are equal.;
figure(f0);pause(3);
figure(f0+1);pause(3);
figure(f0+2);pause(3);
figure(f0);

run=input('do you want another run y/n ?  ','s');
if isempty(run); run='y';end;
if run=='y';m5spect7;end;
if run=='n';end;