% To rapidly delete figures
nw=input('How many figures to delete (default: all up to current figure):-  ');
if isempty(nw);nw=gcf;end;
nw=round(nw); % to ensure integer input
for n=1:nw;delete(figure(n));end
 