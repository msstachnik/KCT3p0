%    KCTFINDROBOT - Find a model in kctrobotdata list. 
%
%    The function find a model in the kctrobotdata.
%
%    Usage: bFound = kctfindrobot(kctname)
%
%    Arguments:
%       kctname  = string with the model name of the kuka robot
%
%    Return:
%        bFound = 1 if the robot is found, 0 elsewhere.
%
%    See also: KCTROBOT, KCTINSERTROBOT, KCTDELETEROBOT
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


function bFound = kctfindrobot(kctname)

krd = load('kctrobotdata.mat');

temp_kctrobotdata = krd.kctrobotdata;

bFound = 0;
for i = 1:size(temp_kctrobotdata,2)
    if(strcmp(temp_kctrobotdata(i).name, kctname) == 1)
        bFound = 1;
        return;
    end
end
