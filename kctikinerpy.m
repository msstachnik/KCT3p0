%    KCTIKINERPY - Return the inverse kinematics of the robot (from the pose)
%  
%    The function computes the inverse kinematics of the robot manipulator 
%    from the 6-dimensional vector p = [x,y,z,roll,pitch,yaw]' 
%
%    Usage: angleDH = kctikine(p)
%
%    Arguments:
% 	          p = 6-dimensional vector: the first three components are the x,y,z 
%                 coordinates of the end-effector and the last three components are the
%                 roll-pitch-yaw angles (in degrees) of the end-effector.
%    Returns:
%              angleDH = joint angles vector in degrees (Denavit-Hartemberg)
%
%    See also: KCTIKINE
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

function angDH = kctikinerpy(c_rpy)

    A = c_rpy(1,4);
    B = c_rpy(1,5);
    C = c_rpy(1,6);

    rot = kctrotoz(A)*kctrotoy(B)*kctrotox(C)
    
    M = [rot(1:3,1:3),c_rpy(1:3)';0 0 0 1];
    angDH = kctikine(M);
