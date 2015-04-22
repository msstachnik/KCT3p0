%    KCTSETXYZ - Move the end-effector in a desired position
%
%    The function moves the end-effector of the robot from the current to the 
%    desired pose [x,y,z,roll,pitch,yaw]' using kctmovejoint to
%    send a velocity profile to the robot.
%
%    Usage: [robotinfo, warn] = kctsetxyz(pose,vp,option)
%
%    Arguments:
% 	       pose = vectors of desired end-effector pose [x,y,z,roll,pitch,yaw]
%            vp = percentage of maximum velocity supported
%        option = parameter/value pairs to specify additional properties:
%              'Plot', Boolean variable (1/0) enabling/disabling the plot
%              'FrameDimension', float variable to set the end-effector frame dimension
%              'FrameStep', float variable to set the end-effector frame step
%              'FrameColor', color of the end-effector frame
%              'TrajColor', color of the robot trajectory
%              'ShowRobot', Boolean variable (1/0) enabling/disabling the plot of the robot
%              'View', viewpoint specification (Az. and El. angles)
%
%
%    Return:
%        robotinfo = matrix containing the sequence of joint angles of the robot
%             warn = binary variable. If warn = 1, a problem occurred
%
%    Example: [robotinfo, warn] = kctsetxyz([x,y,z,roll,pitch,yaw],30,'Plot',1);
%
%    See also: KCSETJOINT
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

function [robotinfo,warn] = kctsetxyz(pose,robotspeed,varargin)

global kctptfr;
global kctrotfr;

kctoption = kctcheckarg(varargin);
 % kctmode = kctoption.Mode;
plot = kctoption.Plot;
df = kctoption.FrameDimension;
frst = kctoption.FrameStep;
trajcolor = kctoption.TrajColor;
framecolor = kctoption.FrameColor;
pov = kctoption.View;

currentpos = kctreadstate();    
angleDH = kctikinerpy(pose);

angleDH1=angleDH;
angleDH2=angleDH; angleDH2(4)=angleDH2(4)+180; angleDH2(5)=-angleDH2(5); angleDH2(6)=angleDH2(6)-180;
angleDH3=angleDH; angleDH3(4)=angleDH3(4)-180; angleDH3(5)=-angleDH3(5); angleDH3(6)=angleDH3(6)+180;

AllAngle = [angleDH1;angleDH2;angleDH3];
W = [sum(abs(-currentpos(2,:)-angleDH1));sum(abs(-currentpos(2,:)-angleDH2));sum(abs(-currentpos(2,:)-angleDH3))];
[Wm kctindex] = min(W);

theta = AllAngle(kctindex,:);

[robotinfo,warn] = kctsetjoint(theta,robotspeed,'Plot',plot,...
    'FrameDimension',df,'FrameStep',frst,'TrajColor',trajcolor,...
    'FrameColor',framecolor,'View',pov);