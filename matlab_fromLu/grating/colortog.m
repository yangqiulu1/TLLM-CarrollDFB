%This program changes the MATLAB default settings for plotting
% black type with white background and no inversion of colour on printing
set(0,'defaultfigurepapertype','a4letter')
disp('Paper type has been set to A4')
disp('Figure set to black and white')
set(0,'defaultfigurecolor',[1,1,1])
set(0,'defaultaxesxcolor',[0,0,0])
set(0,'defaultaxesycolor',[0,0,0])
set(0,'defaultaxeszcolor',[0,0,0])
set(0,'defaultaxescolororder',[0,0,0;1,0,0;0,0,1;1,0,1;0,1,0])
set(0,'defaultfigureinverthardcopy','off')
set(0,'defaultaxeslinewidth',2)
%set(0,'defaultaxesfontweight','bold')
set(0,'defaultaxesfontsize',12)
set(0,'defaultlinelinewidth',1)
set(0,'defaulttextcolor',[0,0,0])
set(0,'defaulttextfontsize',10)
%cd\tdm  % default directory
%set(0,'defaulttextfontweight','bold')
%laser