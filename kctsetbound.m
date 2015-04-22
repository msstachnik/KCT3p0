%    KCTSETBOUND - Set the robot's workspace bounds 
%
%    The function sets the workspace bounds of the robot. 
%
%    Usage:  kctsetbound(bound)
%
%    Arguments:
% 		bound =  2x6 matrix: the first row contains the min and max 
%                    values on the X,Y,Z coordinates (written in the base 
%                    frame of the robot) and the second row the min and max 
%                    values on the joint angles 4,5,6 (in degrees).
%                         
%    Example: bound = [ Xmin  Xmax  Ymin  Ymax  Zmin  Zmax;
%                      J4min J4max J5min J5max J6min J6max];
%                       
%                     kctsetbound(bound);
%
%    See also: KCTGETBOUND
%

%    Copyright (c) 2009 Francesco Chinello, Stefano Scheggi
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

function kctsetbound(kctworkspace)

    save('kctrobotbound.mat','kctworkspace');
    
    kctgetbound();
    
    