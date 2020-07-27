disp('Test program for forward and central differences')
disp('integrating df/dz = z f');
cont=input('Press return to continue');
% initial condition f=1 at z=0;
clear all;
colortog % this is introduced to ensure black on white background as default
N=input('No. of steps over range of z ?  [< 120] (press enter for default 30)  ');
if isempty(N)
   N=30;
end;	% gives number of steps;
disp('wait while program runs: N = :-');
disp(N);
L=3;    % range of z;
m=1:N;
s=L/N;  % step length;
z=s*(m-1);
a=z;
fc=zeros(size(m));ff=fc;
fc(1)=1;ff(1)=1;

for n=1:N-1;
   fc(n+1)=fc(n)*(1+0.25*(a(n)+a(n+1))*s)/(1-0.25*(a(n)+a(n+1))*s);	
   % 'central difference' with Lax averaging 
   ff(n+1)=fc(n)+s*a(n);
   % 'forward difference' without Lax averaging 
end;
figure;
f0=gcf; % gets the figure number;
theory=exp(0.5*a.*z); % true theoretical output

hold on;
plot((m-1)*s,fc,'r.');
plot((m-1)*s,theory,'b');
plot((m-1)*s,ff,'g--');
title('theory (solid), central average (dot), forward (dash)')
axis([0 3 0 90]);
Nt=num2str(N);
text(2.7, 80,Nt);text(2.0, 80, 'no. of steps');
text(0.2, 60,'df/dz= z f integrated from 0 to 3 with f(0)=1')
hold off;

figure(f0+1);plot((m-1)*s,abs(100*(theory-fc)./theory),(m-1)*s,abs(100*(theory-ff)./theory)/10,'g--');
title('% central error (solid)  - % forward error/10  (dash)');
% Note that % error in the title means per centage error;
figure(f0);
pause(3); % allows viewer to see figure for a few moments
figure(f0+1);

run=input('do you want another run y/n ?  ','s');
if isempty(run); run='y';end;
if run=='y';step;end;
