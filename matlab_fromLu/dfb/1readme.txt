dated October 28th '97  (updated 14th August 2001)
NB: THESE ARE ILLUSTRATIVE PROGRAMS and DO NOT REPRESENT THE PRECISE OUTPUT FROM ANY ONE LASER. FOR REAL LASER  CALCULATIONS CARE HAS TO BE TAKEN TO HAVE REALISTIC PARAMETER VALUES.  WHILE CARE HAS BEEN TAKEN TO TEST PROGRAMS ON A FEW 
DIFFERENT PCs IT HAS NOT BEEN POSSIBLE TO TEST ON A WIDEVARIETY OF OPERATING SYSTEMS AND NO WARRANTY IS GIVEN OR IMPLIED IN PRESENTING THESE PROGRAMS.
[STATEMENT ADDED IN AUGUST 2001
Since the original development of this book Matlab and PCs have advanced greatly.
The authors have all moved on to new work and are not able to completely revise the programs, let alone the book. However  JEC and RGSP have re-run the programs on MATLAB 5.2 to see if changes are needed. Minor alterations have been made where necessary. Three key points are made in this readme text.
(1) One of the new features that has been added thanks to one of the authors RGSP is the facet phase information of the left and right facets. This is now all in a folder dfbHRLR
and allows for reflections from facets and complex kappa.
(2) A new feature that could have be added is given in a paper
GAIN MODELLING AND PARTICLE BALANCE IN SEMICONDUCTOR LASERS 
IEE Proceedings Optoelectronics Vol 147 No 2 April 2000 p77- 82.  E.M.Pratt and J.E.Carroll
The concept, that for every radiative electron-hole recombination one produces a photon, is fundamental to laser physics. Although a gain filter, to allow for changes of optical gain with frequency in the output, has been incorporated in most sophisticated semiconductor laser models, the matching of the correct gain with frequency in the recombination equation has been a matter of inserting an appropriate average gain. The paper, cited above, shows for the first time how to use the same gain filter both in the recombination equation as well as in the generation equation and thereby achieve the correct particle balance.   Such a change is essential to model really wide band semiconductor laser amplifiers, or frequency agile lasers where one has no a priori information about the output frequency of the laser.
(3) In some older versions of MATLAB there were no error messages when a program was terminated with an 'end' statement. Old habits of old-fashioned programming, where one always ended any program with an 'end' statement had been used and not corrected. MATLAB does not require unmatched end statements at the end of each program and newer versions will send an error message.
(4) The speed of personal computers has increased by an order of magnitude since the book was started. This has more than justified the 'simple' approach of using first order central difference methods where, it is argued, the computational physics is clear. Higher order finite difference methods, that can be used to gain more computational efficiency, can hide the physics and errors.
END OF STATEMENT ADDED IN AUGUST 2001]
ACCOUNT OF THE KEY PROGRAMS
dfbamp is the first program about DFBs . Its internal action should
be understood. It forms the guts of the future programs in getting field 
patterns with uniform electron densities that agree well with the analytical
solutions. It sends a coherent unit field into the laser at the left hand end
and watches the internal development of the fields with time. The input field can
be offset in frequency from the central Bragg value by arbitary amounts through
the delta parameter (see ch.7). The amplifier is run below the oscillation condition
and the nearer to oscillation it takes longer to settle down. If one runs above or
too near to the oscillation condition the program will crash because there is no
physics for power limitation which has to wait until the proper laser programs are
implemented as below.

[NB you will not be able to run all of these dfb programs without downloading into the working directory the programs with starting with P1las1.m , P1las2.m through  P2...  to P9plot.m and Sponto.m. Some comments are made below]  

Program dfbuni in directory dfb brings the results of chapter 7 together for a
uniform DFB laser with real kappa and a vectorised system of equations
that is  suited to MATLAB. The programs are prefixed p1 p2 etc to indicate 
the order in which they are usuall carried out.  Thus first, p1las1 gives the 
laser material  parameters ; p2comp gives the computing parameters;
p3nein gives the electron  density input while p4run is the guts of the 
calculation. Programs p5spont determine the spontaneous emission and 
p6plot gives plotting routines with p7plot plotting spectrum and p8plot
plotting electron density and field patterns. The program takes around 20  
seconds for a run with about 30 sections appropriate to a device about 300 
microns in length using a 166 Mhz PC.  Different types of dfb laser can use
the same basic program but with computationaly minor but physically 
important variations such as phase shifts included in the main program.

The program dfbuni for a  uniform DFB within the directory dfb 
demonstrates that at first switching on the drive to the laser,  the electron 
density  has to build up. The laser has a turn on time so that the first couple 
of runs simply demonstrate noise appearing.  Then as the laser output 
builds up one sees oscillations in the output  waveform because the uniform 
DFB  cannot discriminate well between the upper or lower mode close to the 
stop band.  

The program  dfb14 is the same DFB with a 1/4 wavelength phase shift in its
centre. Here there is  strong shaping of the electron density(spatial hole
burning) and the optical intensity  profile within the laser.  This laser
shows no  uncertainty in the switch on mode  which is in the middle of 
the conventional stop band for the uniform DFB. 

The program  dfb218 is again the same DFB as previously but now with 2 phase
shifts of 1/8 wavelength, one on either side and offset from the laser's centre.
This program shows that the lower frequency (higher wavelength) is the favoured
mode of lasing with less spatial hole burning than for the single central phase 
shift.   

The program dfb238 simply changes these phase shifts from 1/8 to 3/8 wave-
length  and now the higher frequency (shorter wavelength) is the oscillation mode.
The mode selection depends on the precise position of the phase shifts (chapter 5).
The reader will find with different drive levels that this device is less stable
than dfb218 and that is why the previous design is often preferred.

Recent changes in technology have made devices with gain 
coupling.  Program  dfbgain allows the value of kappa to be complex and 
the sign of the the imaginary component determines whether the laser
prefers the upper or the lower frequency around the stop band of the DFB. 
Strictly the value of the imaginary component should change with electron 
density. However here a constant complex  k  is inserted in a program  
called dfbgain.  This program shows the selection of the lower frequency 
mode. 

The program has the ability to run with bandwidth limited spontaneous 
emission. This slows down the program and has little practical effect 
because the gain filter  is included as standard.   

The laser can also be run without the spontaneous emission once lasing is 
well  established. This gives the ideal theoretical profiles. To operate this 
facility, wait until the laser has settled and then go into the keyboard and 
type sponto which is  a stand alone sequence which switches off 
spontaneous and plots all the output  after one run.

The reader is strongly advised to store these program on a separate disc/file
before changing them.  Changes should only be made to the non-standard backup
set.
The authors realise that any set of programs written by another person are often
incomprehensible to the average reader and to offer any program is to invite 
criticism about programming style, choice of language and so on.  Attempts are
made here to make adequate annotation within the program.  The programs  have
had many of the advanced MATLAB features deliberately removed to aid in 
understanding the construction. The limit of 32 nodes has been made in order to
be  accomodated within Student MATLAB.

dfbrin is a modified program of the dfb14 repeating the short runs many times
over with visual outputs telling one how many runs to go. It samples the fields
at a lower rate and is able to tell one the low frequency relative intensity noise.

The reader with a full MATLAB version will be able to construct a Fabry-Perot
program by setting the kappa to zero but typically now having 128 nodes or
more to  get the spectral resolution. Fabry-Perot laser calculations are not
discussed in the book in detail, except as conventional rate equations, and these
appear in directory fabpero.  

These programs generate a lot of figures and storage is often a problem. The
program  delfig  permits one to delete large numbers of figures quickly. The
default when pressing return simply deletes from the current figure number down.
Obviously it can be modified to do other tricks.

