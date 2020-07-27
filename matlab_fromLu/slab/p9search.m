% Initial search for nearest effective refractive index.

logr9=zeros(1,200); effind9=logr9;
mn=effind8(2);
m=1; % sets initial value of mode counting parameter
for k=1:200; effind8(1)=(refrmax8-k*deltr8/200);
   logrho= p10refl(effind8); %calculates reflection coefficients.
   logr9(k)=logrho;
   effind9(k)=effind8(1);
end;

% logr9 is the set of log(reflection coefficient),
% effind9 is trial refractive index; 
figure;
plot(effind9,logr9,'k');
if tme1=='e',
   xlabel('refractive index');
   ylabel('log TE reflection coefficient')
end
if tme1=='m',
   xlabel('refractive index');
   ylabel('log TM reflection coefficient')
end
pause(1);
% FIGURE IS USEFUL TO SHOW WHERE MODES LIE AND IF THE SYSTEM WILL WORK
for k=2:199;
   if (logr9(k-1)>logr9(k))*(logr9(k)<logr9(k+1));
      if m<MN1+1, ER8(m)=(refrmax8-k*deltr8/200)+j*mn;R8(m)=logr9(k);m=m+1;end
   end;		 	   	
end; 		
% FINDS UP TO MN POTENTIAL MODES
trv9='Trial value';
txt9='Effective Refractive Index';
tx='Magnitude of Reflection Coefficient';
disp(trv9);disp(txt9);disp(real(ER8));
%ORDERS EFFECTIVE TRIAL REFRACTIVE INDICES IN MODE ORDER;
for m=1:MN1,	if real(ER8(m))==0;R8(m)=0;
   end;
end;
disp(tx);disp(exp(R8));
%end;