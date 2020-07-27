h=(bot6-top6); 
if h>0;							%A
   [at bt7]=min(abs(layerdepth5-top6));
   [ab bb7]=min(abs(layerdepth5-bot6));
   extra=round((bot6-top6)/0.05); %divides bragg layer up into 50 nm layers
   layernum7=layernum1+extra-bb7+bt7; %counts number of layers
   layerdepth7=zeros(1,layernum7);
   refrindex7=layerdepth7;
   thick7=layerdepth7;
   
   layerdepth7(1:bt7)=layerdepth5(1:bt7);
   for th=1:extra-1 
      layerdepth7(bt7+th)=layerdepth5(bt7)+th*h/extra;
   end;
   layerdepth7((bt7+extra):layernum7)=layerdepth5(bb7:layernum1);
   
   L1(2:layernum7+1)=layerdepth7(1:layernum7);
   L1(1)=0;
   L2(1:layernum7)=layerdepth7(1:layernum7);
   L2(layernum7+1)=layerdepth7(layernum7);
   L3=L2-L1;
   thick7=L3(1:layernum7);
   
   refrindex7=0*layerdepth7;
   a=1;
   for r=1:layernum1;
      for t=a:layernum7;
         if layerdepth7(t)<=layerdepth5(r);refrindex7(t)=refrindex4(r);
            a=t+1; 
         end;
      end;
   end;
   
   if bragg=='y';					%B
      wide=zeros(1,layernum7);
      for nos=bt7+1:1:bt7+extra-1; 
         depth=0.5*(layerdepth7(nos)+layerdepth7(nos+1))-layerdepth7(bt7);
         wide(nos)=widthtop6*(1-depth/h);
      end;
      wide7=(wide/braggperiod6);
      permittivity7=(refrindex7.^2).*(1-wide)+wide*(braggindex6)^2;
   end;						%B
   
   count=sign(abs(wide7));
   deltaperm7=count.*((refrindex7.^2)-(braggindex6)^2);
   
else; 
   layernum7=layernum1;
   thick7=thick1;
   layerdepth7=layerdepth5;
   permittivity7=(refrindex4.^2);
end;						