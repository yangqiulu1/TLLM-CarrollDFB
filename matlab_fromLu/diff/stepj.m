disp('Comparison for forward and central differences');
disp('integrating df/dz = j*z f');
cont=input('Press return to continue');
% initial condition f=1 at z=0;
clear all;
colortog % this is introduced to ensure black on white background as default
N=input('No. of steps over range of z ?  [< 120] (press enter for default 30)  ');
  if isempty(N)
     N=30
  end;	% gives number of steps;
disp('wait while program runs: N = :-');
disp(N);
  L=3;    % range of z;
m=1:N;
s=L/N;  % step length;
z=s*(m-1);
a=j*z;
fc=zeros(size(m));ff=fc;
fc(1)=1;ff(1)=1;

for n=1:N-1;
fc(n+1)=fc(n)*(1+0.25*(a(n)+a(n+1))*s)/(1-0.25*(a(n)+a(n+1))*s);	
% central difference with Lax averaging 
ff(n+1)=fc(n)+s*a(n);
% forward difference without Lax averaging 
end;
figure;
f0=gcf; % gets the figure number;
theory=exp(0.5*a.*z); % true theoretical output

hold on;
plot((m-1)*s,abs(fc),'b.');
plot((m-1)*s,abs(theory),'r');
plot((m-1)*s,abs(ff),'g--');
title('theory (solid), central average (dot), forward (dash)')
axis([0 3 0 1.5]);
Nt=num2str(N);
text(2.7, 1.4,Nt);text(2.0, 1.4, 'no. of steps');
text(0.2, 1.25,'df/dz= z f integrated from 0 to 3 with f(0)=1')
text(0.2, 0.5, 'absolute values only plotted')
hold off;

figure(f0+1);plot((m-1)*s,.01+abs(100*(abs(theory)-abs(fc))./theory),'r-',(m-1)*s,abs(100*(abs(theory)-abs(ff))./theory)/10,'g--');
title('abs. % central error (solid)  - % forward error/10  (dash)');
% Note that % error in the title means per centage error in the absolute values;
figure(f0);
pause(3); % allows viewer to see figure for a few moments
figure(f0+1);

run=input('do you want another run y/n ?  ','s');
if isempty(run); run='y';end;
if run=='y';stepj;end;
