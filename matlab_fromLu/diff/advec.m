disp('Program to demonstrate pulse propagation');
disp('for finite difference solution of advection equations as in book');
cont=input('Press return to continue');
clear all;
colortog % this is introduced to ensure black on white background as default

%h=gcf; delete(h); % if one does not wish for a new figure on each run, then delete the front %

a=input('Normalised group velocity?  [.4 < v < 2] (press enter for default 1)  ');
if isempty(a)
   a=1
end;	
vg=num2str(a); 		% normalised group velocity
N=300;   		%sets up closed number of points;
rep=round(1.5*N/a); 	% Number of repetitions of plotting;
ns=1:N;	 		% space counter
nt=1:rep; 		% time counter
e=(1-a)/(1+a); 		% velocity parameter in equations
fn=zeros(1,N); 		% fn will be the new field;
fo=fn; fos=fn; 		% fo will be the old fields, fos will be the starting fields;


figure;			% gets a new figure each run
axis([-20 300 -100 500])
xlabel('Distance steps')
ylabel('Time steps - or - Relative pulse height')
title('Pulse amplitude - Time - Distance')
text(100,450,'normalised group velocity');text(250,450,vg);

pulse=line(0,0,'erasemode','xor','color','r'); % setting a line with correct erasemode properties
time=line(0,0,'color','b','erasemode','xor'); % setting another line with correct erasemode properties;

width=N/20;	% sets pulse 'width'	
% to see how distortion is reduced when pulse changes more slowly set width = N/10;	

for n=1:1+2*width;
   fos(n)=(1-sign(n-1-2*width))*(1+cos((n-1-width)*pi/width)); % starts to shape a pulse input.
end;

fo=fos.*fos; % final pulse shape tapering start/end values of pulse

distance=0; tim=1; %sets start parameters

while distance<300; %ensures plotting is finite
   fn(1)=0;
   
   for n=1:299    
      fn(n+1)=fo(n)+e*(fo(n+1)-fn(n));   % basic propagation of pulse
   end;
   
   fo=fn; 		% old = new
   [height, distance]=max((fo));
   set(pulse,'Xdata',ns-20,'Ydata',25*full(fo));
   set(time,'Xdata',[-20 distance-20],'Ydata',[nt(1) nt(tim)]);
   drawnow;
   tim=tim+1; % advances time step counter;
end;

run=input('do you want another run y/n ?  ','s');
if isempty(run); run='y';end;
if run=='y';advec;end;
