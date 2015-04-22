%    KCTSETJOINT - Set the joint angles to a desired value
%
%    The function moves the robot from the current to the desired
%    configuration using kctmovejoint to send a velocity profile to the robot.
%
%    Usage: [robotinfo, warn] = kctsetjoint(angleDH,vp,option)
%
%    Arguments:
% 		angleDH = vectors of joint angles (Denavit-Hartemberg)
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
%    Return:
%       robotinfo = matrix containing the sequence of joint angles of the robot
%            warn = binary variable. If warn = 1, a problem occurred
%
%    Example: [robotinfo, warn] = kctsetjoint(angleDH,30,'Plot',1);
%
%    See also: KCTSETXYZ
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

function [robotstate, warn] = kctsetjoint(angleDH,jointspeed,varargin)

global kctptfr;
global kctrotfr;

% Check function's options
kctoption = kctcheckarg(varargin);
% kctmode = kctoption.Mode;
plot = kctoption.Plot;
df = kctoption.FrameDimension;
frst = kctoption.FrameStep;
trajcolor = kctoption.TrajColor;
framecolor = kctoption.FrameColor;
pov = kctoption.View;

% Bounds control
kctrobotbound = load('kctrobotbound');
KW = kctrobotbound.kctworkspace;

% Find MIN MAX

Mbound = kctfkine(angleDH);

% Check bound in original reference system
temp_fr = [kctrotfr(1:3,1:3), kctptfr'; [0 0 0 1]];
Mbound = temp_fr*Mbound;

if (Mbound(1,4)<KW(1,1))||(Mbound(1,4)>KW(1,2))
    disp('X out of bound.')
    disp('The point is out of bounds. Display the bounds with kctgetbound and retry.');
    return;
end

if (Mbound(2,4)<KW(1,3))||(Mbound(2,4)>KW(1,4))
    disp('Y out of bound.')
    disp('The point is out of bounds. Display the bounds with kctgetbound and retry.');
    return;
end

if (Mbound(3,4)<KW(1,5))||(Mbound(3,4)>KW(1,6))
    disp('Z out of bound.')
    disp('The point is out of bounds. Display the bounds with kctgetbound and retry.');
    return;
end

if (angleDH(1,4)<KW(2,1))||(angleDH(1,4)>KW(2,2))
    disp('Joint angle 4 is out of bound.')
    disp('The point is out of bounds. Display the bounds with kctgetbound and retry.');
    return;
end

if (angleDH(1,5)<KW(2,3))||(angleDH(1,5)>KW(2,4))
    disp('Joint angle 5 is out of bound.')
    disp('The point is out of bounds. Display the bounds with kctgetbound and retry.');
    return;
    
end
if (angleDH(1,6)<KW(2,5))||(angleDH(1,6)>KW(2,6))
    disp('Joint angle 6 is out of bound.')
    disp('The point is out of bounds. Diplay the bounds with kctgetbound and retry.');
    return;
end
% Robot motion
robotstate = kctreadstate();

jointangles = -robotstate(2,:);
robotstate(1,:) = jointangles;

if (jointspeed<0 || jointspeed > 100) || (floor(jointspeed) - jointspeed < 0)
    disp('joint percent speed must be an int value between 0 and 100')
    return
end

joint_error = angleDH - jointangles;

t_stim = (max(abs(joint_error)))/(9*1.45*jointspeed/100)+0.1;

% 9 is the max joint velocity for Eth.RSIXML
% 1.45 is the real velocity by kuka velocity ratio.

vel = (joint_error/t_stim)*1/1.45;

kctmovejoint(-vel);

tic;
while toc<t_stim
end

kctstop();

robotst = kctreadstate();
robotstate(2,:) = -robotst(2,:)
robotinfo = robotstate;
if norm(abs(angleDH-(-robotst(2,:))),inf)>5
    disp('Bound touching occured, check your bound and retry');
    warn = 1;
else
    warn = 0;
end

if plot == 1
    kctdisptraj(robotstate,'FrameDimension',df,'FrameStep',frst,'FrameColor',framecolor, ...
        'TrajColor',trajcolor,'View',pov);
    kctdispdyn(robotstate,'blu');
end





