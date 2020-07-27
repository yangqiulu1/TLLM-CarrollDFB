% Asks for refractive indices of layers.
correct='n';
while (((correct=='y')+(correct=='q'))<1)	% whileA
   n=refrindex1; % default entry
   
   qu='real refractive index of layers';
   v='Vector input not compatible with layer number; Re-enter';
   vv='Layer number is ';
   disp('The number N of layers is');disp(layernum1); 
   disp('Refractive indices of layers? Write n= [n1  n2 -- nm  -- nN]');
   disp('default refractive indices give a clear main mode:');
   disp('Type r e t u r n then return key for default.');
   keyboard;
   while abs(size(n,2)-layernum1)>0;
      disp(v);disp(vv);disp(layernum1);
      keyboard;
   end;
   % asks for correct entry if wrong.
   refrindex1 = n;
   disp(qu);disp(real(refrindex1));
   
   correct=input('Are entries correct? (yes/no/quit); MUST TYPE y or n or q ','s');
   if correct=='q';quit='q';
   end;
end;						%whileA
%end;
refrindex3=refrindex1 ; % renamed to show updating