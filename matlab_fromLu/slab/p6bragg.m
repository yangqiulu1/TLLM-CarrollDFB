% Asks for Bragg grating parameters.
disp('RECOMMEND NO BRAGG GRATING FOR INITIAL RUNS :');
disp('     return letter n for next question');
disp('Does the laser have a Bragg grating?');
bragg=input('    (yes/no/quit) MUST TYPE y or n or q  ','s');
if isempty(bragg), bragg='n';end; 
if bragg=='n' ; 
   top6=layerdepth5(1);
   bot6=layerdepth5(1);
end;

if bragg=='q';quit='q';end;
if bragg=='y'								%A
   disp('  ');disp('What order of Bragg grating is being made?');
   order6=input('      type 1 or 2 only  ');
   if isempty(order6), order6=1;	end;
   if abs((1-order6).*(2-order6))>0;order6=2; end;  % default order = 1;
   braggperiod6=0.5*lambda4*order6; bp=braggperiod6;
   % Bragg period is taken as having (lambda in material)*order/2 in region of maximum gain ;
   
   disp('Bragg etch must start/end at interface between two layers');
   disp('Layer depth in microns for top of grating etch?')
   top6=input('default: interface at bottom of top layer - return  ') ;
   if isempty(top6), top6=layerdepth5(1);	end;
   [a b]=min(abs(layerdepth5-abs(top6)));top6=layerdepth5(b);
   %allows for slightly incorrect entry of the layer depth by choosing nearest interface;
   % does not matter if user enter a negative or positive number for depth -always interprets;
   
   disp('Default grating has layer of 3/8 wavelength at top');
   disp('       and zero width at bottom');
   disp('Default grating is one input layer deep');
   disp('  ');disp('Width at top of the etched grating?');
   widthtop6=input('Default width is 3 lambda/8 ?  ');
   if isempty(widthtop6), widthtop6=(3/8)*lambda4;	end;
   if widthtop6>bp; widthtop6=bp;end % cannot have etch larger than bragg period;
   %default etch width is 3/8 material wavelength);
   
   widthbot6=input('Width at bottom of the etched grating (default 0 return)?  ');
   if isempty(widthbot6), widthbot6=0;	end;
   if widthbot6>bp; widthbot6=bp;end % cannot have etch larger than bragg period;
   % default etch width at bottom is zero -ie a triangular etch;
   
   disp('  ');disp('Bragg etch must end at an already given layer interface');
   disp('press return for default layer which is 2nd layer');
   desdep6=input('Desired depth etch ?(rounds to nearest layer)  ');
   if isempty(desdep6);desdep6= thick1(2);end; %(default etch depth is first layer)
   desdep6=abs(desdep6);
   [a b]=min(abs(layerdepth5-abs(-top6-desdep6)));bot6=layerdepth5(b);
   if isempty(bot6);bot6=layerdepth5(2);end;
   % gives nearest layer interface to desired depth of etch;
   % does not matter if entry is plus or minus for layer
   disp('  ')
   disp('Default infill refractive index 3.4 + loss = -20 per cm');
   disp('Use return key as usual for default');
   braggreal=input('Enter real refractive index of grating infill?  ');
   if isempty(braggreal), braggreal=3.4;end;
   braggloss=input('Enter loss (negative) of grating infill? (- inverse cms) ');
   if isempty(braggloss), braggloss= -20;	end;
   
   lbot=0.5*(widthtop6-widthbot6);
   figure(figlay5);hold on;pause(1);
   plot([0 widthtop6], [-top6 -top6],'m');
   plot([0 lbot], [-top6 -bot6],'m'); 
   plot([widthtop6, (widthtop6-lbot)], [-top6 -bot6],'m');
   plot([lbot, (widthtop6-lbot)], [-bot6 -bot6],'m');
   plot([bp widthtop6+bp], [-top6 -top6],'m');
   plot([bp lbot+bp], [-top6 -bot6],'m'); 
   plot([widthtop6+bp, (widthtop6-lbot)+bp], [-top6 -bot6],'m');
   plot([lbot+bp, (widthtop6-lbot)+bp], [-bot6 -bot6],'m');
   %plots nearest possibility repeated at bragg period;
   
   text(bp,-(2/3)*top6,'Bragg fill real/imagindex')
   braggindex6=braggreal+j*braggloss*(lambda1)/(40000*pi);
   br=num2str(braggreal);bi=num2str(imag(braggindex6));
   text(bp+(widthtop6)/3, -top6-(bot6-top6)/5,br);
   text(bp+(widthtop6)/3, -top6-4*(bot6-top6)/5,bi);
end;									%A

correct=input('correct? (yes/no/quit); MUST TYPE y or n or q ','s');
if isempty(correct),quit='n';end;
if correct=='n';p5layer;p6bragg;end
if correct=='y';quit='n';end;
if correct=='q';quit='q';end;