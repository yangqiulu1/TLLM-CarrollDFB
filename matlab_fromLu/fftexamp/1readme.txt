dated October 28th '97 (updated 14th August 2001)

This gives a range of very elementary tutorial programs to refresh the reader's 
mind on FFT calculations.
colortog.m is available in the folder if required to ensure black on white background default suitable for printing. However you are expected to run this separately.

Programs  m5spectN (N = 1 to 7) have been updated to run on Matlab5 with the use of Marker rather than LineStyle in certain places. In all other respects m4spect3 is identical to spect3 for example.

spect1
	This program uses the FFT to calculate the spectrum of a single
frequency input (complex input). Shows results for two different FFT lengths
while keeping the temporal duration the same.
Program compares the FFT with the analytic result.
Program checks Parseval's theorem on power.

spect2
	This program uses the FFT to calculate the spectrum of a single high
frequency input that is too high for the shorter of the two FFT lengths.
It compares the FFT with the analytic expression.
This demonstrates how inadequate number of samples can cause spurious
results in the computation.

spect3
	This program uses the FFT to find the spectrum of two
closely spaced single frequency (complex) inputs.  The program demonstrates
the need to have a long enough duration in order to discriminate between
closely spaced frequencies. Two FFT lengths are demonstrated with increasing
time and constant sampling time and the smallest interval between the
sampling points decreases with increased total time of measurement.

spect4
	This program demonstrates the spectral properties of a single impulse.
With an impulse at the first spectral point (t=0 analytically) the spectrum is
1 at all frequencies, at the spectral point moves so the spectrum changes
periodically with frequency. The effect of more spectral points is shown and is
unremarkable. 

spect5
	This program demonstrates the spectral properties of a short pulse
of two different durations and with different FFT lengths for the same time.
The short pulse contains high frequencies at its edges which are outside the
Nyquist limits and so cause errors in the spectrum at the high frequencies.
The more spectral points covering a wider spectral range then the lower the
error. 

spect6 
	This program is essentially the same as spect5 but now windows the
spectrum with a cosine^2 so as to reduce spectral amplitudes at the Nyquist limits.
The reconstituted pulse is then rounded at its edges.

spect7
	This program demonstrates the utility of keeping both the time and
frequency well within the ranges of the FFT. FFT has N=64 and normalised
frequency and time are used. The error is then typically less than 0.1% for
pulse duration > 10.

