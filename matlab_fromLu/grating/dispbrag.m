clear all
colortog; %black on white background as default
disp('Program displays the propagation relationships');
disp('         in a uniform Bragg grating.');
disp('Normalises beta, delta=d, field-gain=g');
disp('         to magnitude of kappa=k:');
disp('hence respectively bk =b/k ; dk= d/k and gk =g/k');
disp(' are the normalised parameters.');
disp('  ');
disp('Complex coupling uses a phase factor pha for kappa');
disp('        to give k*exp(j*pha).'); 
disp('Choose pha = 0 for a pure index grating.');
disp(' Choose pha = pi/2 for a pure gain grating.');
pha=input('Choose pha in radians now (default 0):   ');
disp('Wait while program runs');
if isempty(pha); pha=0; end;
phi=exp(j*pha);
phstr=num2str(pha); % number to string for displaying phase;
dk=0:0.1:2;
gk=0:0.075:1.5;
% The propagation constant beta = sqrt((delta+ j*gain)^2 - kappa^2)
for m=1:21;for n=1:21;
bk(n,m)=sqrt((dk(m)+ j*gk(n))^2 - phi^2);
end; end;
figure;mesh(dk, gk, real(bk));
xlabel('delta/kappa');
ylabel('gain/kappa');
zlabel('real beta/kappa');
title('Normalised real propagation constant');
text(2,0,.9,'kappa');text(2,0,.6,'phase');text(2,0,.3,phstr);
pause(3)

figure;mesh(dk, gk, imag(bk));
xlabel('delta/kappa');
ylabel('gain/kappa');
title('Normalised imaginary propagation constant');
zlabel('imag. beta/kappa');
text(2,0,.9,'kappa');text(2,0,.6,'phase');text(2,0,.3,phstr);

run=input('do you want another run y/n ?  ','s');
if isempty(run); run='y';end;
if run=='y';dispbrag;end;
