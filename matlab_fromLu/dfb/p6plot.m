p7plot;  % plots out spectrum only

disp('Press return to continue;');
disp('press 1 to plot internal electron/photon densities and continue;');
disp('press 2 for keyboard input (to remove noise) and continue ;');

pl=input('press 4 to quit; ..press now as above.  ');
if isempty(pl); pl=0; end;  % pl=0 continues with run using previous values;

if pl==1; p8plot; % plots fields and electrons and then asks continuation: %I
   disp('Do you wish to continue?'); 
   pl=input('Press 4 to quit, 2 for keyboard; return to continue;   ');
   if isempty(pl); pl=0; end;
end;									  %I

if pl==2; 
   disp('Type   r e t u r n and press return key at keyboard prompt to continue')
   disp('Type   sponto   then press return key to remove noise and continue;');
   %sponto is a sequence of programs that turns off noise
   %sponto runs laser and plots output etc giving 'idealised' output etc.
   keyboard;  % 退出keyboard模式 需要输入dbcont
   disp('Do you wish to continue? '); 
   pl=input('press 4 to quit, return to continue;    ');
   if isempty(pl); pl=0; end;
end;  % keyboard type return; 

if isempty(pl); pl=0; end;

if pl==0;
   p4run;
   p6plot;
end;
% if pl not equal 0 1 or 2 the program must end;
