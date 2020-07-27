% Search used to improve trial estimates of effective refractive index.

for m=1:MN1	
   if (real(ER8(m))>0);
      for k=1:100;
         W=ER8(m) + (50-k)*change8;
         effind8(1)=real(W);effind8(2)=imag(W);
         logrho=p10refl(effind8);
         logr8(k)=logrho;
      end;
      [mm,JJ]=min(logr8);
      ER8(m)=ER8(m)+(50-JJ)*change8;R8(m)=logr8(JJ);
   end;
end;
disp(trv9);
disp(txt9);
disp(ER8);

for m=1:MN1,	
   if real(ER8(m))==0;R8(m)=0;
   end;
end;
disp(tx);disp(exp(R8));
%end;