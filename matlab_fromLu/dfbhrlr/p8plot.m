% Plotting routines : no choice;

clear Afr;clear Pfr; clear PF ;clear PR

Nemax=max(Ne);
figure;plot(1:N,Ne);
axis([1 N 0.7 Nemax*1.1]);
title('Normalised Electron Density - Distance')
xlabel('section number');
ylabel('normalised electron density')
pause(1); % allows one to view briefly the plot

PF=ffn.*conj(ffn); PR=frn.*conj(frn);
mx=max(PF+PR);
figure;plot(ms,PF+PR,'k-',ms,PF,'r:',ms,PR,'g--'); axis([1 NF 0 mx]);
title('Photon/s (solid sum, dotted forward, dashed reverse)');
xlabel('field number'); 
ylabel('relative power');
pause(1);  % allows one to view briefly the plot 


