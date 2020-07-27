dated October 28th '97 (revised August 14th 2001)

This directory called slab contains all the programs required to run a multi-layer
slab wave-guide calculation in one transverse dimension . It is started with the
command  slabexec a program which controls the sequencing. Order of programs is
indicated by prefix p1 p2 p3 etc and readers are advised to read through the
comments at the start of the programs to see what they are about. An abbreviated
set of comments are given below. 

The guides may have loss and could be be entirely 'gain' guides 
but the search routine has not been optimised for such gain guides
and may fail with certain parameters.  The program looks long because
of the different combinations permitted and lengthy input output routines
to help if one enters incorrect data by mistake. 

The default parameters around which the program has been designed have been 
chosen so as to illustrate a very slightly lossy index guide with and without
a bragg grating. 

The Bragg etching is shown with the infil equal to the outer layer. Field patterns
and far fields for either TE or TM modes can be called for.

To illustrate gain guiding, it is suggested using 3-layers with 8 microns 3 microns
and 8 microns. Refractive index all the same at say 3.5 for illustration and gains
then of gain=[-50 500 -50] in inverse cm units. Seek only a single mode (default);
Notice the broad internal field and much narrower far field pattern.
It can be helpful to change SS8 in program p8calc to 0.5  to gain good convergence. 
The Bragg grating program is not designed to work with gain guides

The program automatically divides down layers into approximately 50nm slices. 
Gains/losses well over 1000 inverse cms have been run. No special restriction
on number of guide layers except time of computing but no guarantees can be given
that the program will not crash for certain parameters - THIS IS NOT A COMMERCIALLY
/BETA TESTED PROGRAM SO BE WARNED.

The program will only do trapezoidal etches for Bragg gratings.  It is essential
for a Bragg grating that the etching starts and stops at an interface between
two layers so that the etch depth has to be an integral number of layers deep
(preferably in units of 50nm). Only 1st or 2nd order Bragg gratings have been 
considered.  The Bragg etching has to have a uniform fill.

Program asks for multi-layer parameters entered directly as row vectors;
Losses/gains are always entered/returned in inverse centimeters
Wavelengths are entered in microns (free space values)

A number of sub-program conveniently break the main program down.
All sub-programs start with letter p followed by a number; thus p8calc shows
that this is a program and is typically the 8th program in sequence to be
called (excluding when Bragg gratings are present). Variables which are
global and passed from program to program are labelled with a number to
show in which program they originated or are defined. Thus wide7 is a variable
that is first defined in program 7 which is p7layer. 

If changes are made, make sure that all subprograms p1new ... p15kappa are
in the same directory slab as slabexec.m

p1new sets up parameters for any new run or repeat.
The number of modes looked for is by default 1 but it can look for up to 5.

p2thick asks for thickness of layers - entered in matlab format as row vector.

p3refind asks for refractive indices of layers -entered as row vector

p4gain asks for gain entered as a row vector in inverse cms. 
Gain is positive, loss is negative.  Each layer may have a different loss/gain
Program will estimate net loss outside gain layers and effective gain

p5layer - plots the layers on the screen 

p6bragg asks for details of bragg grating assuming a triangular etch with
a uniform fill.

p7layer divides bragg etching area into fine layers and works out
effective refractive index of layers after etching

 
p8calc orders the calculation searching for the modes using p9search initially.
The modes are found by scanning the real part and complex part of the
effective refractive index. A trial effective refractive index is inserted.
Using program p10refl an evanescent field 'feeds ' the 'top layer'. The 
necessary reflection coefficient rho [log(abs(rho))] to match all fields 
at boundaries is found. This is plotted against a trial value of effective 
refractive index. If initial trial plot shows no very clear minima then 
either
(i) there are no propagating modes (try altering guide width)
(ii) The imaginary part is too far away from the required value, 
        (try altering the S parameters in qcalc)
When rho is small enough then effective refractive index is correct or nearly
correct. This method has been found to be more stable than impedance matching. 
The search parameter is the effective complex 'refractiveindex'.

p10refl is a program which determines the complex scattering matrices the field.
and the value of the effective (complex) permittivity/effective (complex) 
refractive index.

p11serch repeats the search calculation alternately with imaginary and real parts.

p12 field calculates and displays the 'netfield' pattern.
 The calculation always will return 3 values of reflection coefficient but if
only one mode has been requested then the other modes will be returned as having
a rho=1. If 3 modes have been requested but only one can propagate then again the
other modes are returned with rho =1 in the vector of reflection coefficients.
  

Prompt K>> permits entry/interrogation of any parameter from keyboard
Normal MATLAB commands can be used until one returns to program.
To return to program type   r e t u r n   and press the 'enter' key. 
 
Global parameters listed with program can always be interrogated after the
calculation.

Typing whos will list the variables and show their state and variables as
defined take up approximately 60kbyte of memory. No attempt to minimise this
memory has been made.