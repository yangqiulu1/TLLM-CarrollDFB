% Calculates TE or TM fields according as tem1 = e or m.

% conf13 is the current confinement factor passed back to calc for storing;
% uses permittivity as modified by Bragg etching if grating is present in the layers
% does not use refractiveindex as entered
%some names are shortened here for simplicity;

ko=wavevector1;% in inverse microns with layer thickness in microns.
d=thick12 ;e=permittivity12; % of each layer;
refrind=sqrt(e);% refractiveindex is reserved for original input.
num=layernum12; laydep=layerdepth12';
O=ones(1,num);
beta2=ko*ko*effperm8;
effref=sqrt(effperm8); %effective refractive index
gg=beta2*O-ko*ko*e;
g=sqrt(gg); % short for gamma 


field=zeros(2,num);   % sets matrix of the right dimensions;
field2=zeros(1,num);field2m=field2;

gl=(1/2)*(imag(refrind)+abs(imag(refrind)));%forms gain layer sections vector;
ll=(1/2)*(-imag(refrind)+abs(imag(refrind)));
ll=ll*40000*pi/lambda1; %forms loss layer sections vector in inverse cms.; 

field(1,1)=exp(g(1)*d(1));

depths=d(num);
ff=field(:,1);

%TM FIELDS
if tme1=='m';% forms TM fields at all points.
   for k=2:num;		
      Q=[exp(g(k)*d(k)) 0;0 exp(-g(k)*d(k))];
      QQ=[(g(k)*e(k-1)+g(k-1)*e(k)) (g(k)*e(k-1)-g(k-1)*e(k));(g(k)*e(k-1)-g(k-1)*e(k)) (g(k)*e(k-1)+g(k-1)*e(k-1))];
      field(:,k)=(1/(2*e(k-1)*g(k)))*Q*QQ*ff;
      ff=field(:,k);
      % Matlab version requires this extra step defining ff;
   end;
   
   for p=num+1-ext12(layernum7):1:num; field(1,p)=0; end;
   % growing fields may dominate with small errors in M(1 1) unless artificially eliminated.
   
   nethfield=[1  1]*field;
   % nethfield is Hfield(up) +Hfield(down) at each point.
   
   % The interaction with the dipoles is with the net electric field.
   % Where the H field is a maximum in the active region the z component of E field is negligible
   % This means that one can approximate to the net E field using only its y-component;
   
   per=refrind.*refrind;% permittivity at all points.
   netfield=nethfield./per;  % gives approximately the net E-field
end;
%END of TM E FIELD CALC.

%TE FIELDS;
if tme1=='e';% Forms TE fields at all points.
   
   for k=2:num;		
      Q=[exp(g(k)*d(k)) 0;0 exp(-g(k)*d(k))];
      QQ=[(g(k)+g(k-1)) (g(k)-g(k-1));(g(k)-g(k-1)) (g(k)+g(k-1))];
      field(:,k)=(1/(2*g(k)))*Q*QQ*ff;
      ff=field(:,k);
      %matlab version requires this extra step defining ff;
   end;
   
   for p=num+1-ext12(layernum7):1:num; field(1,p)=0; end;
   % growing fields dominate with small errors in M(1 1) unless artificially eliminated.
   
   netfield=[1  1]*field;
   % netfield is Efield(up) +Efield(down) at each point.
end;
%END of TE E FIELD CALC.

fieldmax=max(abs(netfield));field13=netfield/fieldmax;
field2=abs(field13.^2);% forms intensity
for k=1:num-1,field2m(k)=0.5*(field2(k)+field2(k+1));end;%interpolates intensity
field2m(num)=2*field2(num)-field2(num-1);
if field2m(num)<0; field2m(num)=0;end;%fixes end intensity;
fieldsq13 = sum(field2m.*d);
field2m13=field2m;
conf13=sum(gl.*(field2m.*d))/(fieldsq13*max(gl));
% calculates confinement factor from E fields ;
if bragg=='y';
   p15kappa;% calculates coupling coefficients assuming symmetrical etch
   %disp('Keyboard allows interim interrogation of variables; type return to continue')
   %keyboard; 
   %can be helpful to return to keyboard control to interrogate more parameters.
end

loss=sum(ll.*(field2m.*d))/fieldsq13;
loss=round(100*loss)/100; 
% calculates effective loss of all lossy layers for the mode.
% loss can be called after the calculation.

figure; %brings up new figure for a plot of each mode.
mm=max([(1+num/10) (max(real(refrind)+.3))]);
dep=depths+.3;rr=real(refrind);
plot(laydep,10*field2,'k', laydep, rr,'m');
% Plots field intensity normalised to maximum in black.
% Plots thickness and refractive index of layers in magenta
% Point allows space for text
confine13=round(100*conf13)/100;
con13=num2str(confine13);% rounds confinement factor and puts number to string.
text(5*depths,1.5,con13);
text(5*depths,2,'confinement factor');
if tme1=='e',
   xlabel('TE E Fields(mod squared)/distance');
end
if tme1=='m',
   xlabel('TM E Fields(mod squared)/distance');
end

%if tme1=='m'; set(gca,'xlabel',text(1,-0.8,'TM E Fields (mod squared)'));end;
%if tme1=='e'; set(gca,'xlabel',text(1,-0.8,'TE E Fields (mod squared)'));end;
%labels fields TE or TM

powgain=4*pi*imag(effref)*(10^4)/lambda1; %power gain in inverse cms.
gaine=num2str(powgain);
text(layerdepth12(round(.6*layernum12)), 3, 'power gain (1/cms)');
text(layerdepth12(round(.6*layernum12)), 2.5, gaine);
% displays effective gain
efre=num2str(real(effref));
text(layerdepth12(round(.6*layernum12)), 6.5 ,'eff.ref.ind.');
text(layerdepth12(round(.6*layernum12)), 6, efre);
% displays effective refractive index.

if bragg=='y'
   text(5*depths,9.5,'kappa index');
   text(5*depths,8,'kappa gain');
   text(5*depths,6.5,'kappa radiation');
   kapi=num2str(kapindex15);
   kapg=num2str(kapgain15);
   kapr=num2str(kaprad15);
   text(5*depths,9,kapi);
   text(5*depths,7.5,kapg);
   text(5*depths,6,kapr);
end;
%5end;
p14far;
%end;