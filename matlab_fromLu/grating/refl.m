clear all
colortog; %black on white background as default
disp('Calculates reflection from a DFB grating');
disp('     with coherent unit input at L=0.'); 
disp('Normalises beta, delta=d, field gain=g ');
disp('         to magnitude of kappa=k:');
disp('hence respectively bk =b/k  dk= d/k and gk =g/k'); 
disp('       are the normalised parameters.');
disp('Choose magnitude  kappa*length - (1 < kL < 8 ');
kl=input('kappa*length product ? (default 1):-  '); 
if isempty(kl); kl=1; end;
disp('  ');
disp('Complex coupling uses a phase factor pha to give k*exp(j*pha).'); 
disp('Choose pha = 0 for a pure index grating.');
disp('Choose pha = pi/2 for a pure gain grating.');
pha=input('Choose phase pha for complex kappa in radians now (default 0):-  '); 
disp('Wait while program runs');
if isempty(pha); pha=0; end;
phi=exp(j*pha);
al = 0.5; 

%st is the number of steps in the mesh
st=25; % an integer
% student matlab will require this to be limited to 31;
dk=0:(9/st):9;

gk=0:((kl+1)/(2*kl*st)):((kl+1)/(2*kl));
disp(' ');
disp('gain can be offset to explore reflection: ');
disp('positive gain offset increases reflection;');
disp('negative gain offset decreases reflection.');
disp('Beware of oscillation giving inf. reflection.') 
gko=input('Offset for "gain x kappa" product (0 default ):   ');
disp('Wait while program runs');
if isempty(gko); gko=0;end;
al = 0.5; % puts in an offset loss;
% range chosen to keep reflection not too large
gk=gk+gko-al; % shows effect of loss as well as gain if gko=0

% The propagation constant beta = sqrt((delta+ j*gain)^2 - kappa^2);
% reflection coeff = (kappa/beta)sin(beta length)/(a-d)
% where a= cos(beta length) and d =((gain - j delta)/beta) sin(beta length)
% kappa length = kl*exp(j*pha)=kl*phi
for m=1:(st+1);for n=1:(st+1);
mu(n,m) = (gk(n)-j*dk(m)) ;
bk(n,m)=sqrt(-(mu(n,m)^2 + phi^2));
end; end;
aa = cos(bk*kl) ; 
dd =sin(bk*kl).*(mu./bk);  
bb = j*phi*sin (bk*kl).*(1./bk);

rho=abs(bb./(aa-dd));
figure;mesh(dk, gk, rho);
mmm=max(max(rho));
xlabel('delta/kappa');
ylabel('gain/kappa');
zlabel('reflectivity');
axis([0  9  gko-al gko-al+1 0 2*mmm]);
view(10,20);
if pha==0;
title('Field Reflection magnitude from real index grating');
elseif abs(pha)==pi/2;
title('Field Reflection magnitude from pure gain grating');
else;
title('Field Reflection magnitude from complex grating');end;

phrho=angle(bb./(aa-dd));
figure;mesh(dk, gk, phrho);hf=gcf;
xlabel('delta/kappa');
ylabel('gain/kappa');
zlabel('phase of reflectivity');
axis([0 9 gko-al gko-al+1 -pi 1.5*pi])
view(10,20);
if pha==0;
title('Field Reflection phase from real index grating');
elseif abs(pha)==pi/2;
title('Field Reflection phase from pure gain grating');
else;
title('Field Reflection phase from complex grating');end;
pause(3);
figure(hf-1);

run=input('do you want another run y/n ?  ','s');
if isempty(run); run='y';end;
if run=='y';refl;end;