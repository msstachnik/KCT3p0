%    KCTROTOY - Return the homogeneous matrix for rotation about Y-axis
%
%    The function computes the homogeneous rotation matrix for rotation about Y-axis;
%    The rotation angle is in radians. 
%
%    Usage: H = kctrotoy(alpha)
%
%    Arguments:
% 	      alpha = y-axis rotation angle 
%
%    Return:
%             H = 4 x 4 homogeneous rotation matrix           
%             
%    See also: KCTROTOX, KCTROTOZ, KCTTRAN
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

function H = kctrotoy(alpha)

alpha = alpha*pi/180;

    H = [cos(alpha), 0,  sin(alpha),  0;
                 0, 1,           0,  0;
       -sin(alpha), 0,   cos(alpha),  0;
                 0, 0,           0,  1];
