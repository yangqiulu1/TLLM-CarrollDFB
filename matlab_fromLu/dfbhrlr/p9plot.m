% Plotting routine for Relative Intensity Noise ;
% Best results obtained by letting laser settle down to have two 'identical' runs.
% Because of stochastic input this will vary with each pair of runs
% global RIN power1 sumpow powe
powe=zeros(1,STP); %sets power(old) to zero for later use in RIN calculations;

RED=128; % so long as STP/RED is a power of two this can be changed.
%RED determines how long the run lasts and the lowest frequency
%RED=128 gives lowest frequency around 24MHz and takes 2 hours on a 166 MHz PC 
stor=zeros(1,STP/RED);

			for run=1:RED;
p4run2;
	for rrr=1:(STP/RED);
stor(rrr)=sum(power1(1,1+(rrr-1)*RED:rrr*RED));
	end;
powe(1,(1+(run-1)*STP/RED):(run*STP/RED) )=stor;
				end;
yy=powe/sum(powe);
RIN=fftshift(fft(yy));
RIN(1,(1+STP/2))=10^(-9);

Nf=(1:STP)-(STP/2)-1;
freq=Nf*fn/RED;
mf=max(freq);
mff=mf*10^9; mfl= 10*log10(mff);
RINF=10*log10(abs(RIN)/(STP*mff));
rinmax=max(RINF);
figure;
plot(freq,real(RINF)); 
drvstr=num2str(max(D));
axis([-mf mf -75-mfl rinmax+2]);
text(-mf/4 , rinmax+0.5 ,'Drive');text(mf/4 , rinmax+0.5, drvstr);
title('Relative Intensity Noise Spectrum - Frequency (GHz)');
xlabel('frequency -GHz');ylabel('RIN   dB');
pause(3);  %allows one to view the plot briefly -can make it longer;

