clear all
disp('Finds approx. value of threshold gain and offset frequency for a uniform index grating DFB');
disp('Normalises beta, delta=d, field gain=g to magnitude of kappa=k:');
disp('hence respectively bk =b/k  dk= d/k and gk =g/k are the normalised parameters.');
disp('Choose magnitude  kappa*length  (0.7 < kL < 4.5) ');
% does not work outside range as first search range inadequately chosen.
kL=input('kappa*length product ? (default 1) :   '); 
if isempty(kL); kL=1; end;% kL gives the strength of the coupling for a given length L of the laser. 
xx=abs(kL);
stp=32;A=ones(1,stp);
% 32 is maximum number permitted for student matlab with the mesh search used

gL=(1:stp)*(3/(xx*stp));
dL=(1:stp)*3*xx/stp;
mL=A'*gL+j*(A'*dL)';
KL=sqrt((mL).^2+(kL)^2);
err= log(abs(mL.*tanh(KL)-KL));
%gL from the column number and dL from the row;
[v,q]=min(err);
%min value v of row element returning row q in each column
[vv,p]=min(min(err));
%returns the number p of the column in which is minimum vv
dLm=q(p)*(3*xx/stp);
gLm=p*(3/(xx*stp));

% disp(gLm);disp(dLm);disp(p); 
%keyboard;
% above two lines may be useful for intermediate check.

gLL=gLm-(1.5/(xx*stp))+1.1*gL/stp ;
dLL=dLm-(1.5*xx/stp)+1.1*dL/stp;
mL=A'*gLL+j*(A'*dLL)';
KL=sqrt((mL).^2+(kL)^2);
err= log(abs(mL.*tanh(KL)-KL));
[v,q]=min(err);
[vv,p]=min(min(err));
dLmm=dLm-(1.5*xx/stp)+q(p)*(3.3*xx/stp^2);
gLmm=gLm-(1.5/(xx*stp))+p*(3.3/(xx*stp^2));
disp('gL threshold ; dL threshold');disp([gLmm dLmm]);
disp('error');disp( exp(vv)/abs(KL(q(p),p)));
%disp(p); 
%one can tell if p is at limits of 32 then values are suspect.
%'error' gives a measure of (mL.*tanh(KL)-KL) closeness to zero; 
%end;


run=input('do you want another run y/n ?  ','s');
if isempty(run); run='y';end;
if run=='y';dfbthr;end;