% dfb15. This programme generates a single 3-dimensional plot
% of laser spectra as the left facet phase is scanned. Key 
% laser parameters are set in "phasebatch1" so that dfb15 can
% be run several times with slightly different parameters
% automatically.  "laspar15" holds the laser material and 
% similar parameters like "p1las2" etc. but modified slightly
% so that no keyboard entries are required, and automatic
% operation is possible.


kL = kappa*L*0.0001;  % calculates kL from kappa and L set 
                      % in "phasebatch1".
colortog  % ensures black on white plotting;
laspar15 ;	% starting laser and material starting parameters;
p2comp;	% computing parameters 2048 steps for fft;



Rmax = floor(trun*1000/tim);    % gives an integral number of
                                % computation loops from the
                                % nominal simulation time in ns.

step_ph = philscan / (Rmax -1); % sets the change in facet phase
                                % per main loop.

matp = 1E-3*ones(Rmax ,STP);    % matrix to hold all spectral 
                                % data. Helps programme to run
                                % faster, and ensures no zeros.



% Normalised Drive level set in phasebatch;

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

%bshot set in phasebatch
if isempty(bshot); bshot=1;end;%disp('bshot');disp(bshot);
% could set bshot <1 if shot noise smoothing present;

bb=(sqrt(betasp)); % spontaneous multiplier

p3nein ; % sets up initial electron density and output field



% ON STARTING PROGRAM THIS INITIAL PART TAKES A SHORT TIME TO SET UP;

% MAIN RUNNING ROUTINES FOLLOW;

R=0; 		% sets count for number of runs; helps to fix time scale;
disp('starting & settling.......');
for run=1:2 % this just gets the laser running and settled before 
            % doing any plotting.  Drive levels close to transparency
            % may need a longer settling time.
            
p4runP;   % identical to p4run, but doesn't plot; 
end;

disp('main run');

figure;
for R = 1:Rmax;
p4runP;
spec3D;		% just plots 3.D spectrum;
phil = phil + step_ph; % increments left facet phase for each cycle
                       % of the main running loop. "phir" may be 
                       % substituted for "phil" here to see the 
                       % effects of right facet phase. In fact any
                       % laser parameter may be substituted, to see
                       % the effects of varying it (with appropriate
                       % editing elsewhere.
                       
rleft = [sqrt(Rleft)]*exp(i*phil); % gives facet reflectivity in the
                                   % form required in the model.
end;

disp('finished');

