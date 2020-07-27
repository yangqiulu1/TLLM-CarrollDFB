dated October 28th '97 (revised 14th August 2001)

The two programs below specifically refer to the normalised rate equations in
chapter 4 and appendix 4.

fpstat.m plots normalised light-drive characteristics. 
fpdyna.m plots light-time output for a step drive input at twice the nominal
threshold

Remember that one does not type the .m to run a MATLAB program and
that lower case is used.
The program colortog.m is available if required to use to ensure a default setting of
black on white plotting routine.

The purpose of fpstat is to demonstrate the effect of the magnitude
of the spontaneous coupling factor beta.  
This is set as an exponent beta = 10^(-S) with S set as default at 5
S is the main input variable.
Gain will saturate with higher photon densities and there is a gain saturation parameter
included as a second parameter with which the reader can experiment.

On going into the program one will see the parameters listed and these
can be changed. If changes are made store original program in a backup file.
 
fpdyna demonstrates the effects of beta and gain saturation on light current
characteristics. Input variables are therefore gain saturation and beta.

Low gain saturation enhances ringing, very low spontaneous emission delays
photon emission but once the electron density exceeds threshold emission soon
starts because of exponential growth. High spontaneous emission pushes light 
output up at the given drive because, in effect, the threshold density has been
reduced and more input electrons can be converted into light. For simplicity, program does
not allow for non-radiative recombination.

Gain sat. is normalised to values similar to those used in the later full 
program. The normalisation for rate equations is conveniently taken as a
threshold electron density (normalisation in the time and space programs later
are to the transparency density). The spontaneous coupling is beta as in fpstat.
On going into the program one will see the parameters listed and these can be
changed. Store the original program in a backup file before making changes.

The reader is invited to compare/contrast two different scenes
(i) set beta = 1/10 = 10^(-S) so put S=1  with gain saturation parameter gs = 0.1
(ii) set beta=10^(-5)  ie S=5 with gain saturation parameter = 10
The dynamic characteristics both show heavy damping of the photon/electron density.