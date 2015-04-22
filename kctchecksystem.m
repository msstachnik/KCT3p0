%    KCTCHECKSYSTEM - Check if the system requirements are satisfied
%
%    The function checks MATLAB version and if the Instrument Control 
%    Toolbox is installed properly.
%
%    Usage: [issystemok, foundmatlab, foundtoolbox] = kctchecksystem()
%             
%    Return:
%           issystemok = Boolean var (1 = ok, 0 = not ok)
%           foundmatlab = Matlab version is ok
%           foundtoolbox = Instrument Control Toolbox is ok
%

%    Copyright (c) 2009 Stefano Scheggi
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


function [issystemok, foundmatlab, foundtoolbox] = kctchecksystem()

    global kcttcpiptype;
    load('kcttcpiptype.mat');

    toolboxlist = ver();

    % Check Matlab version
    matlabversion = version();
    foundmatlab = 0;
    if matlabversion(1) >= 7
       foundmatlab = 1; 
       fprintf(' Matlab version %s.\n', matlabversion);
    end
    
    % Check if Instrument Control Toolbox is installed
    foundtoolbox = 0;
    for i = 1:size(toolboxlist,2)
        if strcmp(toolboxlist(i).Name, 'Instrument Control Toolbox') == 1 
            foundtoolbox = 1;
            display(' Instrument Control Toolbox found.');
            break;
        end
    end

    if foundmatlab == 0
        display(' Matlab version too old required 7.x or higher.');
        display(' Some KCT functions may not work properly.');
    end
    if foundtoolbox == 0
        display(' Instrument Control Toolbox not found.');
        display(' MEX functions will be used for the network communication.');
        kctsettcpip('MEX');
    end
    
    issystemok = and(foundmatlab, foundtoolbox);