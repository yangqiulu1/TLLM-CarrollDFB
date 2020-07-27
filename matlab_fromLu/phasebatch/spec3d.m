% "spec3D": Plotting routine for use with dfb15;
% This programme is very similar to "p7plot", but stores spectra after
% they are calculated, and then plots them out in 3-D form.

clear Afr;clear Pfr; clear PF ;clear PR

Nf=(1:STP)-(STP/2)-1;
Afr=fftshift(fft(OR)/STP);Pfr=Afr.*conj(Afr);
W = floor(750/fn);
dbpfr = 10*log10(Pfr);
matp(R,:) = dbpfr;

Ym = step_ph*(1:Rmax);% scaling for y axis in terms of facet phase.

Xm = fn*Nf((STP/2 -W):(STP/2 + W + 1)); % scaling for x axis
Xmm = ceil(fn*Nf(STP/2 + W + 1)); % ensures a "tight" x axis on plot.

mesh(Xm,Ym,matp(:,(STP/2 - W):(STP/2 + W + 1)));  % 3-D plot
axis([-Xmm Xmm 0 4*pi -80 10]);
title(['Facet phase scan: 0 to 4*pi, kappa = ',num2str(kappa)]);
xlabel('GHz rel.');
ylabel('phase 0 to 4*pi');


drawnow;