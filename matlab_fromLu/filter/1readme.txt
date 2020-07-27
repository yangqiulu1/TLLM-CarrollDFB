dated October 28th '97 (revised August 14th 2001)

This set of programs looks at the filter implementation used in the book.
Many digital signal processing experts will see these filters as inadequate - but
this was not written for dsp experts. Higher order filters take more time to compute
and as it is mainly the value of the gain peak and curvature that effects the laser
so the low order filters that are more readily implemented in the dfb laser are
often adequate.

Note added about complex gain
Feedback has suggested that the use of the term imaginary gain has caused some confusion. As gain changes with frequency, the Kramers Kronig relationships require that the gain cannot stay real - there has to be a phase shift. The gain-frequency relationships have to give: gain(real) + i*gain(imag). The phase shift in each element dx is dx*gain(imag). The imaginary term causes a phase shift in the fields and is part of the term that goes towards the magnitude of Henry's alpha factor. The confusion can arise because it is tempting to write the complex gain as:
gain = g(magnitude) exp(i*theta) 
and consider (incorrectly) that theta is the phase shift in the field. 

filt1
        This is a digital implementation of the first order Lorentzian filter that
is to be used for gain filtering. 
The 3dB points that are calculated for interest are not nomral 3dB points because
the net gain is exp(g'L) where g' is the real part of the gain and the 3db points 
refers to where g' falls to  1/sqrt(2) of its central value. Now the Lorentzian filter
changes any real gain into real and imaginary parts as the frequency moves away from
its real central value - the change in the real gain necessarily is linked with
a change in the imaginary gain because of the Kramers Kronig relationships.
        All the programs in this suite have their frequencies normalised so that
the normalised frequency at the Nyquist limits is +/-0.5. The whole Nyquist
frquency range is then 1 which is equivalent ot 1/(time step) = vg/s  
where vg is group velocity and s is space step.
        
filt1n
        This is the same digital implementation of the first order Lorentzian filter
as in filt1 but now the filter is excited by stochastic white noise and one can check the
performance of the filter on a noise input. The 3db power points are now the normal 3dB
down points where the power has fallen to half the peak value.

filt2
        This is a modified Lorentzian digital filter based on similar system to filt1
but with different arrangement of complex multipliers so that the 'gain' always goes to
zero at the Nyquist frequency limits. The differences only show up clearly when there is
a frequency offset. However the filter only works sensibly over a limited range of K 
around unity and offset frequencies around +/- 1/10 of the Nyquist range. Further
the offset parameter is not directly related to the offset frequency as the value
of K alters the actual offset frequency for a given offset parameter. Care is
therefore needed in the application of this simple filter.
        
gain
        This demonstrates the filt1 theory applied to the gain process within a travelling
wave system. The filter is tested with a white noise excitation so that one can easily 
view the gain over the whole spectrum. 