%    KCTFKINERPY - Compute the forward kinematics of the robot (return the pose) 
%
%    The function returns the forward kinematics as a vector p = [x,y,z,roll,pitch,yaw]' 
%
%    Usage: p = kctfkinerpy(angleDH)
%
%    Arguments:
%                 angleDH = joint angles vector in degrees (Denavit-Hartemberg)
%
%    Return:
%                 a 6-dimensional vector p: the first three components are the x,y,z 
%                 coordinates of the end-effector and the last three components are the
%                 roll-pitch-yaw angles (in degrees) of the end-effector.
%
%    See also: KCTFKINE
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

function [c_rpy] = kctfkinerpy(angleDH)

    H = kctfkine(angleDH);

    coor = H(1:3,4);
    
    Y =  real(atan(H(2,1)/H(1,1)));
    P =  real(-asin(H(3,1)));
    
    Rx = inv(kctrotoz(Y)*kctrotoy(P))*H;
   
    Rtemp(1,1) = real(acos(Rx(2,2)));
    Rtemp(2,1) = real(asin(Rx(3,2)));
    Rtemp(3,1) = real(-asin(Rx(2,3)));
    Rtemp(4,1) = real(acos(Rx(3,3)));

    % Disambiguate the solution
    for i = 1:4
          Hdiff =H - kctrotoz(Y)*kctrotoy(P)*kctrotox(Rtemp(i,1));
          kctsignal = 0;
           for j = 1:3 
               for k = 1:3 
                   if abs(Hdiff(j,k))>0.0001
                      k = 4;
                      j = 4;
                      kctsignal = 1;
                   end
               end
           end
           if kctsignal == 0
               R = Rtemp(i,1);
               i=5;
           end
    end
 
    try
        c_rpy= [coor',Y*180/pi,P*180/pi,R*180/pi];
    catch
        warning('Solution may be unfeseable, please check joint angles 4,5,6')
    end
    