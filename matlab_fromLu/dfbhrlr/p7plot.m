% Plotting routine : no choice;

clear Afr;clear Pfr; clear PF ;clear PR

Nf=(1:STP)-(STP/2)-1;
Afr=fftshift(fft(OR)/STP);Pfr=Afr.*conj(Afr);
figure;plot(Nf*fn,10*log10(Pfr)); axis([-750 750 -70 10]);
title('Normalised Power Spectrum - Frequency (GHz)')
xlabel('frequency -GHz');ylabel('relative power  dB')
pause(1);  %allows one to view the plot briefly - can make pause longer
