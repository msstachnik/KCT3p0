%    KCTFKINE - Compute the forward kinematics of the robot
%
%    The function returns the forward kinematics homogeneous matrix of the robot
%
%    Usage: H_0e = kctfkine(angleDH)
%
%    Arguments:
% 	      angleDH = joint angles vector in degrees (Denavit-Hartemberg)          
%
%    Return:
%           H_0e = homogeneous matrix of the forward kinematics
%
%    See also: KCTFKINERPY
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

function H_0e = kctfkine(angleDH)

    global kctrobotlinks;
    global kctptfr;
    global kctrotfr;
    
    l1 = kctrobotlinks(1);
	l2 = kctrobotlinks(2);
    l3 = kctrobotlinks(3);
    l4 = kctrobotlinks(4);
    l5 = kctrobotlinks(5);
    l6 = kctrobotlinks(6);
    
    a = angleDH;

	H_01 = kctrotoz(a(1))*kcttran([0,0,l1]);
	H_12 = kctrotox(90)*kcttran([l2,0,0]);
	H_23 = kctrotoz(a(2))*kcttran([l3,0,0]);
	H_34 = kctrotoz(a(3))*kcttran([sqrt(l5^2+l4^2),0,0])*kctrotoy(90);
	H_45 = kctrotoz(a(4))*kctrotoy(-90);
	H_56 = kctrotoz(a(5))*kctrotoy(90);
	H_6e = kctrotoz(a(6))*kcttran([0,0,l6])*kctrotoz(-90);

    H_0e = H_01*H_12*H_23*H_34*H_45*H_56*H_6e;
    
    H_0e(1:3,1:3) =  inv(kctrotfr(1:3,1:3))*H_0e(1:3,1:3);
    
    temp_fr = [kctrotfr(1:3,1:3), kctptfr'; [0 0 0 1]];
    temp_fr = inv(temp_fr);
    
    H_0e(1:3,4) =    temp_fr(1:3,1:3)*H_0e(1:3,4) + temp_fr(1:3,4);
    

