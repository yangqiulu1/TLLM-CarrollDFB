dated October 28th '97  (updated 14th August 2001)
colortog.m is available if required in the folder to give a default of black 
on white plots. The reader is expected to operate this separately.

This set of programs gives tutorial in key points for straightforward
 numerical computations of ordinary and partial differential advection equations.

stepr			 (r for real)
compares forward and central difference approximations with the same step
integrating df/dz = z f with initial condition f=1 at z=0; 

stepj			 (j for imaginary)
compares forward and central difference approximations with the same step
integrating df/dz = j z f with initial condition f=1 at z=0;

advec
Shows a forward wave propagation program which allows for larger or smaller
normalised group velocities than 1 (where normalised time and space steps
are equal). Pulse energy is conserved for the forward advection equation 
but significant numerical dispersion is introduced for narrow pulses if one
moves too far from the condition that normalised time and space steps are 
'equal'.  

When you have run this program with a range of normalised group velocities
go into the program and change (on line 31) the width from width= N/20 to 
width = N/10 and repeat the calculations.  With the pulses changing more 
slowly in space and time, one sees that the distortion is much reduced. 
