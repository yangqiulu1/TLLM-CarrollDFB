disp('LORENTZIAN DIGITAL FILTER FOR GAIN FILTERING EXCITED BY WHITE NOISE')
disp('SAME FILTER AS FILT1 - checks filter theory with noise excitation');
disp('Out +tau d/dt (Out) = In  : see equ. 7.8.1 in book.');
disp('time step length s/vg, normalised filter parameter K = 2*tau*vg/s');
disp('Nyquist frequency range = vg/s');
disp(' ')
disp('Display in text uses normalised angular frequency ranging from -pi to pi;');
disp('Display here normalises to Nyquist frequency range -0.5 < norm.frequ.< 0.5');
% On is output new; Oo is output old;Inn is input new; Ino is output old;
% On+Oo+(2*tau*vg/s)(On-Oo)=Inn+Ino;
% for finite difference time step s/vg is normalised to 1; 
% write K = 2*tau*vg/s as normalised filter parameter;
% Normalised angular (positive) frequency goes to 0 to pi;
% The continuous theory is implemented digitally with Lax averaging as:
% Out(+1/2)+Out(-1/2) +K(Out(+1/2)-Out(-1/2))=In(+1/2)+In(-1/2).
% Note half time step given here to show up symmetry.
% Total time step = 1 so normalised (total) frequency goes to -0.5 to +0.5;
% Actual frequency from -0.5*vg/s  to +0.5*vg/s;
% Program shows how to offset the central frequency of the filter with complex K

% Complex Random inputs excite filter for NT= 2^M time steps 
% Program gives the fft power spectrum out.

clear all;
%colortog % this is introduced to ensure black on white background as default

% numbers of 'for' statements labelled at start and end by %A %B etc.


% Inputs as below:

dF=input('Normalised Offset frequency/(Nyquist frequ. range) (-0.5<dL< 0.5):   ? (dF=0) '); 
if isempty(dF);
   dF = 0; end	%gives offset frequency with zero as default
dL=2*pi*dF;
% K is filter parameter as above with K = 1 default;
K=input('K  ? (K=1) (K>0 only - default =1) '); 
if isempty(K);
   K = 1; end;	

% COMPUTING PARAMETERS;
M = 10; 	% gives number 2^M for fft 
rep = 7;	% gives number of repeats to average noise;


% ANALYTIC THEORY CALCULATION

ph=exp(j*dL); 			% gives offset frequency phase shift;
NT=round(2^M); 			% points for fft	
%th is normalised (angular) frequency  -pi to +pi   taking whole range;
mt=1:NT;th=-pi+(2*pi*mt/NT)-dL; % finely divides the frequency range into NT steps
% exp(j*th/2)gives phase shift per half step 
yy=cos(th/2)./((cos(th/2)+j*K*sin(th/2)));
ptheory=20*log10(abs(yy)+10^(-6));	%gives power theory plot with non-stochastic input;

ms=(1:NT); ms=(ms/NT)-0.5;		% counter for frequencies
figure;hold on;




% START OF STOCHASTIC INPUT;	
power=zeros(1,NT);ff=power; % sets up variables

In=0.7071*randn(rep,NT+1)+j*0.7071*randn(rep,NT+1); 

% above line gives different random complex inputs for all repeats  


for r=1:rep				%A
   ff(1)=In(r,1);
   for n=1:NT-1;		%B
      ff(n+1)=-ph*((1-K)/(1+K))*ff(n)+(1/(1+K))*(In(r,n+1)+ph*In(r,n));
   end;			%B
   y=fft(ff,NT)/NT; 	
   p=fftshift(y); 
   power=p.*conj(p)+power;
   if r< rep;					%C
      ff(1)=ff(NT);
      %In(r,NT)=In(r+1,1);
   end % sets up initial conditions for repeat;	%C
end;							%A
pnorm=power*NT*NT/sum(sum(In.*conj(In))); 			
% pnorm normalises power out to power in;
plot(ms,10*log10(pnorm));

% END OF STOCHASTIC INPUT

% DISPLAY ROUTINES

axis([-0.5 0.5 -20 15]);
xlabel('Normalised Frequency');
ylabel('dB : power (solid)  ');
title('Frequency - Power Spectrum');
plot(ms,ptheory,'c');
% overlays with digital theory to check noise method.
hold off;
%end;
%end;
[a,b]=max(ptheory);		% gives value and array position of maximum
centre=(b-512)/512;
aa=a-ptheory(512); if aa<.001; aa=0; end; % avoids silly print outs
At=num2str(aa);
cent=num2str(centre/2);
Kt=num2str(K); dFst=num2str(dF)
text(-.45, 13, 'K parameter and offset norm. frequ.');text(.15, 13, Kt);text(.35, 13, dFst)
text(-.48, 10, 'max power norm. frequency');text(0, 10, cent);
text(.15, 10, '[p max/p(0)](dB)');text(.48, 10, At);
[c,d]=min (abs(ptheory(1:b)+3)); dd=-1+d/512;   % finds left 3dB point
[e,f]=min (abs(ptheory(b+1:1024)+3));fd=((b-512)+f)/512;	 % finds right 3dB point

ddt=num2str(dd/2);fdt=num2str(fd/2);
%text(-.35, 7, ddt);text(-.1,7,'3dB points');text(.25, 7, fdt);
text(-.4, 7, ddt);text(-.15,7,'3 dB points');text(.3, 7, fdt);
% ANOTHER RUN?
run=input('do you want another run y/n ?  ','s');
if isempty(run); run='y';
end;
if run=='y';filt1n;
end;
clear(run);
%end;
disp(' ');