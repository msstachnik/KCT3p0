%    KCTPATHXYZ - Moves the end-effector of the robot along a desired trajectory.
%
%    The function moves the end-effector of the robot along a given trajectory
%    specified through a sequence of assigned poses
%    [x,y,z,roll,pitch,yaw]'.
%
%    Usage: kctpathxyz(points,vp,plot)
%
%    Arguments:
%            points = n x 6 matrix containing the poses of the end-effector
%                vp = percentage of maximum velocity supported
%                     (if not specified, a default value is set (vp = 20%))
%              plot = flag variable: if 1 the trajectory is displayed,
%                     if 0 it is not displayed.
%
%    Return:
%       robotinfo   = structure containing:
%        - realtraj  : Sequence of the actual poses of the end-effector along the trajectory;
%        - idealtraj : Sequence of the desired poses of the end-effector along the trajectory;
%              warn = binary variable. If warn = 1, a problem occurred.
%

%    Copyright (c) 2009 Francesco Chinello
%    Department of Information Engineering
%    University of Siena
%
%    This file is part of KCT (Kuka Control Toolbox).
%
%    KCT is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    KCT is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with KCT. If not, see <http://www.gnu.org/licenses/>.


function [robotinfo, warn] = kctpathxyz(points,vp,plot)

robotspeed = vp;

pot   = points(:,1:3);
rpy   = points(:,4:6);

warn  = 0;

if nargin < 2
    disp('The default speed il 20%')
    % time = 2;
    plot = 0;
elseif nargin<3
    plot = 0;
end

CurrentState = kctreadstate();
currentstate = -CurrentState(2,:);

for i = 1:size(points,1)
    hist(i,:) = kctikinerpy(points(i,:));
end

if robotspeed<0 || robotspeed > 100 || (floor(robotspeed) - robotspeed < 0)
    disp('joint percent speed must be an int value between 0 and 100')
    return
end

angleDH1=hist(1,:);
angleDH2=hist(1,:); angleDH2(4)=180-angleDH2(4); angleDH2(5)=-angleDH2(5); angleDH2(6)=angleDH2(6)-180;
angleDH3=hist(1,:); angleDH3(4)=angleDH3(4)-180; angleDH3(5)=-angleDH3(5); angleDH3(6)=180-angleDH3(6);
angleDH4=hist(1,:); angleDH4(4)=angleDH4(4)+180; angleDH4(5)=-angleDH4(5); angleDH4(6)=angleDH4(6)-180;
angleDH5=hist(1,:); angleDH5(4)=angleDH5(4)-180; angleDH5(5)=-angleDH5(5); angleDH5(6)=angleDH5(6)+180;

AllAngle = [angleDH1;angleDH2;angleDH3;angleDH4;angleDH5]
W = [sum(abs(currentstate-angleDH1));sum(abs(currentstate-angleDH2));sum(abs(currentstate-angleDH3));sum(abs(currentstate-angleDH4));sum(abs(currentstate-angleDH5));];
[Wm kctindex] = min(W);
hist(1,:) = AllAngle(kctindex,:);

disp('First point approaching...')
kctsetjoint(hist(1,:),robotspeed);
disp('path is started')
k = 1;
for k=1:size(hist,1);
    
    robotstate = kctreadstate();
    jointangles = -robotstate(2,:);
    realtraj(k,:) = jointangles;
    
    angleDH1=hist(k,:);
    angleDH2=hist(k,:); angleDH2(4)=angleDH2(4)+180; angleDH2(5)=-angleDH2(5); angleDH2(6)=angleDH2(6)-180;
    angleDH3=hist(k,:); angleDH3(4)=angleDH3(4)-180; angleDH3(5)=-angleDH3(5); angleDH3(6)=angleDH3(6)+180;
    angleDH4=hist(1,:); angleDH4(4)=angleDH4(4)+180; angleDH4(5)=-angleDH4(5); angleDH4(6)=angleDH4(6)-180;
    angleDH5=hist(1,:); angleDH5(4)=angleDH5(4)-180; angleDH5(5)=-angleDH5(5); angleDH5(6)=angleDH5(6)+180;
    
    AllAngle = [angleDH1;angleDH2;angleDH3];
    W = [sum(abs(jointangles-angleDH1));sum(abs(jointangles-angleDH2));sum(abs(jointangles-angleDH3))];
    [Wm kctindex] = min(W);
    
    theta = AllAngle(kctindex,:);
    hist(k,:) = theta;
    joint_error = hist(k,:) - jointangles;
    
    t_stim = (max(abs(joint_error)))/(9*1.45*robotspeed/100)+0.1;
    
    % 9 is the max joint velocity for Eth.RSIXML
    % 1.45 is the real velocity by kuka velocity ratio.
    
    vel = (joint_error/t_stim)*1/1.45;
    
    kctmovejoint(-vel);
    
    tic;
    while toc<t_stim
    end
end

kctstop();
idealtraj = hist;

if plot == 1
    kctdisptraj(idealtraj,'TrajColor','blu');  
    kctdisptraj(realtraj,'TrajColor','red');
    for kctindex = 1:size(points,1)
        v=[points(kctindex,1),points(kctindex,1),points(kctindex,1)]';
        rot = kctrotoz(points(kctindex,4))*kctrotoy(points(kctindex,5))*kctrotox(points(kctindex,6));
        kctstate(kctindex,:) = kctikine([rot(1:3,1:3),v;0 0 0 1]);
    end
    kctdispdyn(kctstate,'blu');
end

robotinfo.realtraj = realtraj;
robotinfo.idealtraj = idealtraj;
