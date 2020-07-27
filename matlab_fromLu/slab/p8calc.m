% Sets search routines to minimise transverse reflection coefficient; 
% Sets the imaginary part of the effective permittivity to its mean value.
% (a) Scans possible real effective refractive indices.
% (b) Scans possible imaginary parts of effective refractive indices.
% Repeats (a) and (b) twice like balancing a circuit reactance bridge.
% Displays progress as the calculation proceeds.

refract=sqrt(permittivity7);
refind8=zeros(2,1); logr8=zeros(1,100);
R8=zeros(1,3);
%ind=zeros(1,100);
ER8=R8;confine8=R8;

% ER8 are trial effective refractive indices for up to 3 modes
% R8 are trial effective log reflection coeficients for up to 3 modes
S=1;SS=1; % WITH GAIN GUIDES CAN HELP TO CHANGE S=0.5 AND RESAVE
%S and SS determine how fine a grid of points is taken at each search
% The smaller S and SS the finer the searching but the longer the process.

% an initial rough attempt at the imaginary effective refractive index for first search
%effind8(1)=real(sqrt(sum(permittivity7.*thick7)/sum(thick7)));
%effind8(2)=imag(sqrt(sum(permittivity7.*thick7)/sum(thick7)));


dxi=max(imag(refract))-min(imag(refract));
dxr=max(abs((refract)))-min(real(refract))+2*dxi; 
refrmax8=max(real(refract));
refimax8=max(imag(refract));
SS8=0.25
disp('Recommend changing SS8 to around 0.5 for gain guides');
effind8=[(refrmax8 - SS8*dxr) (refimax8-SS8*dxi)];
% an initial rough imaginary effective refractive index for first search

deltr8=SS*dxr; % SS can be changed for DIFFICULT CASES.
delti8=S*dxi;
p9search;%does initial search and displays reflection against trial refractive index.

for mu=1:6
   mum=ceil(mu/2);
   change8=(j^mu)*0.5*((1-(-1)^mu)*delti8+(1+(-1)^mu)*(deltr8/200))/(100^(mum-1));
   p11serch;
end;
%repeats search alternatively with imaginary and real search areas 
% - method is like balancing a reactance bridge;

for kkk=1:MN1,
   if real(ER8(kkk))>0;
      effind8(1)=real(ER8(kkk));effind8(2)=imag(ER8(kkk));
      effperm8=ER8(kkk).^2;
      logrho=p10refl(effind8);
      rho=exp(logrho);
      %final check on calculation.
      p12layer;% turns layers into finer layers for plotting;
      p13field; %plots fields and far fields;
      confine8(kkk)=confine13;
   end;
end;
if tme1=='m';con='TM Confinement factors';end
if tme1=='e' con='TE Confinement factors';end;
format bank;disp(con);disp(confine8);format short;
%end;


