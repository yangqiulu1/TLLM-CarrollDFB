README File

Three years is a long time in computing. Computer speeds have advanced by about an order of magnitude supporting the argument that it is more important to keep code straightforward with a physical understanding rather than go into higher order difference schemes to save computing time. Matlab has progressed from version 4, on which the programs were originally tested, through version 5 and now to version 6. The newer versions have their advantages over 4 and discriminate certain aspects of the code. 
eg end  statements need to be matched correctly
   global  statements need more care
   Markers on a line and LineStyle have to be distinguished
   The advanced features of versions 5 and 6 have not been used.
   Code giving black on white background graphics for 4 is redundant in 5 but it does not    need to be removed.

The authors have now tried to ensure that the code will run on 4,5 and 6, but no guarantees can be given because different platforms often give slightly different results.

Each folder contains exercises and demonstrations relevant to different parts of the book.
Each folder contains its own readme file.

Dfb 
contains illustrative programs for the operation of different types of distributed feedback laser. One dimensional progagation with effective transverse parameters is assumed. The code is based on central differences which has several important advantages outline in the book. The readme file in this section draw attention to 
GAIN MODELLING AND PARTICLE BALANCE IN SEMICONDUCTOR LASERS 
IEE Proceedings Optoelectronics Vol 147 No 2 April 2000 p77- 82.  E.M.Pratt and J.E.Carroll
This paper shows how to incorporate gain-frequency profiling into both recombination and gain equations - an essential for time domain modelling of broad band semiconductor optical amplifiers or for frequency agile lasers.

DfbHRLR  
Uniform DFB lasers with one facet having a high reflectivity and the other a low reflectivity have some of the advantages of phase jump lasers but with a simpler construction. Additional code has been added that allows for finite facet reflections with different phases. Three dimensional plots are also helpful in displaying the full range of effects. See the code phasebatch below.


phasebatch
(suitable for matlab 5 or 6 with systems of 250 MHz clock and 128Mb RAM or better)
This contains a suite of programs organised by RGS Plumb to illustrate
the power of using a 3 dimensional plot. It uses a standard dfb 
set of programs but lets the facet phases at the high reflectivity
end of the laser change It is has been tested on
systems with 400 MHz clock system and 128Mb RAM or better using 
Matlab 5 or 6.
Start with the command
phasebatch
and let the system run for several minutes. The resultant 3d plot can
be rotated.

	Caveat. 
Gain coupled lasers (ie with complex kappa) having one facet strongly reflecting and the other facet anti-reflection coated have a number of advantages.  However the authors have found that such gain coupled lasers with a signifant value of coupling index (or order |KL| =2) and certain very specific facet phases cause instability in the program. At the present time (Oct 2001) this is still being investigated as to whether this is a real effect or a computational artefact.

Diff 
gives tutorial in key points for straightforward numerical computations of ordinary and partial differential advection equations.

Fabpero 
specifically refers to the normalised rate equations in
chapter 4 and appendix 4.

fftexamp 
gives a range of elementary tutorial programs to refresh the reader's 
mind on FFT calculations. This is the only suite of programs with a separate version for 4 and for 5+ versions.

filter looks at the filter implementation used in the book.
Many digital signal processing experts will see these filters as inadequate - but
this was not written for dsp experts. Higher order filters take more time to compute
and as it is mainly the value of the gain peak and curvature that effects the laser
so the low order filters that are more readily implemented in the dfb laser are
often adequate. Work referred to in DFB has extended this technique both to the gain and recombination equations.

grating looks at the uniform Bragg grating theory and the
relationships between offset frequency, propagation and the values (complex)
for kappa.

slab folder contains all the programs required to run a multi-layer
slab wave-guide calculation in one transverse dimension. 

spontan contains a suite of programs that demonstrate a  number of features about modelling spontaneous emission in a quasi-classical manner. 


