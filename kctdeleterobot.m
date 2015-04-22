%    KCTDELETEROBOT - Delete a model from kctrobotdata list. 
%
%    The function delete model from the kctrobotdata list and update
%    automatically the kctrobotdata.mat file.
%
%    Usage: kctdeleterobot(kctname)
%
%    Arguments:
%       kctname  = string with the model name of the kuka robot
%
%    See also: KCTROBOT, KCTINSERTROBOT, KCTFINDROBOT
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


function kctdeleterobot(kctname)

krd = load('kctrobotdata.mat');

temp_kctrobotdata = krd.kctrobotdata;

bDelete = 0;
for i = 1:size(temp_kctrobotdata,2)
    if(strcmp(temp_kctrobotdata(i).name, kctname) == 1)
        bDelete = 1;
    end
    if (bDelete == 1) && i < size(temp_kctrobotdata,2)
        temp_kctrobotdata(i) = temp_kctrobotdata(i+1);
    end    
end

if bDelete == 1
    kctrobotdata = temp_kctrobotdata(1:(size(temp_kctrobotdata,2)-1));
    save('kctrobotdata.mat','kctrobotdata');
    disp(['Model ',kctname,' removed correctly.'])
else
    disp(['Model ',kctname,' not found.'])
end
