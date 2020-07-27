dated October 28th '97 (revised August 14th 2001)

	The suite of programs in the directory spont demonstrate a
 number of features about modelling spontaneous emission in a quasi-
classical manner. 
 
spont
	This is should be started first to help the reader. 
Initially this shows a 'coherent' field amplitude represented by a
fixed complex vector with added gaussian noise.  The field then changes
randomly in amplitude and phase with time. The Fast Fourier Transform 
then is taken of this sequence and the spectrum reveals white noise 
with a coherent impulse at the central frequency. The same signal is 
then filtered to show the effect of decreasing the bandwidth of the 
noise and one can see the tip of the 'coherent' vector performing a
'random walk'.  The FFT is taken again to show the effect of 
the filter colouring the noise around the central frequency.

amp1 
	shows the effect of an increasing length of amplifier where
there is no loss or gain but only added (white) spontaneous noise.  
		The noise output then increases with length.

amp1f
	presents similar results as for amp1 but now the spontaneous 
emission is filtered so that spontaneous is 'coloured' rather than 
being white.

amp2
	this is also similar to amp1 but now adds in gain/unit length. 
The amplifier is taken as an ideal quantum amplifier where gain and 
spontaneous emission are proportional and there is no stimulated 
absorption. The program now shows that the 
	(signal power/gain)/(noise power/gain) 
reaches a limiting value. 
In amp2, the amplifier length is changed to show that increasing the 
length of the amplifier and so increasing the overall gain does not 
increase the signal/noise ratio.  

amp3
	gives the same message as amp2  that increasing the overall 
gain does not improve the signal/noise ratio but now the 
gain/unit length is changed. It is the
link between spontaneous emission and gain/unit length that limits this signal to
noise ratio.
