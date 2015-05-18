%  Last Update 2015-04-22 01:53 Mateusz Stachnik
clc;
clear all;
% close all;

%% Preconditions - parametrization form Kuka_KR_6_R_900_documentation.pdf page 5
KR6R900.Links = [400 25 480 0 420 80];

% Dimensions I = 400 - Joint 1
% Dimensions not_set = 25 - Joint 2
% Dimensions H + noo_set = 455 + 35 = 480 - Joint 3
% Dimensions not_set = 0 - Joint 4
% Dimensions G = 420 - Joint 5
% Dimensions not_set = 80 - Joint 6

KR6R900.Name = 'KR6_900';
KR6R900.Home  = ...
    [0 0 0 0 0 0
     0 -90 90 0 0 0];
KR6R900.Workspace = ...
     [-851.5 901.5 -901.5 901.5 -334 1276 %Xmin Xmax Ymin Ymax Zmin Zmax
      -120 156 -180 180 -90 90]; % it is even not consider :)
  
 % in Kuka_KR_6_R_900_documentation.pdf page 5 - bounds of robot
%% initialization of robot
 kctdeleterobot(KR6R900.Name); % delete od robot
 kctinsertrobot(KR6R900.Name,KR6R900.Links); %add new rotob with defined parameters
 
 
kctinit('KR6_900') %init robot

%% do some operation to update global variables
KR6R900.Joint(1).Min = -170; %  Last Update 2015-05-02 14:25 Mateusz Stachnik
KR6R900.Joint(1).Max = 170; %  Last Update 2015-05-02 14:25 Mateusz Stachnik

KR6R900.Joint(2).Min = -45; %  Last Update 2015-05-02 14:25 Mateusz Stachnik
KR6R900.Joint(2).Max = 190; %  Last Update 2015-05-02 14:25 Mateusz Stachnik

KR6R900.Joint(3).Min = -156; %  Last Update 2015-05-02 14:25 Mateusz Stachnik
KR6R900.Joint(3).Max = 120; %  Last Update 2015-05-02 14:25 Mateusz Stachnik

KR6R900.Joint(4).Min = -180; %  Last Update 2015-05-02 14:25 Mateusz Stachnik
KR6R900.Joint(4).Max = 180; %  Last Update 2015-05-02 14:25 Mateusz Stachnik

KR6R900.Joint(5).Min = -100; %  Last Update 2015-05-02 14:25 Mateusz Stachnik
KR6R900.Joint(5).Max = 100; %  Last Update 2015-05-02 14:25 Mateusz Stachnik

KR6R900.Joint(6).Min = -180; %  Last Update 2015-05-02 14:25 Mateusz Stachnik
KR6R900.Joint(6).Max = 180; %  Last Update 2015-05-02 14:25 Mateusz Stachnik


%% save KR6R900 structure to hanlde into the GUI

actual_robot = KR6R900;
save ActualRobot actual_robot

%%

kctrobotlinks = KR6R900.Links;
save kctrobotlinks.mat kctrobotlinks

kctworkspace = KR6R900.Workspace;
save kctrobotbound.mat kctworkspace

kcthomeposition = KR6R900.Home ;
save kctrobothome.mat kcthomeposition



%% init GUI
kctdrivegui


%%
for i = 1:50
    
    KR6R900.Joint(1).Value = randp(1, KR6R900.Joint(1).Min, KR6R900.Joint(1).Max)
    KR6R900.Joint(2).Value = randp(1, KR6R900.Joint(2).Min, KR6R900.Joint(2).Max)
    KR6R900.Joint(3).Value = randp(1, KR6R900.Joint(3).Min, KR6R900.Joint(3).Max)
    KR6R900.Joint(4).Value = randp(1, KR6R900.Joint(4).Min, KR6R900.Joint(4).Max)
    KR6R900.Joint(5).Value = randp(1, KR6R900.Joint(5).Min, KR6R900.Joint(5).Max)
    KR6R900.Joint(6).Value = randp(1, KR6R900.Joint(6).Min, KR6R900.Joint(6).Max)
    
    ActualJoint = [KR6R900.Joint.Value];
    update_kct_gui(ActualJoint) 
%     kcttempposition(2,1) = i * 10;
%         kctdrivegui_robotDisplay(100);
%         pause(1)
    
end




%%
% t = kctclient('192.168.1.0');




