
% Use random spontaneous look up table to speed calculations	
% size of lookup table limited by computer storage and student MATLAB


spf=bb*0.7*(randn(N,256)+j*randn(N,256)); %set up for random forward spontaneous input;
spr=bb*0.7*(randn(N,256)+j*randn(N,256)); %set up for random forward spontaneous input;
shotn=randn(N,256);
% spf and spr give two uncorrelated sets of N uncorrelated spont. inputs for 256 time steps;

%end;