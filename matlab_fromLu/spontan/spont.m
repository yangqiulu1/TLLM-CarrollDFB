clear all;
%colortog  % ensures black on white background as default;

disp('PROGRAM PRESENTS THE "CLASSICAL" CONCEPT OF SPONTANEOUS NOISE');
disp('ADDED TO COHERENT SIGNALS.');
disp('Initial demonstrations adds white noise to coherent signal');
disp('giving snapshots in time. Note random phase/amplitude at each step.');
disp('FFT of signal plus noise presented');
cont=input('Press return to continue and wait for program to run');
% Input:-

M=10;	 %integer - sets the size for the fft 2^M;

% BEWARE of too large a value for M for memory/speed of PC.
NT=round(2^M); % to ensure integer value;

% IDEAL COHERENT SIGNAL (FIXED LINE IN ARGAND DIAGRAM)
coh=sqrt(5)+j*sqrt(5);

% WHITE NOISE 
Nx=0.7071*randn(1,NT+1) ; Ny=0.7071*randn(1,NT+1);  % Independent random phase inputs

figure;fnum=gcf;
title('Display of Coherent + Noise Field with time ');
xlabel('real'); ylabel('imaginary'); 
axis([0 5 0 5]);drawnow;
fx=real(coh)+Nx;fy=imag(coh)+Ny; %(magnitudes chosen to show effects best)
cohspon=fx+j*fy;  % adding white noise with coherent signal as vectors in argand diagram;

% DISPLAY WITH TIME OF COHERENT FIELD PLUS FULL BANDWIDTH WHITE NOISE

%fldpt=line('Xdata',0,'Ydata', 0,'color','b','linestyle','.','markersize',10,'erasemode','none');
%fldline=line('Xdata',0,'Ydata', 0,'color','r','linestyle','-','markersize',6,'erasemode','xor');
fldpt=line('Xdata',0,'Ydata', 0,'color','b','LineStyle','.','erasemode','none');
fldline=line('Xdata',0,'Ydata', 0,'color','r','LineStyle','-','erasemode','xor');
for r=750:1000;
set(fldline,'Xdata',[0 fx(r)],'Ydata',[0 fy(r)]);
set(fldpt,'Xdata',fx(750:r),'Ydata',fy(750:r));
drawnow;
end; pause(2);

title('Coherent + Noise Field ');
set(fldline,'Xdata',[0 real(coh)],'Ydata',[0 imag(coh)]);drawnow;
pause(3) 
% standard gaussian spontaneous noise added to coherent field;

%entim = sum(cohspon(1:NT).*conj(cohspon(1:NT))/norm;
% finds energy per point in time.
%%
% SPECTRUM
y=fft(cohspon(1:NT)); 
y=fftshift(y)/NT; 		
% displays the spectrum with NT/2 as the zero frequency
aa=y.*conj(y); % energy in frequency for all intervals.

ms=(1:NT)-NT/2;
figure(fnum+1);
plot(ms/1024,10*log10(aa));
axis([-1/8 1/8 -60 20]);
title('Power Spectrum')
ylabel('dB');xlabel('Normalised Frequency')
pause(3)

%FILTERING SIGNAL TO PRODUCE NARROW BAND NOISE
disp('SIGNAL NOW FILTERED TO GIVE A NARROW BAND INCOHERENT SIGNAL.');
disp('OUTPUT OF FILTER IN TIME SHOWS THE FIELD FOLLOWING A RANDOM WALK.');
disp('Spectrum of filtered signal shown using FFT'); 
cont=input('Press return to continue and wait for program to run');
sponb=zeros(size(cohspon));
for r=1:NT;
sponb(r+1)= (.94)*sponb(r)+(.03)*(cohspon(r+1)+cohspon(r)); 
end;


yb=fft(sponb(1:NT)); 
yb=fftshift(yb)/NT; 		
% will give the spectrum with NT/2 as the zero frequency
bb=yb.*conj(yb); % energy in frequency for all intervals.
%send;  	    
pause(3);

%DISPLAY OF NARROW BAND NOISE
fxb=real(sponb);fyb=imag(sponb);
figure(fnum+3)
axis([0 3 0 3]);
title('Coherent + NARROW BAND Noise Field with time ');
xlabel('real'); ylabel('imaginary');

%fldpt=line('Xdata',0,'Ydata', 0,'color','b','linestyle','.','markersize',10,'erasemode','none');
%fldline=line('Xdata',0,'Ydata', 0,'color','r','linestyle','-','markersize',6,'erasemode','xor');
fldpt=line('Xdata',0,'Ydata', 0,'color','b','linestyle','.','erasemode','none');
fldline=line('Xdata',0,'Ydata', 0,'color','r','linestyle','-','erasemode','xor');

for r=750:1000;
set(fldline,'Xdata',[0 fxb(r)],'Ydata',[0 fyb(r)]);
set(fldpt,'Xdata',fxb(750:r),'Ydata',fyb(750:r));
drawnow;
end; 

pause(2);
title('Coherent + NARROW BAND Noise Field ');
set(fldline,'Xdata',[0 real(coh)],'Ydata',[0 imag(coh)]);drawnow;
pause(3) 


% SPECTRUM
figure(fnum+4);
plot(ms/1024,10*log10(bb));
axis([-1/8 1/8 -60 20]);
title('Filtered Power Spectrum');
ylabel('dB');xlabel('Normalised Frequency');
%end;

run=input('do you want another run y/n ?  ','s');
if isempty(run); run='y';end;
if run=='y';spont;end;
if run=='n';end;












