disp('Finds TE or TM modes approx field patterns in slab guides.');
disp('30 or more layers are possible with complex permittivity');
disp('gain guiding can be modelled but is more limited than index guiding');

p1new;% asks about new data;

quit='n';
if new=='y';
   bragg='n'; %default calculation does not do bragg grating  
   p2thick;% enter layer thicknesses;
   
   if (quit=='q'<1);
      p3refind;% enter real refractive indices;
   end;
   
   if (quit=='q'<1);
      p4gain;% enter gains/losses;
   end;
   
   if (quit=='q'<1); 
      p5layer; %plots layers and refractive index; divides into thinner layers
      p6bragg; % enter bragg grating parameters if there is a bragg grating;
   end;  
   
   if (quit=='q'<1);
      p7layer; % re-determines fine layers when Bragg grating presnt 
   end;
   
end;

if (quit=='q'<1);
   p8calc; % main calculation
end;

FH=gcf;
figure(FH-2*(MN1-1));pause(3)
figure(FH-2*(MN1-1)-1);
disp('SEE OTHER FIGURES IF PRESENT FOR HIGHER ORDER MODES');
%end;