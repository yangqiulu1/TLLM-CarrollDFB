%p4run2 can be used instead of p4run - does not renew figure but plots line;
%not actually used
if isempty(R); R=0; end;			% starts off runs;

R0=R*tim;		% converts start time from steps to ps
R1=(R+1)*tim;		% converts end of one run time from steps to ps
stps=R0+(1:REPSTP)*tn; 	% array of step in real time for plotting
Rst=num2str(RED-R+2);
				

ORight=10^(-8)*ones(1,REPSTP); % sets up ouput to ensure that zero does not appear
% This resets the plotted output for each new figure

	
% SETTING UP OF MAIN 'UNIVERSAL' PROGRAM used with minor modifications for all the DFB lasers
for rp=1:repeat   % remember repeat = REPSTP/256			%A

p5spont;			%spontaneous lookup table to save time

for nt=1:256;		%building up fields over 256 time steps; 	%B
gL=gamma*((dgL*(Ne-1))./(1+eps*pow));
dgcl=(1/N)*gL;
% incremental gain for central difference operation with gain profile;
% gain varies from section to section along laser. 

dph=exp(j*aH*(mmm.*dgcl));		%phase shifts for Henry's effect
%remember that with the sign convention in this book dg(1+jaH) 
%		gives the complex differential gain/distance
cost=costo.*dph; sint=sinto.*dph;	%scattering and loss matrix

ma=(2+K+dgcl)./(2+K-dgcl); 	% central difference gain filter parameters
mb=Ep*(2-K+dgcl)./(2+K-dgcl);
mc=Ep*(2-K-dgcl)./(2+K-dgcl);

ffo(1)=0;		% no reflections at left hand facet;
ff(1)=0;
ffn(1)=0;

fro(NF)=0;		% no reflections at right hand facet;
fr(N)=0;
frn(NF)=0;		


% sets up vectors to speed up calculation;

ffa=ma.*ff(1:N);ffb=mb.*ffo(1:N);ffc=mc.*ff(2:N+1);
fra=ma.*fr(2:N+1);frb=mb.*fro(2:N+1);frc=mc.*fr(1:N);
spfn=spf(1:N,nt).*Ne; sprn=spr(1:N,nt).*Ne; %spontaneous noise

% MAIN GUTS FOR UPDATING FIELDS and adding in spontaneous emission;

%ffn(2)=cost(1)*(ffa(1)+ffb(1)+spfn(1))+j*sint(1)*(fra(1)+frb(1))-ffc(1);
%frn(N)=cost(N)*(fra(N)+frb(N)+sprn(N))+j*sint(N)*(ffa(N)+ffb(N))-frc(N);

ffn(3:N+1)=cost(2:N).*(ffa(2:N)+ffb(2:N)+spfn(2:N))+j*sint(2:N).*(fra(2:N)+frb(2:N))-ffc(2:N);

frn(1:N-1)=cost(1:N-1).*(fra(1:N-1)+frb(1:N-1)+sprn(1:N-1))+j*sint(1:N-1).*(ffa(1:N-1)+ffb(1:N-1))-frc(1:N-1);

% OUTPUT RELATIONSHIPS
% getting output (on right hand side only);
ORight(1,(rp-1)*256+nt)=ffn(NF,1);

%getting energy density for updating electrons;
PFR=(ffn.*conj(ffn)+frn.*conj(frn));  % array of 'energy'
ffo=ff;fro=fr;
ff=ffn;fr=frn;
pow= SelP*(PFR);

%updating gain;
gL=gamma*((dgL*(Ne-1))./(1+eps*pow));
dns=sqrt(Drv)*Inoise*shotn(1:N,nt); % adds in shot noise
Ne=Ne+(1/N)*ts*(-2*gL.*pow-Bn*Ne.^2-Cn*Ne.^3+D+bshot*dns);
% bshot=1 or zero to switch on or off the shot noise; 
% Ne is updating electron density; 

end;									%B
Lout=10*log10(ORight.*conj(ORight));
plot(stps,Lout);axis([R0 R1 -60 20]);
text((0.95*R0+.05*R1),9,'number of runs to go:');text((0.4*R0+0.6*R1),9, Rst);
title('Log Output - Time (ps)');
drawnow;
end;									%A

OR=ORight(REPSTP-STP+(1:STP));% last STP plots for processing 

power1=OR.*conj(OR);

Pr=sum(10*log10(power1))/STP;	% mean power output in decibels

par=num2str(Pr);
driv=num2str(Drv);
text(0.95*R0+.05*R1,18,'final mean level db -');text(0.9*R0+0.1*R1,14,par);
text(0.4*R0+0.6*R1,18,'normalised drive - ');text(0.35*R0+.65*R1,14,driv);
pause(2);
R=R+1;	%increments counter to move time along.



