%    KCTCHFRAME - Change the reference frame 
%
%    The function changes the reference frame of the robot. 
%    Default: base reference frame <x0,y0,z0>. New: user's defined frame <xw,yw,zw> 
%
%    Usage: kctchframe(H0w)
%
%    Arguments:
%       H0w  = homogeneous matrix defining the rigid motion between the base reference frame <x0,y0,z0>
%              and the new reference frame <xw,yw,zw>
%   
%    See also: KCTFKINE, KCTIKINE
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

function kctchframe(H0w)
    
    global kctptfr
    global kctrotfr
    load('kctrobotframe.mat');
    
    kctptfr = H0w(1:3,4)';
    kctrotfr = H0w(1:3,1:3);
    
    save('kctrobotframe.mat','kctptfr','kctrotfr');

 