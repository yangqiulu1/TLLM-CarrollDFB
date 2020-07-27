% Computing parameters
N=31;	% gives number of steps over laser length: each step = section; 
% N is fixed here to ensure compatibility with student MATLAB edition 
Nr=16;		% central field section, related to N
Nr1=10; Nr2=22;  % offset field sections, related to N

% computation worked on block of 32 x 256 random spontaneous elements

% 300 micron laser gives step lengths ~ 10 microns equivalent to ~0.1 ps;

MF=11;			% sets order of fft to be achieved;
STP=round(2^MF);	% number of steps in time to be calculated at one go
NF=N+1 ;		% number of field points = laser sections + 1
REPSTP=2*STP;		% total number of display points = twice fft length 
repeat=REPSTP/256; 	% number of repeats of 256 points 

% REPSTP  NUMBER OF POINTS MUST BE COMMENSURATE WITH MEMORY IN COMPUTER

fn=(N*vg/(L*STP))*10^(-9); 	% normalising frequency in GHz;
tn=1/((N*vg/L)*10^(-12));		% normalising time in ps;
tim=REPSTP*tn;		% gives physical time for REPSTP points
Nsec=(Nnorm*tn*10^(-12))/N;% numbers of electrons supplied into each section/sec
Inoise=sqrt(Nsec)/Nsec; % shotnoise/current  at normalised drive value
% Detail of sparse matrix operations to speed up calculation;
SelP=sparse(N,NF); % designed to help select power array from field array
for n=1:N; 
SelP(n,n)=0.5; SelP(n,n+1)=0.5;
end;