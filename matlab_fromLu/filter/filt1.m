disp('LORENTZIAN DIGITAL FILTER FOR GAIN FILTERING')
disp('Based on analytic solution of "Lorentzian" differential equation:-');
disp('Out +tau d/dt (Out) = In  : see equ. 7.8.1 in book.');
disp('time step length s/vg, normalised filter parameter K = 2*tau*vg/s');
disp('Nyquist frequency range = vg/s');
disp('Display in text uses normalised angular frequency ranging from -pi to pi;');
disp('Display here normalises to Nyquist frequency range -0.5 < norm.frequ.< 0.5');
% On is output new; Oo is output old;Inn is input new; Ino is output old;
% On+Oo+(2*tau*vg/s)(On-Oo)=Inn+Ino   gives finite difference algorithm
% for finite difference time step s/vg is normalised to 1; 
% write K = 2*tau*vg/s as normalised filter parameter;
% The continuous theory is implemented digitally with Lax averaging as:
% Out(+1/2)+Out(-1/2) +K(Out(+1/2)-Out(-1/2))=In(+1/2)+In(-1/2).
% Note half time step given here to show up symmetry.
% Total time step = 1 so normalised frequency range goes to -0.5 to +0.5;
% Actual frequency from -0.5*vg/s  to +0.5*vg/s;
% Program shows how to offset the central frequency of the filter with complex K
% Complex Random inputs excite filter for NT= 2^M time steps 
% Program gives the fft power spectrum out.

clear all;
%colortog % this is introduced to ensure black on white background as default

g=1;	% g is the peak gain of the filter at the central frequency		
% Kramers Kronig relations mean peak gain g has to be real

% numbers of 'for' statements labelled at start and end by %A %B etc.


% Inputs as below:

dF=input('Normalised Offset frequency/(Nyquist frequ. range) (-0.5<dL< 0.5):   ? (dF=0) '); 
if isempty(dF);
   dF = 0; 
end	%gives offset frequency with zero as default
dL=2*pi*dF;
% K is filter parameter as above with K = 1 default;
K=input('K  ? (K=1) (K>0 only - default =1) '); 
if isempty(K);
   K = 1; 
end;	

% COMPUTING PARAMETERS;
M = 10; 	% gives number 2^M for fft 
rep = 8;	% gives number of repeats to average noise;


% ANALYTIC THEORY CALCULATION

ph=exp(j*dL); % gives offset frequency phase shift;
NT=round(2^M); 
%th is normalised (angular) frequency  -pi to +pi   taking whole range;
mt=1:NT;th=-pi+(2*pi*mt/NT)-dL; % finely divides the frequency range into NT steps
% exp(j*th/2)gives phase shift per half step 
yy=g*cos(th/2)./((cos(th/2)+j*K*sin(th/2)));
ptheory=20*log10(abs(yy)+10^(-6));	%gives power theory plot with non-stochastic input;

gnthry=20*log10(abs(real(yy))+10^(-6));		%gives real part of theoret. gain

imagplus=20*log10(abs((0.5*(imag(yy)+abs(imag(yy)))))+10^(-6));
imagneg =20*log10(abs((0.5*(-imag(yy)+abs(imag(yy)))))+10^(-6));
% the addition of minute real terms is to avoid log zero where possible

ms=(1:NT); ms=(ms/NT)-0.5;
figure;hold on;


% DISPLAY ROUTINES

axis([-0.5 0.5 -20 15]);
xlabel('Frequency/(Nyquist frequency range)');
ylabel('dB:net g(solid);real g.....;imag g: pos -.-. neg - - -');
title('Frequency - Gain Spectrum');
plot(ms,ptheory,'b',ms,gnthry,'r:',ms,imagplus,'g-.',ms,imagneg,'m--');
% overlays with digital theory to check noise method.
hold off;
%end;
%end;
[a,b]=max(gnthry);		% gives value and array position of maximum
centre=(b-512)/512;
aa=a-gnthry(512); 
if aa<.001; aa=0; 
end; % avoids silly print outs
At=num2str(aa);
cent=num2str(centre/2); % number halved to get right normalised frequency;
Kt=num2str(K); dFst=num2str(dF);
text(-.45, 13, 'K parameter and offset norm. frequ.');text(.15, 13, Kt);text(.35, 13, dFst)
text(-.48, 10, 'max gain norm. frequ.');text(-.08, 10, cent);
text(.12, 10, '[g max /g(0) real](dB)');text(0.48, 10, At);
[c,d]=min (abs(gnthry(1:b)+3)); dd=-1+d/512;   % finds left 3dB point;
[e,f]=min (abs(gnthry(b+1:1024)+3));fd= ((b-512)+f)/512;	 % finds right 3dB point;

ddt=num2str(dd/2);fdt=num2str(fd/2); % number halved to get normalised frequency right.
text(-.4, 7, ddt);text(-.15,7,'3 dB points');text(.3, 7, fdt);
text(-.25,5,'for the real part of the gain');
%end;

% ANOTHER RUN?
run=input('do you want another run y/n ?  ','s');
if isempty(run); run='y';
end;
if run=='y';filt1;
end;
clear(run);
%end;
disp(' ');