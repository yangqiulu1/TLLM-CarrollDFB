% program to interrogate about new/old parameters

disp('NB New calculation will clear all and restart');
new=input('Is this a new run? (yes/no/quit) MUST only ENTER y or  n or q  ','s');
if new=='y';
   clear all;% clear all memory of past calculations
   colortog; %sets figures to black and white and printed out in black and white
   new ='y';
   global layernum7 thick7 permittivity7 wavevector1 tme1 
end;
global layernum7 thick7 permittivity7 wavevector1 tme1 
change='n';
if (new=='y')+(new=='n'),						%ifA
   tme1=input('Do you wish for TE (default) or TM modes? Enter e or m:  ','s');
   if isempty(tme1);tme1='e';
   end;
   if (tme1=='m')+(tme1=='e');new=new; 
   else new='q';
   end;
   if new=='y',						%ifB
      lambda1 = input('Freespace Wavelength Lambda? (microns) (1.55 default)  ');
      if isempty(lambda1); lambda1=1.55;
         disp(lambda1);
      end;
      
      % 1.55 micron default entry;
      wavevector1=2*pi/lambda1;
      
      layernum1=input('How many layers? (5 default)  Integer ');
      if isempty(layernum1); layernum1=5;
         disp(layernum1);
      end;
      % 5-layers defaults.
      thick1=ones(size(1:layernum1));
      mid=round(0.5*layernum1);
      refrindex1=3.4*ones(size(1:layernum1));% real refractive index;
      refrindex1(mid)=3.6;refrindex1(mid-1)=3.5;
      gain1=-20*thick1;gain1(mid)=200;
      
   end;						%ifB
else new='q'; 
end;						%ifA

if new=='n'				%ifC
   change=input('Do you wish to change variables? (yes/no/quit) y/n/q  ','s');
end;					%ifC
if change=='y',			%ifD
   if isempty(lambda1), lambda = 1.55; 
   end;				
   lambda = input('Wavelength Lambda? (microns) ');
   if isempty(lambda), lambda = lambda1; 
   end;
   lambda1=lambda;
   % 1.55 micron default entry;
   wavevector1=2*pi/lambda1;
   if isempty(layernum1) layernum=5;
   end;
   layernum=input('How many layers?  Integer   ');
   if isempty(layernum); layernum=layernum1;
   end;
   layernum1=layernum;
   % 5-layers default or original input.
end;				%ifD
if (new=='q')<1;					%ifE
   MN1=input('How many modes do you wish to calculate? enter integer 1 or 2 or 3  ');
   if isempty(MN1), MN1=1; 
      disp(MN1);
   end; 
   MN1=round(MN1);
end;							%ifE
%end;							
if new=='q',quit='q';
end;
if change=='q',quit='q';
end;
if change=='y',new='y';
end;
