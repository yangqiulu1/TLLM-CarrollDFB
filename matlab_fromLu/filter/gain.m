disp('This program demonstrates the theory of the Lorentzian filter');
disp(' applied to gain in a travelling wave system: see section 7.9');
disp('White Noise excitation gives a broad band frequency excitation');
disp('1st figure shows, using fft, noise amplification v. frequency');;
disp('Exactly same noise excitation now excites same filter but with zero gain');
disp('2nd figure shows ratio of two noise ouput powers v. frequency');
%The output at time step r goes into the next input at time step r+1;
% The parameters required:
disp(' K is the filter parameter determining bandwidth: see filt1.');
% phase is the normalised offset frequency giving the phase shift per step.
% gs  the gain per step typically 1/32 here
% length - this is an integer = number of steps of length h
% for demonstration length has been taken to be 128
% M the number 2^M required for the fft - taken as 1024;

clear all;
% colortog % this is introduced to ensure black on white background as default

dF=input('Normalised Offset frequency:   ? (0.5< norm frequency<0.5  0 default) '); 
if isempty(dF)
   dF = 0; end;	% filter parameter as per previous;
%gives offset frequency --zero as default
phase=2*pi*dF;
K=input('K  ? (3>K>0.5 typically   1 default) '); 
disp('Wait while program runs'); 
if isempty(K)
   K = 1; end	% filter parameter as per previous;
Kt=num2str(K);dFst=num2str(dF);		%ready for displaying values
M = 10	;	% gives number 2^M for fft 
length =64;
gs = 1/32;
% theoretical gain should be 10*log10(exp(2*gs*length))

NT=round(2^10);
fz=0.7071*(randn(1,NT+1)+j*randn(1,NT+1)); FZ=fz; %sets up future variables
pnorm=sum(abs(fz(1).*fz(1))); % provides normalisation for the output power

fz1=zeros(1,NT+1);FZ1=fz1;
rep=length;
fornd=randn(rep+1,1);

aa= (K-1+0.5*gs)/(1+K-0.5*gs);
bb=(1+K+0.5*gs)/(1+K-0.5*gs);
cc=(1-K+0.5*gs)/(1+K-0.5*gs);

gs=0;
AA= (K-1+0.5*gs)/(1+K-0.5*gs); %parameters for zero gain section;
BB=(1+K+0.5*gs)/(1+K-0.5*gs);
CC=(1-K+0.5*gs)/(1+K-0.5*gs);
gs=1/32; % restores gain for future use

fzo=fornd(1);FZo=fzo; PHase=phase;
%tic;
for r=1:rep
   fz1o=fornd(r+1);
   fz1(1)=bb*fz(1)+cc*exp(j*phase)*fzo+ exp(j*phase)*aa*fz1o;
   for n=1:NT;
      fz1(n+1)=bb*fz(n+1)+cc*exp(j*phase)*fz(n)+exp(j*phase)*aa*fz1(n);
   end;
   fzo=fz1o;fz=fz1;
   
   %Recalculates above with zero gain but exactly the same stochastic input;
   
   FZ1o=fornd(r+1);
   FZ1(1)=BB*FZ(1)+CC*exp(j*PHase)*FZo+ exp(j*PHase)*AA*FZ1o;
   for n=1:NT;
      FZ1(n+1)=BB*FZ(n+1)+CC*exp(j*PHase)*FZ(n)+exp(j*PHase)*AA*FZ1(n);
   end;
   FZo=FZ1o;FZ=FZ1;
end;
'toc';
fzf=fz1(2:NT+1); FZf=FZ1(2:NT+1); 
yy=fft(fzf,NT);YY=fft(FZf,NT);
yy=fftshift(yy);YY=fftshift(YY);
pf=(yy.*conj(yy))/(pnorm*NT);
PF=(yy.*conj(yy))./(YY.*conj(YY));
% Theoretical maximum gain;
thm=10*log10(exp(2*gs*length));
tm=num2str(thm);

figure;
plot(((1:NT)-NT/2)*(1/NT),10*log10(pf));
axis([-0.5 0.5 -15 ceil(thm+15)]);
title('Amplified white noise - frequency');
xlabel('Normalised Frequency/Nyquist frequency range');
ylabel('dB');
text(-0.48,-10,'max theoret. gain');
text( 0.3,-10,tm);
text(-0.3,25,'K');text(2/pi,25,Kt);
text(-0.48,20,'frequ. offset');text(0.3,20,dFst);
pause(3);

figure;
plot(((1:NT)-NT/2)*(1/NT),10*log10(PF));
axis([-0.5 0.5 -15 ceil(thm+15)]);
title('Gain-frequency');
xlabel('Frequency/Nyquist frequency range');
ylabel('dB');
text(-.48,-10,'max theoret. gain');
text( 0.3,-10,tm);
text(-0.3,25,'K');text(0.3,25,Kt);
text(-0.48,20,'frequ. offset');text(0.3,20,dFst);
