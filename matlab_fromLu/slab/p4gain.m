% Asks for gain/loss of layers in inverse cms;
correct='n';
while (((correct=='y')+(correct=='q'))<1)
   %if isempty(gain), gain=-20*ones(size(1:layernum1));
   
   gain=gain1; %default entry;
   
   qu='(power) gain of layers'; %field gain = power gain/2;
   gn0='What is gain in each layer? Note gain >0 and loss < 0';
   gn1='(power)gain/loss both measured in inverse cms.';
   gn2='note field gain = power gain/2';
   gn3='program finds imag. ref. index = gain*lambda/(2*2*pi*10^4)';
   dd1= 'Write for example: gain=[-20 -20  200  -20  -20];return; ';
   dd2='Number of elements in vector  gain  must equal number of layers';
   dd3='Type  r e t u r n then return key for default.';
   
   v='Vector input not compatible with layer number; Re-enter';
   vv='layernumber is';
   disp(gn0);disp(gn1);disp(gn2);disp(gn3);
   disp(dd1);disp(dd2);disp(dd3);keyboard;
   while abs(size(gain,2)-layernum1)>0;
      disp(v);disp(vv);disp(layernum1);
      keyboard;
   end;% asks for correct entry if wrong.
   gain4=gain;
   disp(qu);disp(gain4);
   correct=input('Are these entries correct? (yes/no/quit); MUST TYPE y or n or q ','s');
   if correct=='q';quit='q';
   end;
end;
%end;
m=gain4*lambda1/(40000*pi);
refrindex4=(real(refrindex3)+i*m);
%shows which program updated index is obtained
[a b]=max(imag(refrindex4));
refest4=real(refrindex4(b)); % estimated real Bragg index: at maximum gain;
lambda4=lambda1/refest4; % estimated wavelength in material in microns