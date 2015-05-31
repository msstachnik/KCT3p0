%  Last Update 2015-05-20 20:25 Mateusz Stachnik
clc;
clear all;
close all;

%% Preconditions - parametry robota z dokumentacji: Kuka_KR_6_R_900_documentation.pdf page 5
KR6R900.Links = [400 25 455 35 420 80];
KR6R900.Name = 'KR6_900';
KR6R900.Home  = ...
    [0 0 0 0 0 0
     90 -90 90 0 0 0]; % dobrane na podstawie odczytu zakresu ruchów robota 24-05-2015  
KR6R900.Workspace = ...
     [-851.5 901.5 -901.5 901.5 -334 1376 %Xmin Xmax Ymin Ymax Zmin Zmax
      -120 156 -180 180 -100 100];
  
%% dobrane na podstawie odczytu zakresu ruchów robota 24-05-2015  
KR6R900.Joint(1).Min = -155; 
KR6R900.Joint(1).Max = 168; 
KR6R900.Joint(1).Value = KR6R900.Home(2,1); 

KR6R900.Joint(2).Min = -181; 
KR6R900.Joint(2).Max = 46; 
KR6R900.Joint(2).Value = KR6R900.Home(2,2);

KR6R900.Joint(3).Min = -121; 
KR6R900.Joint(3).Max = 157; 
KR6R900.Joint(3).Value = KR6R900.Home(2,3); 

KR6R900.Joint(4).Min = -186;
KR6R900.Joint(4).Max = 186; 
KR6R900.Joint(4).Value = KR6R900.Home(2,4);

KR6R900.Joint(5).Min = -102; 
KR6R900.Joint(5).Max = 116; 
KR6R900.Joint(5).Value = KR6R900.Home(2,5); 

KR6R900.Joint(6).Min = -351;
KR6R900.Joint(6).Max = 351; 
KR6R900.Joint(6).Value = KR6R900.Home(2,6);

KR6R900.display = 1;

save KR6R900_V3 KR6R900
%%
% kctdisprobot(KR6R900)
KukaGui_V4