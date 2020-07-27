% asks for layer structure
lad=0;layerdepth5=zeros(size(1:layernum1));
for k=1:layernum1;
   layerdepth5(k)=(lad+thick1(k));
   textdepth5(k)=lad+0.5*thick1(k);
   lad=layerdepth5(k);
end;
figlay5=figure;hold on;

plot([0, lambda4],[0,0]);
ylabel('depth');xlabel('distance')
for k=1:layernum1; plot([0, lambda4],[-layerdepth5(k),-layerdepth5(k)]);
   text(0.1*lambda4,-textdepth5(k),num2str(real(refrindex4(k))))
   text(0.3*lambda4 ,-textdepth5(k),num2str(imag(refrindex4(k))));
end;
figure(figlay5);text(.05,.2,'Slab Layers - Real Ref. Index - Imaginary Ref Index');


