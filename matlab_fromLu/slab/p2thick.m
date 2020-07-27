% Asks for thickness of layers;
correct='n';
while (((correct=='y')+(correct=='q'))<1)
   
   d=thick1; %default entry
   
   qu='layer thicknesses in microns';
   v='Vector input not compatible with layer number; Re-enter';
   vv='Layer number is';
   dd0='If Bragg grating present, then etching MUST start/end at layer interfaces';
   dd01='Depth of etch must equal thickness of one(or two) layers.';
   dd1='How thick are the layers in microns? Write d=[d1  d2  -- dm -- dN];return;';
   dd2='Number of elements in vector  d  must equal number of layers';
   dd2a='for default there are 5 one micron layers.'
   dd3='Type r e t u r n then return key for default.';
   disp(dd0);disp(dd01);disp(dd1);disp(dd2);disp(dd2a);disp(dd3);keyboard;
   while abs(size(d,2)-layernum1)>0;
      disp(v);disp(vv);disp(layernum1)
      keyboard;
   end;% asks for correct entry if wrong.
   thick1=d;
   disp(qu);disp(thick1);
   correct=input('Are these entries correct? (yes/no/quit); MUST TYPE y or n or q  ','s');
   if correct=='q';quit='q';
   end;
end;
%end;