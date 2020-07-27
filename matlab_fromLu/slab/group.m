clear all;
colortog;
%Program for guiding created by symmetrical 3-slab layer
er1=10.0362; %permittivity of cladding 
er2=12.0362;	%permittivity of core
werd1=0.963067; % angular frequency times differential of permittivity with ang. frequ. in 1
werd2=8.13536;% angular frequency times differential of permittivity with ang. frequ. in 2
delteps=(er2-er1);
Aw=0.5*(werd2-werd1)/delteps;
theta=((1:650)-1)*(pi/2000); %optical guide width ranging from near zero to 0.35 pi
Bw=0.5*(werd2-(werd2-werd1)*cos(theta).^2);
V=2*theta./cos(theta);
Rvmp=sqrt(er2-delteps*((cos(theta)).^2));
Rvmg=Rvmp+(Bw./Rvmp)+0.5*(1+Aw)*delteps*theta.*sin(2*theta)./((1 +theta.*tan(theta)).*Rvmp);
Rvmgo=Rvmp+0.5*delteps*theta.*sin(2*theta)./((1 +theta.*tan(theta)).*Rvmp);
vmp=1./Rvmp; % phase velocity/c
vmg=1./Rvmg; % group velocity/c but with no material effects
vmgo=1./Rvmgo;% group velocity/c with material effects
nph=Rvmp; %phase index
npg=Rvmg;	%group index with material effects
npgo=Rvmgo;	%group index with no material effects
figure;
plot(V,vmp);
axis([0 4 sqrt(1/er2) sqrt(1/er1)]);
xlabel('Normalised frequency');ylabel('Phase Velocity')
title('Phase velocity -Normalised frequency');
figure;
plot(V,nph,V,npg,V,npgo);
title('Group Index(magenta/blue) Phase(red)-Norm. Frequ.');
xlabel('Normalised frequency');ylabel('Index');
figure;
plot(V,vmp,'r',V,vmg,'m',V,vmgo,'b');
title('Group Vel.(magenta/blue) and Phase Vel.(red)- Norm Frequ.');
xlabel('Normalised frequency');ylabel('Velocity/c');
