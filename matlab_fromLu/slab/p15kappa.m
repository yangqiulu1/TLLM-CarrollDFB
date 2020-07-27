% program to estimate kappa values in Bragg grating.
% With Bragg gain gratings advise using gains say of 100 inverse cms.
% kappagain can then be rapidly scaled with changes of gain.
n=2:layernum12;
field13m(n)=0.5*(field13(n-1)+field13(n));
field13m(1)=0.5*field13(1); 
% gives approximate fields in middle of thin layers of thickness thick12
d=thick12;
fieldsq=abs(field13m.^2);
area=sum(fieldsq.*d);
EffectiveArea=area %displays this result
ef=real(effperm8);
delta = real(deltaperm12)/ef; deltag=imag(deltaperm12)/ef;

wide15=2*sin(order6*pi*wide12)/(order6*pi); %fourier coefficient for reflection;
wid015= 2*sin(pi*wide12)/pi; %fourier coefficient for radiation if order 2.

%end
kapindex=wide15.*delta;% gives kappa reflection in each layer
kapgain=wide15.*deltag;
kaprad=wid015.*delta;
betab=(2*pi/lambda4);
kapindex15=10000*sum((betab/4)*kapindex.*(fieldsq.*d))/area;
kapgain15=10000*((betab/4)*sum(kapgain.*(fieldsq.*d)))/area;
kaprad15=10000*sum(((betab/2)*abs(kaprad.*field13m.*d)).^2)/area;
if order6==1;kaprad15=0;end;

kapindex15=round(100*kapindex15)/100;
kapgain15=round(100*kapgain15)/100;
kaprad15=round(100*kaprad15)/100;
%end;
% the factor of 10000 converts kappa to inverse cms. 