%  Last Update 2015-05-20 20:25 Mateusz Stachnik
clc;
clear all;
close all;

%% preconditions
%% Preconditions - parametrization form Kuka_KR_6_R_900_documentation.pdf page 5
KR6R900.Links = [400 25 480 0 420 80];
KR6R900.Name = 'KR6_900';
KR6R900.Home  = ...
    [0 0 0 0 0 0
     0 90 -90 0 0 0];
KR6R900.Workspace = ...
     [-851.5 901.5 -901.5 901.5 -334 1276 %Xmin Xmax Ymin Ymax Zmin Zmax
      -120 156 -180 180 -100 100];
  
KR6R900.Joint(1).Min = -170; 
KR6R900.Joint(1).Max = 170; 
KR6R900.Joint(1).Value = KR6R900.Home(2,1); 

KR6R900.Joint(2).Min = -45; 
KR6R900.Joint(2).Max = 190; 
KR6R900.Joint(2).Value = KR6R900.Home(2,2);

KR6R900.Joint(3).Min = -156; 
KR6R900.Joint(3).Max = 120; 
KR6R900.Joint(3).Value = KR6R900.Home(2,3); 

KR6R900.Joint(4).Min = -180;
KR6R900.Joint(4).Max = 180;
KR6R900.Joint(4).Value = KR6R900.Home(2,4);

KR6R900.Joint(5).Min = -100; 
KR6R900.Joint(5).Max = 100; 
KR6R900.Joint(5).Value = KR6R900.Home(2,5); 

KR6R900.Joint(6).Min = -180;
KR6R900.Joint(6).Max = 180; 
KR6R900.Joint(6).Value = KR6R900.Home(2,6);



save KR6R900 KR6R900
%%
% kctdisprobot(KR6R900)
KukaGui_V2