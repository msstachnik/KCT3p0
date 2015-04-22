%    KCTIKINE - Return the inverse kinematics of the robot
%  
%    The function computes the inverse kinematics of the robot manipulator. 
%    A joint angles vector in degrees (Denavit-Hartemberg) is returned. 
%
%    Usage: angleDH = kctikine(mat)
%
%    Arguments:
% 	        mat = 4 x 4 homogeneous matrix
%
%    Return:
%           angleDH = joint angles vector in degrees (Denavit-Hartemberg)
%
%    See also: KCTIKINERPY
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

function angleDH = kctikine(mat)
   
    global kctrobotlinks;
    global kctptfr
    global kctrotfr
   
    l1=kctrobotlinks(1);
	l2=kctrobotlinks(2);
    l3=kctrobotlinks(3);
    l4=kctrobotlinks(4);
    l5=kctrobotlinks(5);
    l6=kctrobotlinks(6);

	vet = mat(1:3,4);
	rot = mat(1:3,1:3);
    delta = 1;
    gamma = 1;
  
    
    % update the new frame (if it exists)
    vet = kctptfr'+kctrotfr(1:3,1:3)*vet;
    rot = kctrotfr(1:3,1:3)*mat(1:3,1:3);
    
    if vet(1,1)<0
        delta = 0;
        if vet(2,1)<0
            gamma = 0;
        end
    end
   
	% Computes the coordinates of joint 5 using joint 6.
	vet = vet-l6*rot(1:3,3); 
	theta_1 = asin(vet(2,1)/(sqrt(vet(2,1)^2+vet(1,1)^2))) ;
    theta_1 = ((1-delta)*(pi-theta_1)+theta_1*delta)*(gamma)+((1-delta)*(-pi-theta_1)+theta_1*delta)*(1-gamma);
	t2_1 = atan((vet(3,1)-l1)/(sqrt(vet(1,1)^2+vet(2,1)^2)-sqrt((l2*sin(theta_1))^2+(l2*cos(theta_1))^2))); 
	d_2_5 = sqrt((vet(3,1)-l1)^2+(sqrt(vet(1,1)^2+vet(2,1)^2)-sqrt((l2*sin(theta_1))^2+(l2*cos(theta_1))^2))^2);       % distanza dal giunto 2  5
	t2_2 = acos(((l4^2+l5^2)-l3^2-d_2_5^2)/(-2*l3*d_2_5));  % Carnot inverse formula
	t3_1 = acos((l3^2-(l4^2+l5^2)-d_2_5^2)/(-2*sqrt(l4^2+l5^2)*d_2_5));   
	theta_2 = t2_2+t2_1;
	theta_3 = (-1)*(t3_1+t2_2);  
  
    % Computes the forward kinematics between joint 0 and joint 3
        
    H_01 = kctrotoz(theta_1*180/pi)*kcttran([0,0,l1]); 
	H_12 = kctrotox(90)*kcttran([l2,0,0]);
	H_23 = kctrotoz(theta_2*180/pi)*kcttran([l3,0,0]);
	H_34 = kctrotoz(theta_3*180/pi)*kcttran([sqrt(l5^2+l4^2),0,0])*kctrotoy(90);
	H_0_3 = H_01*H_12*H_23*H_34;
	H_0_3 = H_0_3(1:3,1:3);

	% Indirect computation of the homogeneous matrix between joint 4 and 6
 	H4_e = inv(H_0_3)*rot;  
	
	if rot(3,3)<0  && rot(1,2)>=0 && rot(3,2)>=0
            theta_4=-atan(H4_e(1,3)/H4_e(2,3));
    		theta_5=asin(H4_e(2,3)/cos(theta_4));
    		theta_6=-asin(H4_e(3,2)/sin(theta_5));
	elseif (rot(3,3)<0 && rot(1,2)<0) || (rot(3,3)<0 && rot(3,2)<0)
    		theta_4=-atan2(H4_e(1,3),H4_e(2,3));
    		theta_5=asin(H4_e(2,3)/cos(theta_4));
    		theta_6=-atan2(H4_e(3,2),H4_e(3,1));
	elseif rot(3,3)>0
    		theta_4=-atan2(H4_e(1,3),H4_e(2,3));
            theta_6=-atan2(H4_e(3,2),H4_e(3,1));
    		theta_5= atan2((H4_e(3,1)/cos(theta_6)),(H4_e(3,3))); % 
    end
    
	angleDH = [theta_1 theta_2 theta_3 theta_4 theta_5 theta_6]*180/pi;
   
