%    KCTROBOT - Display robots' info.
%
%    The function displays the information of all supported KUKA robots.
%
%    Usage: kctrobot()

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

function kctprobot()

    % Can't read the data structure
    if exist('kctrobotdata.mat') == 0
        display('kctrobotdata.mat not found.');
        return
    end
    
    % Reading the data structure
    load kctrobotdata;
    
    for i = 1:size(kctrobotdata,2)
        disp(['position: ', num2str(i)]);
        kctrobotdata(i)
    end
    
    
    
