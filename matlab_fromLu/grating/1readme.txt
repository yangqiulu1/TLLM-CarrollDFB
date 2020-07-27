dated October 28th '97 (revised August 14th 2001)

This set of programs looks at the uniform Bragg grating theory and the
relationships between offset frequency, propagation and the values (complex)
for kappa.

colortog has been inserted for Matlab4 - with Matlab5 this is not needed
 
dfbthr
Finds approx. value of threshold gain and offset frequency for a uniform index
grating DFB using normalised values of beta, delta=d, field gain=g  as beta/kappa etc.
Works only over a limited range but gives idea of how one can proceed.

dispbrag
Program displays the propagation relationships in a uniform Bragg grating.
Normalises beta, delta=d, field-gain=g to magnitude of kappa=k: hence 
respectively bk =b/k ; dk= d/k and gk =g/k are the normalised parameters.
Complex coupling uses a phase factor pha to give k*exp(j*pha).

refl
Calculates reflection from a DFB grating with coherent unit input at L=0. 
Normalises beta, delta=d, field gain=g to magnitude of kappa=k.