%All these display items can be edited out if required;
disp('Program for a "uniform" DFB excited by noise(spontaneous)');
disp('NB the coupling coefficient "kappa" can be allowed to be complex in this model');
disp('NB one facet reflection is (High) 0.9 and one (Low) is zero as default in this model') 
disp('NB facet phases are also allowed for in this model');
disp(' Material and laser parameters now stored in p1las2.m file');
disp(' Computing parameters stored in p2comp.m ');
disp(' Laser of length L is divided into N sections (see p2comp file)');
disp(' For few hundred micron dfb laser 31 sections used here');
disp(' STP = 2^M steps where M integer gives the order of the fft ');
disp(' The program runs for "REPSTP" steps made up of "repeat" times 256 steps');
disp(' Student MATLAB only allows maximum of 32 * 256 matrix entries');
disp(' To save computing time random spontaneous emission in look up file spont1');
disp(' Look up file is limited to <= 32 field points and 256 time steps at one time');
disp(' STP can be any of 2^M steps where M integer in order to do a fft ');
disp(' With Student MATLAB and 16 Mb of memory M <= 11 advised. ');
disp(' Parameters can be changed during a run at keyboard but are not changed in home files');
disp(' Spontaneous emission excited at every point step and at every time step');
disp(' Display while running shows normalised output power against time for REPSTP points ~ 400 picoseconds');
disp(' PRESSING RETURN AT END OF RUN repeats run from where it left off');
disp(' PRESSING 1 AT END OF RUN PLOTS out internal fields^2 , electron density, spectrum');

clear all;

%plotfig=1; % sets the flag to renew figures while plotting ;
colortog  % ensures black on white plotting;
p1las2r ;	% starting laser and material starting parameters

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
Ep=exp(j*pha); %phase factor for filter

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

mmm=ones(N,1);	% multipliers used in more general dfb than uniform

ms=1:NF;		%counter for fields

disp('Is there shot noise in current drive?');
disp('type 1 for noise on; type 0 for noise off')  
bshot=input('default is noise on - press return key     ');
if isempty(bshot); bshot=1;end;disp('bshot');disp(bshot);
% could set bshot <1 if shot noise smoothing present;

bb=(sqrt(betasp)); % spontaneous multiplier

p3nein ; % sets up initial electron density and output field



% ON STARTING PROGRAM THIS INITIAL PART TAKES A SHORT TIME TO SET UP;

% MAIN RUNNING ROUTINES FOLLOW;
R=0; 		% sets count for number of runs; helps to fix time scale;

for run=1:2
   p4runr;   % GUTS OF MAIN PROGRAM; 
end;
pause(2);
p6plotr;		% allows one to choose about plots and re-runs;
