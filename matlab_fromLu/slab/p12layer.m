%divides layers down into thinner layers for plotting and calculation
% It would be possible to always have thin layers
%  	but this increases the time of computation.

for k=1:layernum7; 
   ext(k)=round(thick7(k)/0.05); ext12=ext;
end;

layernum12=sum(ext);
layerdepth12=zeros(1,layernum12);thick12=layerdepth12;
permittivity12=thick12;
layerdepth12(1:ext(1))=(1:ext(1))*thick7(1)/ext(1);
permittivity12(1:ext(1))=permittivity7(1)*sign((1:ext(1)));
thick12(1:ext(1))=(thick7(1)/ext(1))*sign((1:ext(1)));

if bragg=='y'
   wide12(1:ext(1))=wide7(1)*sign((1:ext(1)));
   deltaperm12(1:ext(1))=deltaperm7(1)*sign((1:ext(1)));
end;

kk=ext(1);
for k=2:layernum7;
   layerdepth12(kk+1:(kk+ext(k)))=layerdepth7(k-1)+(1:ext(k))*thick7(k)/ext(k);
   permittivity12(kk+1:(kk+ext(k)))=permittivity7(k)*sign((1:ext(k)));
   thick12(kk+1:(kk+ext(k)))=(thick7(k)/ext(k))*sign((1:ext(k)));
   
   if bragg=='y'
      wide12(kk+1:(kk+ext(k)))=wide7(k)*sign((1:ext(k)));
      deltaperm12(kk+1:(kk+ext(k)))=deltaperm7(k)*sign((1:ext(k)));
   end;
   
   kk=kk+ext(k);
end;




