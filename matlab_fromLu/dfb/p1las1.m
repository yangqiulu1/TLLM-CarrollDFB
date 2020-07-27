%STARTING PARAMETERS set out below;

% Material

lambda=1.55;		% free space wavelength in microns
perm=(3.3)^2;		% effective permittivity (refr. index)^2;
grind=3.7;		% group index
vg=3*(10^14)/grind; 	% Nominal group velocity 10^14 microns/s;
Dlambda=80*(10^(-3));	% spontaneous bandwidth in microns
Df=3*(10^14)*Dlambda/(lambda)^2; %Spontaneous bandwidth in hz
h=6.625*10^(-34); 	%joules/sec
frequ=3*(10^14)/lambda;	% frequency
phot=h*frequ;		% photon energy

% laser structure parameters;

L=400;			% nominal length of laser in microns
A=3.5*0.5;		% effective optical guide area in square microns
kL=2;			% average value kappa L product;
gamma=.35;		% confinement factor for electrons
gammasp=.35;		% confinement factor for spontaneous emission
aL=1.6;			% guide loss parameter
B=10^(-10);		% spontaneous recombination coeff cm^(2)
C=3*10^(-29);		% Auger recombination coeff cm^(5)

% gain and spontaneous parameters;

No=(1.5*10^18);		% electron density at tranparency in number/m^3
trec=1/(B*No+C*No^2);	% effective electron recombination time at transparency;
Bn=B*No*trec;		% normalised rate for spontaneous 
Cn=C*(No^2)*trec;	% normalised auger rate

dgL=20;			 % differential gain length product at transparency

aH= 3;			 % Henry's linewidth factor -positive number here

eps=0.05;		 % gain saturation factor

Nnorm=((No*(10^(-12))*gamma*A*L)/trec); % normalisation for numbers/sec
Inorm=Nnorm*1.6*10^(-19) 	; % laser current in Amps required to gain transparency
Ph=Nnorm*phot;		 % power normalisation in watts
ts=L/(vg*trec);  	 % normalised recombination rate;
betasp=Bn*(gammasp/gamma)*((lambda)^2/((8*pi*A*perm))*(vg/(L*Df))); % spontaneous coupling factor;
