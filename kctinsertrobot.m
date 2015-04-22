%    KCTINSERTROBOT - Add a model to kctrobotdata list. 
%
%    The function add a new model to the kctrobotdata list and update
%    automatically the kctrobotdata.mat file.
%
%    Usage: kctinsertrobot(kctname,kctlinks)
%
%    Arguments:
%       kctname  = string with the model name of the kuka robot
%       kctlinks = 1x6 vector with links length of the model. Read
%                  documentation about kctrobotdata before using 
%                  this function.
%
%    See also: KCTROBOT, KCTDELETEROBOT, KCTFINDROBOT
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


function kctinsertrobot(kctname,kctlinks)

if kctfindrobot(kctname) == 0
    krd = load('kctrobotdata.mat');

    kctrobotdata = krd.kctrobotdata;
    kctindex = length(kctrobotdata)+1;

    kctrobotdata(kctindex).name = kctname;

    kctrobotdata(kctindex).link1 = kctlinks(1);
    kctrobotdata(kctindex).link2 = kctlinks(2);
    kctrobotdata(kctindex).link3 = kctlinks(3);
    kctrobotdata(kctindex).link4 = kctlinks(4);
    kctrobotdata(kctindex).link5 = kctlinks(5);
    kctrobotdata(kctindex).link6 = kctlinks(6);

    save('kctrobotdata.mat','kctrobotdata');

    disp(['Model ',kctname,' added correctly.'])
else
    disp(['Model ',kctname,' already in kctrobotdata.mat.'])
end

