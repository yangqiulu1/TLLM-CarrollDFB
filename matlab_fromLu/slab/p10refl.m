function logrho=p10refl(effind8);
global layernum7 thick7 permittivity7 wavevector1 tme1 
%calculates the log of the reflection coefficient for a wave 'entering' at the top
%Top wave must be evanescent growing as it approaches bulk region.
% The complex reflection for this one way input is calculated as rho
% Scattering 'matrix' is used to find rho.

N=layernum7;
O=ones(1,N);   %sets up 'unit' vectors
d=thick7;
ep=permittivity7;
ko=wavevector1;
beta2=ko*ko*[(effind8(1)+j*effind8(2))]^2;
%beta2 gives trial square of the z propagation constant;
% effective refractive index is final value of effind8(1)+j*effind8(2));
gg=beta2*O-ko*ko*ep;
gamma=sqrt(gg);
% trial complex transverse propagation constants in layers;

E=zeros(2,2*N);% these set up N of 2x2 transverse propagation matrices;
E(1,1)=1;E(2,2)=1;E(1,2*N-1)=1;E(2,2*N)=1;% sets up end matrices; 

D=E;          % sets size for discontinuity matrices;

g1=gamma(1);gN=gamma(N);

if real(g1)<0 ; gamma(1)=-g1;end;

if real(gN)<0 ; gamma(N)=-gN;end;

% edge complex propagation constants must evanesce;

nd=gamma.*d; % complex optical thickness of each layer;

for p=2:(N-1);
   if abs(nd(p))>400, a=nd(p);disp(a);nd(p)=400*a/abs(a);end;
   %check against overflow;
   E(1,2*p-1)=exp(nd(p)); E(2,2*p)=exp(-nd(p));
end;
% propagation 2x2 matrices;

if tme1=='m';
   for q=1:N-1
      D(1,2*q-1)=ep(q+1)*gamma(q)+ep(q)*gamma(q+1);D(2,2*q)=D(1,2*q-1);
      D(1,2*q)=ep(q+1)*gamma(q)-ep(q)*gamma(q+1);
      D(2,2*q-1)=D(1,2*q);
   end;
end;
%discontinuity matrices at interfaces

if tme1=='e';
   for q=1:N-1
      D(1,2*q-1)=gamma(1,q+1)+gamma(1,q);D(2,2*q)=D(1,2*q-1);D(1,2*q)=gamma(1,q+1)-gamma(1,q);
      D(2,2*q-1)=D(1,2*q);
   end;
end;
%discontinuity matrices at interfaces
%discontinuity=D;

matrix=[1,0;0,1];M=zeros(2,2*(N-1));
% sets up scattering matrix
for r=1:N-1;
   M(:,2*r-1:2*r)=E(:,2*r-1:2*r)*D(:,2*r-1:2*r);
end;
if tme1=='m';
   for r=1:N-1;
      a=abs(gamma(r))*abs(permittivity7(r+1)); if a<1, a=1;end;
      matrix=matrix*M(:,2*r-1:2*r)/a;    
   end;
end; % This is TM scattering matrix.

if tme1=='e';
   for r=1:N-1;
      a=abs(gamma(r+1)); 
      if a<1, a=1;
      end
      matrix=matrix*M(:,2*r-1:2*r)/a;
   end;
end; % This is TE scattering matrix.

if abs(matrix(1,2))==0, matrix(1,2)=1;
end
rho=abs(matrix(1,1))/abs(matrix(1,2));
% E('incident' bottom)=matrix(1,1)E('incident'top)+matrix(1,2)E('reflected'top);
% E('incident' bottom)=0; hence rho=|E('reflected'top)/)E('incident'top)|;
% rho is the reflection coef. which has to be zero for a proper mode;
if abs(matrix(1,2))==0, rho=1e11;
end;
%The above line avoids unfortunate 'infinities'.
%logrho10=log(rho); % this gives clearer discrimination for the minimum;
logrho=log(rho); % this gives clearer discrimination for the minimum;
%beta=sqrt(beta2);% gives z propagation constant;
%effperm10=(effind8(1)+j*effind8(2))^2; 
% final value of effperm gives effective permittivity;
%end;

