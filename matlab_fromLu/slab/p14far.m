%This program calculates the far field patterns from -60 to +60.
%Change FF in program if different angles required.

effref=sqrt(effperm8); num=layernum12;laydep=layerdepth12;
FF=60; theta=-FF:FF;sintheta=sin(pi*theta/180);
theta1=wavevector1*sintheta;
fourier=zeros(size(1:2*FF+1));farintense=fourier;
for k=1:2*FF+1,
   fourier(k)=sum(field13.*exp(-j*theta1(k)*laydep))/laydep(num);
   farintense(k)=fourier(k).*conj(fourier(k));
end;
costheta=cos(pi*theta/180).^2;
LL=ones(size(theta));permit=real(LL*effref*effref);
sq=sqrt(permit+sintheta.^2);
if tme1=='e';aaa=LL+sq;bbb=costheta+sq;end;
if tme1=='m';aaa=permit+sq;bbb=permit.*costheta+sq;end;
ccc=aaa./bbb;
rad=costheta.*ccc;
rad=rad.*rad;
farintense= farintense.*rad;
farintense=farintense/max(farintense);
figure; %brings up new figure for a plot of each mode.
plot(theta,farintense,'k');
if tme1=='m';xlabel('TM Far Fields');end;
if tme1=='e'; xlabel('TE Far Fields');end;
set(gca,'xcolor',[0,0,0],'ycolor',[0,0,0]);%sets axes and labels to black;
%labels fields TE or TM
%end;