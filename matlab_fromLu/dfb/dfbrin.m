disp('This takes the "lambda/4 phase shifted" DFB excited by noise(spontaneous) with shot noise');
disp('Computes the output over many (typically 256 runs) ');
disp('Calculates Relative Intensity Noise.');
disp('This program indicates the problems of modelling low frequency noise');
disp('The lower the frequency to be measured, the longer one must run the program.');
disp('Advice:- go away for about two hours (166 MHz PC) on some other work/play');
disp('The program repeats the standard dfb run for 128 (default) times.');
disp('The fields during the run are sampled to give a new FFT');
disp('with minimum frequency interval roughly 24 MHz');
disp('To reduce min. frequ. look for  RED in p9plot and double or quadruple');

% All display items can be edited out.
% Computing parameters and material parameters as for dfbuni/dfb14 
% Laser of length L is divided into N sections 
% For few hundred micron dfb laser 31 sections used here
% STP = 2^M steps where M integer gives the order of the fft 
% The program runs for 'REPSTP' steps made up of 'repeat' times 256 steps
% Student MATLAB only allows maximum of 32 * 256 matrix entries
% To save computing time random spontaneous emission in look up file spont1
% Look up file is limited to <= 32 field points and 256 time steps at one time
% STP can be any of 2^M steps where M integer in order to do a fft 
% With Student MATLAB and 16 Mb of memory M <= 11 advised. 
% Spontaneous emission excited at every point step and at every time step
% Display while running shows normalised output power against time for REPSTP points ~ 600 picoseconds

clear all;
colortog  % ensures black on white plotting;
tic;% sets time counter - can be edited out along with toc later;

p1las1 ;	% starting laser and material starting parameters

p2comp ;	% computing parameters 2048 steps for fft;

% Normalised Drive level (each section could be set differently)
disp(' ');
disp('At drive of 4*transparency, takes around 1 ns to turn on lasing');
Drv=input('Enter normalised drive (default 4 -press return)...  ');
if isempty(Drv);Drv=4; end;

D=Drv*ones(N,1); % I/Inorm  uniform drive into each section

da=exp(-(aL/N));		% loss per segment

%FILTER PARAMETERS FOR GAIN ; CAN BE CHANGED (SEE FILTER SECTION)

K=1;	 % see discussion of gain filter in text, K=1 recommended for start.
offr=0;   % GAIN FILTER OFFSET FREQUENCY in GHz
delfr=2*offr/fn; % normalised offset frequency for gain filter ; % normalised offset frequency for gain filter
pha=(delfr*2*pi/STP); % converts offset frequency to phase for filter
Ep=exp(j*pha);

% ff is the current forward field at points in order from 1:NF for N sections;
% fr is the current reverse field at points in order from 1:NF for N sections;
% ffn and frn are the new fields , ffo and fro are the previous (old) fields
% ff(1) is forward field input at lh end, ff(NF) is forward field at lh end;
% fr(1) is reverse field at lh end, fr(NF) is reverse field in lh end;


% set initial field and power to zero
ff=zeros(NF,1); fr=ff; ffn=ff; frn=ff;ffo=ff; fro=ff;
pwr=ff; pow=zeros(N,1);

% array of reflections and parameters -use arrays to speed up calculations. 
kmL=(ones(N,1))*kL; 	
% in principle k=kappa can be different at each section
ks=kmL/N; % array of reflections at each step
sinto=da*ks;  % loss times scattering per section -sine term
costo=da*sqrt(1-ks.^2); % cosine term in scattering matrix 
costo(Nr)=exp(-j*pi/2)*costo(Nr); % this is the lambda/4 phase shift
sinto(Nr)==exp(-j*pi/2)*sinto(Nr);	
mmm=ones(N,1);	% multipliers used in more general dfb than uniform
mmm(Nr)=0; % removes gain and phase shift for the central section 


ms=1:NF;		%counter for fields

bshot=1; % determines if shot noise is on - could set bshot <1 if shot noise smoothing present;
bb=(sqrt(betasp)); % spontaneous multiplier

p3nein ; % sets up initial electron density and output field


% ON STARTING PROGRAM THIS INITIAL PART TAKES A SHORT TIME TO SET UP;

% MAIN RUNNING ROUTINES FOLLOW;
R=0; 		% sets count for number of runs; helps to fix time scale;

for run=1:2
   p4run;   % allows system to settle 
end;

p9plot;				%plots RIN

ttt=toc;disp(' ');disp('time elapsed');disp(ttt); % tells how long the first run has taken

%end;


