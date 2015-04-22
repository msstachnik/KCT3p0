%    KCTPATHJOINT - Moves the end-effector of the robot along a desired trajectory.
%
%    The function moves the end-effector of the robot along a given trajectory
%    specified through a sequence of assigned poses in the joint space.
%
%    Usage: kctpathjoint(points,vp,plot)
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

function [robotinfo, warn] = kctpathjoint(points,vp,plot)

robotspeed = vp;
warn  = 0;

if nargin < 2
    disp('The default speed is 20%')
    plot = 0;
elseif nargin<3
    plot = 0;
end

CurrentState = kctreadstate();
currentstate = -CurrentState(2,:);

hist = points;

if robotspeed<0 || robotspeed > 100 || (floor(robotspeed) - robotspeed < 0)
    disp('joint percent speed must be an int value between 0 and 100')
    return
end

disp('First point approaching...')
kctsetjoint(hist(1,:),robotspeed);
disp('path is started')


for k=1:size(hist,1);
    
    robotstate = kctreadstate();
    jointangles = -robotstate(2,:);
    realtraj(k,:) = jointangles;
    
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

